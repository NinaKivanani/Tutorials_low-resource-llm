# Hugging Face Token Setup Guide

## Overview

This guide provides step-by-step instructions for creating and using Hugging Face (HF) access tokens. These tokens are essential for accessing Hugging Face models, datasets, and other resources programmatically.

## What is a Hugging Face Token?

A Hugging Face token is a unique authentication key that allows you to:
- Download models and datasets from the Hugging Face Hub
- Upload your own models and datasets
- Access private repositories
- Use Hugging Face services through their API

## Steps to Create a Token

### 1. Log in to Hugging Face
- Go to [huggingface.co](https://huggingface.co)
- Sign into your account (create one if you don't have it)

### 2. Navigate to Settings
- Click on your **profile picture** in the top-right corner
- Select **Settings** from the dropdown menu

### 3. Access Tokens
- In the left-hand menu, click on **Access Tokens**

### 4. Create New Token
- Click the **"+ Create new token"** button

### 5. Configure Token Details
- **Name**: Enter a descriptive name for your token (e.g., "HF_TOKEN", "Workshop_Token", "Research_Project")
- **Role**: Select the appropriate permission level:
  - **Read**: For downloading models and datasets (recommended for most use cases)
  - **Write**: For uploading models, creating repositories, or modifying content

### 6. Generate Token
- Click **"Generate a token"**

### 7. Save Your Token
- **Important**: Copy the token immediately and store it securely
- The token will **NOT** be shown again after you close this page
- Consider storing it in a password manager or secure note-taking app

## How to Use the Token

### Method 1: CLI Login (Recommended)
```bash
huggingface-cli login
```
- Paste your token when prompted
- This method stores the token securely on your system

### Method 2: Python Code
```python
from transformers import AutoTokenizer, AutoModel

# Option A: Direct token usage
tokenizer = AutoTokenizer.from_pretrained("model-name", token="hf_your_token_here")
model = AutoModel.from_pretrained("model-name", token="hf_your_token_here")

# Option B: Using environment variable (recommended)
import os
os.environ["HF_TOKEN"] = "hf_your_token_here"

# Then use without specifying token explicitly
tokenizer = AutoTokenizer.from_pretrained("model-name")
model = AutoModel.from_pretrained("model-name")
```

### Method 4: Google Colab
1. Open your Colab notebook
2. Click the **key icon** (🔑) in the left sidebar to access "Secrets"
3. Click **"+ Add new secret"**
4. Set the name as `HF_TOKEN`
5. Paste your token as the value
6. In your code, access it with:

```python
from google.colab import userdata
hf_token = userdata.get('HF_TOKEN')

# Use in your model loading
from transformers import AutoTokenizer
tokenizer = AutoTokenizer.from_pretrained("model-name", token=hf_token)
```

### Method 5: Google AI Studio
1. Open [Google AI Studio](https://aistudio.google.com)
2. In your notebook or project settings, look for **"Secrets"** or **"Environment Variables"**
3. Add a new secret with:
   - **Key**: `HF_TOKEN`
   - **Value**: Your Hugging Face token
4. In your code, access it with:
```python
import os
hf_token = os.getenv('HF_TOKEN')

# Use in your model loading
from transformers import AutoTokenizer
tokenizer = AutoTokenizer.from_pretrained("model-name", token=hf_token)
```

### Method 6: Jupyter Notebooks
```python
import getpass
import os

# Prompt for token (secure input)
hf_token = getpass.getpass("Enter your HF token: ")
os.environ["HF_TOKEN"] = hf_token

# Now use normally
from transformers import AutoTokenizer
tokenizer = AutoTokenizer.from_pretrained("model-name")
```

## Security Best Practices

### ✅ DO:
- Store tokens securely (password managers, environment variables)
- Use Read-only tokens when possible
- Create separate tokens for different projects
- Regularly rotate/regenerate tokens

### ❌ DON'T:
- Share tokens publicly (GitHub, forums, etc.)

## Troubleshooting

### Common Issues:
1. **"Invalid token" error**: Check if token was copied correctly (no extra spaces)
2. **"Permission denied"**: Ensure token has appropriate permissions (Read/Write)
3. **"Token expired"**: Regenerate a new token from Hugging Face settings

### Token Testing:
```python
from huggingface_hub import HfApi

api = HfApi()
try:
    user_info = api.whoami(token="your_token_here")
    print(f"Token is valid! Logged in as: {user_info['name']}")
except Exception as e:
    print(f"Token error: {e}")
```

## Additional Resources

- [Hugging Face Documentation](https://huggingface.co/docs)
- [Transformers Library Documentation](https://huggingface.co/docs/transformers)
- [Hugging Face Hub API](https://huggingface.co/docs/huggingface_hub)


---
*Created for the UniDive Winter School on Large Language Models for Low-Resource Languages*