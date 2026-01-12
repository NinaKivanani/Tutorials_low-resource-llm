# 🌍 Low-Resource Language Tutorials: LLMs for Everyone

**Welcome to the future of inclusive AI!** 🚀

This repository contains hands-on tutorials for working with Large Language Models (LLMs) and low-resource languages. Whether you're a researcher, developer, or student, these materials will help you build AI systems that work for *all* languages, not just English.

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/NinaKivanani/Tutorials_low-resource-llm/)

---

## 🎯 What You'll Learn

By the end of these tutorials, you'll be able to:

- ✅ **Evaluate any LLM for any language** - No more guessing if a model works for your language
- ✅ **Build multilingual AI systems** - Create tools that respect linguistic diversity
- ✅ **Handle low-resource scenarios** - Work effectively with limited data and resources
- ✅ **Identify and mitigate bias** - Build ethical AI that serves all communities fairly
- ✅ **Make informed technical decisions** - Choose the right approach for your specific needs

---

## 📚 Tutorial Series Overview

### 🌟 **Session 0: Getting Started** 
*Estimated time: 45 minutes*

**File:** `Session0_Orientation_and_Setup_LLMs_Low_Resource.ipynb`

Your orientation session! Get set up, choose your target language, and understand the learning journey ahead.

**What you'll do:**
- Set up your development environment
- Choose a low-resource language to focus on
- Understand the course structure and learning objectives
- Test that everything works with a simple example

**Perfect for:** Complete beginners, setting expectations

---

### 🔍 **Session 1: How LLMs "See" Languages**
*Estimated time: 90 minutes*

**File:** `1_dialogue_summarization_low_resource_workshop_v2.ipynb`

Discover why ChatGPT works better in English than in your language by exploring tokenization and model internals.

**What you'll do:**
- Compare how different models tokenize your target language
- Understand the connection between tokenization and performance
- Generate and visualize sentence embeddings across languages
- Document failure cases and understand their root causes

**Prerequisites:** Session 0 (recommended)
**Perfect for:** Understanding the "why" behind model performance

---

### 💬 **Session 2: Teaching LLMs New Tasks** 
*Coming Soon*

Master the art of prompt engineering for multilingual scenarios.

---

### 🎯 **Session 3: Customizing LLMs for Your Language**
*Coming Soon*

Learn when and how to fine-tune models for better performance.

---

### ⚖️ **Session 4: Responsible Multilingual AI**
*Coming Soon*

Build bias detection and fairness into your evaluation pipeline.

---

## 🚀 Quick Start Guide

### Option 1: Google Colab (Recommended for Beginners)

1. **Click the Colab badge above** or visit any notebook file and click "Open in Colab"
2. **Save a copy to your Drive:** File → Save a copy in Drive
3. **Start with Session 0:** `Session0_Orientation_and_Setup_LLMs_Low_Resource.ipynb`
4. **Follow the instructions** in each notebook

### Option 2: Local Setup

```bash
# 1. Clone the repository
git clone https://github.com/NinaKivanani/Tutorials_low-resource-llm.git
cd Tutorials_low-resource-llm

# 2. Create a virtual environment (recommended)
python -m venv llm-tutorials
source llm-tutorials/bin/activate  # On Windows: llm-tutorials\Scripts\activate

# 3. Install requirements (will be created as you work through tutorials)
pip install transformers datasets pandas matplotlib numpy scikit-learn

# 4. Start Jupyter
jupyter notebook
```

---

## 🎓 Who This Is For

### **🟢 Beginners Welcome!**
- No prior experience with LLMs required
- Basic Python knowledge helpful but not essential
- We explain every concept and provide extensive guidance

### **🟡 Intermediate Learners**
- Deepen your understanding of multilingual NLP
- Learn production-ready techniques for low-resource scenarios
- Gain hands-on experience with state-of-the-art tools

### **🔴 Advanced Practitioners**
- Discover cutting-edge approaches for multilingual AI
- Learn evaluation methodologies for bias and fairness
- Contribute to inclusive AI development

---

## 🌍 Language Focus

This course uses a **"choose your own adventure"** approach for language selection:

### **Supported Examples:**
- **European:** Luxembourgish, Irish, Maltese, Icelandic, Basque, Welsh
- **Global:** Your heritage language, regional languages, constructed languages
- **Default:** Luxembourgish (if you're unsure where to start)

### **Why Low-Resource Languages?**
- **6,900+ languages** exist worldwide, but most AI only works for ~100
- **Cultural preservation:** Language is identity, community, and heritage
- **Practical impact:** Millions of people need AI tools in their native languages
- **Technical challenge:** Limited data requires creative, principled approaches

---

## 📋 Prerequisites & Requirements

### **Software Requirements:**
- Python 3.7+ (Python 3.8+ recommended)
- Jupyter Notebook or Google Colab
- Git (for local setup)
- 4GB+ RAM (8GB+ recommended)

### **Hardware Requirements:**
- **CPU:** All tutorials work on CPU (may be slower for large models)
- **GPU:** Recommended for Sessions 2+ but not required
- **Storage:** ~2GB for models and datasets

### **Knowledge Prerequisites:**
- **Required:** Basic familiarity with Python
- **Helpful:** Understanding of lists, dictionaries, and functions
- **Not required:** Machine learning, deep learning, or NLP background

---

## 🛠️ Troubleshooting

### **Common Issues:**

**❌ "ModuleNotFoundError"**
```bash
# Solution: Install the missing package
pip install transformers  # or whatever package is missing
```

**❌ "CUDA out of memory"**
```python
# Solution: Use CPU instead of GPU
device = "cpu"  # Change from "cuda" to "cpu"
```

**❌ "Model download failed"**
```python
# Solution: Check internet connection and try a smaller model
model_name = "distilbert-base-multilingual-cased"  # Smaller alternative
```

**❌ Notebook won't run**
- Try: Kernel → Restart & Clear Output
- Or: Runtime → Restart Runtime (in Colab)

### **Getting Help:**

1. **Check the notebook comments** - We explain common issues inline
2. **Search the error message** - Stack Overflow often has solutions
3. **Ask questions during workshops** - Instructors are here to help!
4. **Open an issue** - Use GitHub Issues for persistent problems

---

## 📊 Expected Outcomes

### **By Session:**

**Session 0:** ✅ Working environment, chosen target language, clear expectations

**Session 1:** ✅ Tokenization comparison charts, embedding visualizations, documented failure cases

**Session 2:** ✅ Personal prompt library, cross-lingual prompting strategies

**Session 3:** ✅ Fine-tuned model OR decision framework for when to fine-tune

**Session 4:** ✅ Bias audit report, fairness evaluation framework

### **Overall Course:**
- 📊 **Portfolio of analysis** comparing models on your target language
- 🛠️ **Practical toolkit** for multilingual AI development  
- 🧠 **Strategic knowledge** of when to use which approaches
- ⚖️ **Ethical framework** for responsible AI development
- 🤝 **Community connections** with other multilingual AI practitioners

---

## 🎯 Learning Objectives (Academic)

This course addresses several key competencies:

### **Technical Skills:**
- Model evaluation and selection for multilingual tasks
- Tokenization analysis and optimization
- Cross-lingual transfer learning techniques
- Bias detection and mitigation strategies

### **Methodological Skills:**
- Systematic comparison of model architectures
- Documentation and reproducibility practices
- Experimental design for low-resource scenarios
- Evaluation metric selection and interpretation

### **Professional Skills:**
- Ethical AI development principles
- Cross-cultural sensitivity in technology design
- Communication of technical findings to diverse audiences
- Collaboration in interdisciplinary teams

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### **For Students:**
- 🐛 **Report bugs:** Found something that doesn't work? Let us know!
- 💡 **Suggest improvements:** Ideas for better explanations or examples?
- 🌍 **Add languages:** Created examples for a new language? Share them!
- 📝 **Improve documentation:** Spotted unclear instructions?

### **For Instructors:**
- 📚 **Curriculum feedback:** Suggestions for pedagogical improvements
- 🎯 **Learning objective alignment:** Help us meet educational standards
- 🔧 **Technical updates:** Keep pace with rapidly evolving field
- 🌐 **Localization:** Adapt materials for different cultural contexts

### **How to Contribute:**
1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-improvement`)
3. Make your changes
4. Test thoroughly (especially notebooks!)
5. Submit a pull request with clear description

---

## 📄 License & Citation

### **License:**
This work is licensed under **MIT License** - see [LICENSE](LICENSE) file for details.

### **Citation:**
If you use these materials in your research or teaching, please cite:

```bibtex
@misc{kivanani2026llm_tutorials,
  title={Low-Resource Language Tutorials: LLMs for Everyone},
  author={Nina Kivanani},
  year={2026},
  url={https://github.com/NinaKivanani/Tutorials_low-resource-llm},
  note={Educational materials for inclusive AI development}
}
```

### **Acknowledgments:**
- **COST Action:** Supporting European research collaboration
- **Unidive Winter School:** Providing educational framework
- **Hugging Face:** Open-source tools and model hosting
- **Community contributors:** Everyone who helps improve these materials

---

## 📞 Contact & Support

### **Primary Contact:**
- **Nina Kivanani** - Course Developer
- **Email:** [Insert contact email]
- **GitHub:** [@NinaKivanani](https://github.com/NinaKivanani)

### **Community Support:**
- **GitHub Issues:** Technical problems and bug reports
- **GitHub Discussions:** Questions, ideas, and community chat
- **Workshop Sessions:** Live support during scheduled events

### **Response Times:**
- **During workshops:** Immediate (instructors present)
- **GitHub issues:** 1-3 business days
- **Email inquiries:** 3-5 business days

---

## 🎉 Join the Movement

**You're not just learning about AI - you're helping build a more inclusive future.**

Every time you evaluate a model for a low-resource language, document a failure case, or share your findings, you're contributing to a global effort to make AI work for everyone, not just English speakers.

**Ready to start?** 👉 Begin with `Session0_Orientation_and_Setup_LLMs_Low_Resource.ipynb`

**Questions?** 👉 Open an issue or ask during the workshop

**Want to contribute?** 👉 See our Contributing section above

---

### 🌟 **Remember:** Every language matters. Every voice counts. Let's build AI that works for all of humanity. 🌟

---

*Last updated: January 2026*  
*Repository: https://github.com/NinaKivanani/Tutorials_low-resource-llm*
