![UniDive logo](a-modern-flat-illustration-depicting-a-d_cgGfscxgQJq2vN1b9R0Z2A_29ksyDnrQs-W7FiqosLasQ%20(1).png)

# UniDive Winter School. Hands-on Sessions (LLMs and Low-Resource NLP)

This folder contains the hands-on notebooks for the UniDive Winter School training on low-resource NLP and large language models. The practical sessions move from setup and multilingual analysis to dialogue summarization, prompt engineering, lightweight fine tuning, and bias auditing.

UniDive Training School page. [2nd UniDive Training School](https://unidive.lisn.upsaclay.fr/doku.php?id=meetings:other-events:2nd_unidive_training_school)  
Course proposal. [LLMs for Low-Resourced Languages (PDF)](https://unidive.lisn.upsaclay.fr/lib/exe/fetch.php?media=meetings:other-events:2nd-training-school:hosseini-anastasiou-llms-for-low-resourced-languages.pdf)

## Trainers

- [Nina Hosseini Kivanani](https://www.linkedin.com/in/ninahkivanani) (RTL and University of Luxembourg)  
- [Dimitra Anastasiou](https://www.linkedin.com/in/dimitraanastasiou/) (Luxembourg Institute of Science and Technology, LIST)

## Session overview

| # | Title                                               | Focus                                                        | Notebook file                                                | Slides file                                          |
|---|-----------------------------------------------------|--------------------------------------------------------------|--------------------------------------------------------------|------------------------------------------------------|
| 0 | Orientation and setup                               | Environment check, language selection, evaluation template   | [Session0_Orientation_and_Setup_LLMs_Low_Resource.ipynb](Session0_Orientation_and_Setup_LLMs_Low_Resource.ipynb)     | `-----`          |
| 1 | LLM Foundations and Analysis                        | Tokenization, embeddings, multilingual model comparison      | [Session1_Foundations_of_Large_Language_Models.ipynb](Session1_Foundations_of_Large_Language_Models.ipynb)   | [Session1__Foundations_of_Large_Language_Models.pdf](slides/Session1__Foundations_of_Large_Language_Models.pdf) |
| 2 | Prompt engineering                                  | Prompt patterns, multilingual prompting, error analysis      | [Session2_prompt_engineering.ipynb](Session2_prompt_engineering.ipynb)                          | [Session2_prompt_engineering.pdf](slides/Session2_prompt_engineering.pdf)             |
| 3 | Fine tuning LLMs for low resource languages         | Lightweight adaptation, training recipes, practical tips     | [Session3_Fine_tuning_LLMs_for_Low_Resource.ipynb](Session3_Fine_tuning_LLMs_for_Low_Resource.ipynb)           | [Session3_Fine_Tuning_LLMs_Low_Resource.pdf](-----)  |
| 4 | Bias audit                                          | Bias probing, stereotype prompts, simple audit protocol      | [Session4_Bias_Audit.ipynb](Session4_Bias_Audit.ipynb)                                  | [Session4_Bias_Audit.pdf](-----)                     |
| Info | HF & Google AI Token Setup                         | Authentication tokens for model access                       | [HuggingFace_GoogleAI_Token_Setup.md](Info_hf_googleai/HuggingFace_GoogleAI_Token_Setup.md) | `-----` |


## What you will learn

Across the full track, participants will.

- explore multilingual tokenization and sentence embeddings across different LLM architectures
- understand LLM foundations: how models process text and create representations
- practice prompt engineering patterns and simple evaluation protocols  
- experiment with fine tuning and parameter efficient adaptation strategies  
- design and run a small scale bias and safety audit

## How to use the materials

You can run the notebooks in Google Colab or locally.

- **Colab (recommended).**  
  - open the notebook from this repository  
  - enable GPU in `Runtime → Change runtime type → Hardware accelerator → GPU` when needed  

- **Local Jupyter.**  
  - install Python 3 and Jupyter  
  - install dependencies listed in the notebooks (or in a separate `requirements.txt`)  
  - run `jupyter lab` or `jupyter notebook` and open the corresponding `.ipynb` file  

Each notebook is self contained and includes its own setup cell at the top.  
For a first run, execute all cells in order from top to bottom.

### Token Setup for Model Access

Some notebooks require access to Hugging Face models and Google AI Studio. For detailed instructions on setting up authentication tokens, see:

📋 **[HuggingFace & Google AI Token Setup Guide](Info_hf_googleai/HuggingFace_GoogleAI_Token_Setup.md)**

This guide covers:
- Creating Hugging Face access tokens
- Setting up tokens in Google Colab, Google AI Studio, and Jupyter environments
- Security best practices for token management

## Prerequisites

- A laptop with stable internet access  
- A Google account for Colab or a local Python 3 environment  
- Basic familiarity with Python and Jupyter notebooks  
- Optional. prior exposure to NLP is helpful but not required

---

If you need help with installation or running a specific session, please contact the organizers or open an issue in this repository.


---

<sub><em>Logo illustration generated with an AI image model.</em></sub>