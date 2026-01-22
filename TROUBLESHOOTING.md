# 🔧 Session 3 Troubleshooting Guide

## Common Installation Issues and Fixes

This guide addresses the most common issues when running Session 3 notebook in Google Colab.

---

## Issue 1: PEFT Installation Failed ❌

**Error Message:**
```
❌ peft - CRITICAL ERROR
```

### What is PEFT and LoRA?

- **PEFT** = Parameter-Efficient Fine-Tuning (the library/framework)
- **LoRA** = Low-Rank Adaptation (a specific fine-tuning method)
- **Relationship**: LoRA is implemented INSIDE the PEFT library
- **Important**: You NEED PEFT installed to use LoRA

### Solution:

The notebook now has **3 automatic fallback methods** for installing PEFT:

1. **Standard pip install** (tried first)
2. **Install without version constraint** (if standard fails)
3. **Install from GitHub source** (most reliable, if others fail)

**If all automatic methods fail, manually run:**

```python
# In a new cell, run:
!pip uninstall peft transformers accelerate -y
!pip install transformers accelerate
!pip install git+https://github.com/huggingface/peft.git
```

**Then:**
1. Restart runtime: `Runtime → Restart Runtime`
2. Re-run the installation cell
3. Run the verification cell (Cell 5)

---

## Issue 2: Numpy Import Error ❌

**Error Message:**
```
ImportError: cannot import name '_center' from 'numpy._core.umath'
```

### What causes this?

This happens when:
- Numpy 2.x is installed (newer version)
- Other packages expect Numpy 1.x (older API)
- Version incompatibility between dependencies

### Solution:

**The notebook now prevents this automatically** by installing `numpy>=1.21.0,<2.0` (compatible version).

**If you still see this error:**

1. **Run the fix cell** (Cell 7 in the notebook):
   ```python
   # Cell 7 will automatically fix numpy
   ```

2. **Or manually fix:**
   ```python
   !pip install --upgrade --force-reinstall "numpy<2.0"
   ```

3. **Then restart runtime** and continue

---

## Issue 3: FlashAttention2 Error ⚡

**Error Message:**
```
FlashAttention2 has been toggled on, but it cannot be used due to the following error: 
the package flash_attn seems to be not installed.
```

### What is FlashAttention2?

- An **optimization** for faster attention computation
- **Not required** - just makes training faster
- Difficult to install in Colab (requires specific CUDA versions)

### Solution:

**The notebook now handles this automatically** by:
1. Trying to use FlashAttention2 if available
2. **Falling back to standard attention** if not installed
3. Still works perfectly, just slightly slower

**You don't need to do anything!** The model will load with standard attention.

**If you want to install FlashAttention2 (optional):**
```python
# Warning: This may fail in Colab
!pip install flash-attn --no-build-isolation
```

**Note:** Standard attention works fine for this tutorial. The speed difference is minimal for the small dataset we're using.

---

## Issue 4: CUDA/GPU Not Detected ⚠️

**Message:**
```
❌ No GPU detected
```

### Solution:

In Google Colab:
1. Go to `Runtime → Change runtime type`
2. Select `T4 GPU` (or any available GPU)
3. Click `Save`
4. Re-run all cells

**Note:** The notebook works on CPU too, but training will be 10-50x slower.

---

## Issue 5: FP16 Gradient Scaling Error 🔧

**Error Message:**
```
ValueError: Attempting to unscale FP16 gradients.
```

### What causes this?

This happens when training with:
- **FP16 (half precision)** enabled
- **LoRA/PEFT** adapters applied
- Gradient scaling conflicts between FP16 and LoRA

### Solution:

**The notebook now handles this automatically** by:
1. Checking if **BF16** (bfloat16) is supported → uses it (better for LoRA)
2. If not supported → uses **FP32** (full precision) for stability
3. **Avoids FP16** which causes gradient scaling issues with LoRA

**You don't need to do anything!** Cell 20 now automatically selects the best precision.

**Manual fix (if needed):**
```python
# In TrainingArguments (Cell 20), ensure:
training_args = TrainingArguments(
    ...
    bf16=torch.cuda.is_bf16_supported(),  # Use BF16 if available
    fp16=False,  # Disable FP16 to avoid gradient issues
    ...
)
```

**Performance impact:**
- BF16: Same speed as FP16, better stability ✅
- FP32: ~20% slower, maximum stability ✅
- FP16: Fast but causes errors with LoRA ❌

---

## Issue 6: CUDA Device-Side Assert Error During Generation 🚨

**Error Message:**
```
AcceleratorError: CUDA error: device-side assert triggered
```

### What causes this?

This error occurs during **model generation** (inference) after training, usually due to:
- **Token IDs out of vocabulary range** (invalid token IDs)
- **Missing pad_token_id or eos_token_id** configuration
- **Model config mismatch** after PEFT wrapping
- **Attention mask issues** during generation

### Solution:

**The notebook now handles this automatically** with:

1. **Robust generation configuration** (Cell 24):
   - Explicitly sets `pad_token_id` and `eos_token_id`
   - Proper padding and truncation
   - Error handling with try-except

2. **Pre-generation verification** (Cell 23):
   - Checks model and tokenizer configuration
   - Validates token ID ranges
   - Fixes missing configurations automatically

**Manual fix (if needed):**
```python
# Before generation, ensure:
peft_model.eval()  # Set to evaluation mode

# Verify tokenizer configuration
if tokenizer.pad_token_id is None:
    tokenizer.pad_token = tokenizer.eos_token
    peft_model.config.pad_token_id = tokenizer.pad_token_id

# Generate with explicit token IDs
outputs = peft_model.generate(
    **inputs,
    max_new_tokens=64,
    pad_token_id=tokenizer.pad_token_id,
    eos_token_id=tokenizer.eos_token_id,
    use_cache=True,
)
```

**If error persists:**
```python
# Try more conservative generation settings
outputs = peft_model.generate(
    **inputs,
    max_new_tokens=32,  # Reduce length
    do_sample=False,     # Disable sampling
    num_beams=1,         # Greedy decoding
    pad_token_id=tokenizer.pad_token_id,
    eos_token_id=tokenizer.eos_token_id,
)
```

---

## Issue 7: TrainingArguments Parameter Error 📝

**Error Message:**
```
TypeError: TrainingArguments.__init__() got an unexpected keyword argument 'evaluation_strategy'
```

### What causes this?

This happens due to **API changes in transformers library**:
- **Older versions** (<4.19): Use `evaluation_strategy`
- **Newer versions** (≥4.19): Use `eval_strategy`

The parameter was renamed for consistency with other parameters.

### Solution:

**The notebook now handles this automatically** by:
1. Trying `eval_strategy` first (newer versions)
2. Falling back to `evaluation_strategy` if that fails (older versions)
3. **Works with all transformers versions!**

**You don't need to do anything!** Cell 20 is now version-compatible.

**Manual fix (if needed):**

For **newer transformers** (4.19+):
```python
training_args = TrainingArguments(
    ...
    eval_strategy="epoch",  # New parameter name
    ...
)
```

For **older transformers** (<4.19):
```python
training_args = TrainingArguments(
    ...
    evaluation_strategy="epoch",  # Old parameter name
    ...
)
```

**Check your version:**
```python
import transformers
print(transformers.__version__)
```

---

## Issue 8: Out of Memory Error 💾

**Error:**
```
CUDA out of memory
```

### Solution:

1. **Reduce batch size** in training configuration (Cell 20):
   ```python
   per_device_train_batch_size=1,  # Reduce from 2 to 1
   per_device_eval_batch_size=1,   # Reduce from 2 to 1
   ```

2. **Reduce LoRA rank** (Cell 18):
   ```python
   r=4,  # Reduce from 8 to 4
   ```

3. **Restart runtime** to clear memory:
   - `Runtime → Restart Runtime`
   - Re-run cells

---

## Issue 9: Model Download Fails 🌐

**Error:**
```
OSError: Can't load model
```

### Solution:

1. **Check internet connection** in Colab
2. **Use alternative model** (edit Cell 6):
   ```python
   model_manager = ModelLoadingManager("microsoft/phi-2")
   # or
   model_manager = ModelLoadingManager("gpt2")
   ```

3. **Wait and retry** - Hugging Face servers may be temporarily busy

---

## Verification Checklist ✅

After installation, verify everything works:

| Step | Cell | What to Check | Status |
|------|------|---------------|--------|
| 1. System Check | Cell 2 | GPU detected ✅ | ☐ |
| 2. Package Install | Cell 3 | All packages ✅ | ☐ |
| 3. PEFT Verify | Cell 5 | PEFT imported ✅ | ☐ |
| 4. Imports Work | Cell 8 | No errors ✅ | ☐ |
| 5. Model Loads | Cell 9 | Model loaded ✅ | ☐ |
| 6. Training Config | Cell 20 | Precision selected ✅ | ☐ |
| 7. Training Runs | Cell 21 | No gradient errors ✅ | ☐ |
| 8. Model Verify | Cell 23 | Config validated ✅ | ☐ |
| 9. Generation Works | Cell 24 | No CUDA errors ✅ | ☐ |

---

## Quick Reference: Installation Order

The notebook installs packages in this **specific order** to avoid conflicts:

1. **Foundation**: `transformers`, `accelerate`
2. **PEFT**: `peft` (requires foundation packages)
3. **Data**: `numpy<2.0`, `pandas`, `matplotlib`, etc.
4. **Optional**: `wandb`, `tensorboard`, `psutil`

**Don't change this order** - it prevents dependency conflicts!

---

## Still Having Issues?

1. **Try the nuclear option** - Fresh start:
   ```python
   # Restart runtime
   # Then run ONLY these commands before running any cells:
   !pip uninstall peft transformers accelerate numpy -y
   !pip install transformers accelerate "numpy<2.0" peft
   ```

2. **Check your Colab runtime**:
   - Free tier: T4 GPU (sufficient for this tutorial)
   - If unavailable: Wait or use CPU mode

3. **Use a simpler model** for testing:
   ```python
   model_manager = ModelLoadingManager("gpt2")  # Much smaller
   ```

---

## Understanding the Fixes

### Why these specific versions?

- `numpy<2.0`: Ensures compatibility with older packages
- `transformers>=4.35.0`: Has required features for PEFT
- `accelerate>=0.23.0`: Required dependency for PEFT
- `peft>=0.6.0`: Has LoRA implementation we need

### Why restart runtime?

- Clears cached imports
- Frees GPU memory
- Ensures clean package state

---

## Success Metrics

You'll know everything is working when:

- ✅ Cell 3 shows: "INSTALLATION COMPLETE!"
- ✅ Cell 5 shows: "PEFT VERIFICATION SUCCESSFUL!"
- ✅ Cell 8 imports without errors
- ✅ Cell 9 loads model successfully
- ✅ You can run training (Cell 21)

---

## Common Misunderstandings

1. **"Should I use LoRA instead of PEFT?"**
   - ❌ Wrong question - LoRA IS part of PEFT
   - ✅ You need PEFT to use LoRA

2. **"Can I skip GPU and use CPU?"**
   - ✅ Yes, it will work
   - ⚠️ But training will be much slower

3. **"Why so many installation checks?"**
   - Google Colab has package conflicts
   - Multiple checks ensure robustness
   - Better than mysterious errors later!

---

## Contact

If you're still stuck:
1. Check if you followed ALL troubleshooting steps
2. Verify you're using Google Colab (not local Jupyter)
3. Try the "nuclear option" fresh start above
4. Check Colab runtime limits (free tier has usage caps)

---

**Last Updated:** 2026-01-22
**Notebook Version:** Session 3 - Fine-tuning LLMs for Low-Resource Languages
