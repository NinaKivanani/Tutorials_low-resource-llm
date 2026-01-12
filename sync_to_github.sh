#!/bin/bash

# Automatic sync script for Low-Resource LLM Tutorials repository
# Usage: ./sync_to_github.sh [commit_message] [--force] [--dry-run]
# 
# Features:
#   - Automatic Git LFS setup for large notebook outputs and model files
#   - Educational content organization and validation
#   - Safe push with large file handling
#   - Student-friendly error messages
# 
# Examples:
#   ./sync_to_github.sh "Updated Session 0 with better explanations"
#   ./sync_to_github.sh "Added new multilingual tokenization examples"
#   ./sync_to_github.sh --dry-run  # Preview changes without committing
#
# Prerequisites:
#   - Git LFS recommended for large files (sudo apt install git-lfs)
#   - Standard Git installation

# Parse arguments
FORCE_PUSH=false
DRY_RUN=false
COMMIT_MSG=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --force)
            FORCE_PUSH=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            if [ -z "$COMMIT_MSG" ]; then
                COMMIT_MSG="$1"
            fi
            shift
            ;;
    esac
done

# Set default commit message if none provided
if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Updated low-resource LLM tutorials: $(date '+%Y-%m-%d %H:%M')"
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Display mode
if [ "$DRY_RUN" = true ]; then
    echo -e "${CYAN}🧪 DRY RUN MODE - No changes will be made${NC}"
fi

echo -e "${YELLOW}🔄 Starting sync to Low-Resource LLM Tutorials repository...${NC}"

# Check and setup Git LFS (optional - only needed for large model files)
echo -e "${BLUE}🔍 Checking Git LFS setup...${NC}"
GIT_LFS_AVAILABLE=false
if command -v git-lfs &> /dev/null; then
    GIT_LFS_AVAILABLE=true
    echo -e "${GREEN}✅ Git LFS is installed${NC}"
    
    # Initialize LFS if not already done
    if [ ! -f ".gitattributes" ] || ! grep -q "*.pkl\|*.pt\|*.pth" .gitattributes 2>/dev/null; then
        echo -e "${YELLOW}🔧 Setting up Git LFS for large model files and outputs...${NC}"
        if [ "$DRY_RUN" = false ]; then
            git lfs install
            git lfs track "*.pkl"      # Pickle files (model outputs)
            git lfs track "*.pt"       # PyTorch model files
            git lfs track "*.pth"      # PyTorch model checkpoints
            git lfs track "*.bin"      # Binary model files
            git lfs track "*.h5"       # HDF5 model files
            git lfs track "*.model"    # Generic model files
            git lfs track "*.zip"      # Compressed archives
            echo -e "${GREEN}✅ Git LFS configured for large model files${NC}"
        else
            echo -e "${CYAN}🧪 DRY RUN: Would setup Git LFS tracking${NC}"
        fi
    else
        echo -e "${GREEN}✅ Git LFS already configured${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Git LFS not installed (optional)${NC}"
    echo -e "${YELLOW}💡 Git LFS is recommended for large model files (>100MB)${NC}"
    echo -e "${YELLOW}   Install with: brew install git-lfs (macOS) or sudo apt install git-lfs (Linux)${NC}"
    echo -e "${YELLOW}   For now, continuing without LFS...${NC}"
fi

# Check for educational content structure
echo -e "${BLUE}🔍 Validating tutorial structure...${NC}"
TUTORIAL_FILES=0
if [ -f "Session0_Orientation_and_Setup_LLMs_Low_Resource.ipynb" ]; then
    TUTORIAL_FILES=$((TUTORIAL_FILES + 1))
fi
if [ -f "0_multilingual_tokenization_embeddings_setup.ipynb" ]; then
    TUTORIAL_FILES=$((TUTORIAL_FILES + 1))
fi
if [ -f "1_dialogue_summarization_low_resource_workshop_v2.ipynb" ]; then
    TUTORIAL_FILES=$((TUTORIAL_FILES + 1))
fi

if [ $TUTORIAL_FILES -gt 0 ]; then
    echo -e "${GREEN}✅ Found $TUTORIAL_FILES tutorial notebook(s)${NC}"
else
    echo -e "${YELLOW}⚠️  No tutorial notebooks found in current directory${NC}"
fi

# Setup .gitignore for Jupyter notebooks and Python
if [ ! -f ".gitignore" ]; then
    echo -e "${YELLOW}📝 Creating .gitignore for Python/Jupyter project...${NC}"
    if [ "$DRY_RUN" = false ]; then
        cat > .gitignore << 'EOF'
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Jupyter Notebook checkpoints
.ipynb_checkpoints/

# PyTorch model files (use LFS instead)
*.pt
*.pth

# Large data files
*.pkl
*.bin

# IDE files
.vscode/
.idea/

# OS files
.DS_Store
Thumbs.db

# Virtual environments
venv/
env/
.env

# Output directories
outputs/
results/
models/
session*_outputs/

# Excluded notebook files
0_multilingual_tokenization_embeddings_setup.ipynb
0_Setup.ipynb
EOF
        echo -e "${GREEN}✅ Created .gitignore${NC}"
    else
        echo -e "${CYAN}🧪 DRY RUN: Would create .gitignore${NC}"
    fi
fi

# Check for large files and LFS status
echo -e "${BLUE}🔍 Checking for large files...${NC}"
LARGE_FILES=$(find . -name "*.pkl" -o -name "*.pt" -o -name "*.pth" -o -name "*.bin" -o -name "*.h5" -o -name "*.model" | grep -v ".git" | head -5)
NOTEBOOK_FILES=$(find . -name "*.ipynb" | grep -v ".git" | head -10)

if [ ! -z "$LARGE_FILES" ]; then
    echo -e "${GREEN}📦 Found large model files (will be tracked with LFS):${NC}"
    echo "$LARGE_FILES"
fi

if [ ! -z "$NOTEBOOK_FILES" ]; then
    echo -e "${GREEN}📓 Found tutorial notebooks:${NC}"
    echo "$NOTEBOOK_FILES" | head -5
    NOTEBOOK_COUNT=$(echo "$NOTEBOOK_FILES" | wc -l)
    if [ $NOTEBOOK_COUNT -gt 5 ]; then
        echo "   ... and $((NOTEBOOK_COUNT - 5)) more notebooks"
    fi
fi

# Check notebook sizes to warn about large outputs
LARGE_NOTEBOOKS=$(find . -name "*.ipynb" -size +5M | head -3)
if [ ! -z "$LARGE_NOTEBOOKS" ]; then
    echo -e "${YELLOW}⚠️  Warning: Found large notebook files (>5MB):${NC}"
    echo "$LARGE_NOTEBOOKS"
    echo -e "${YELLOW}💡 Consider clearing outputs: Kernel → Restart & Clear Output${NC}"
fi

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Error: Not in a git repository${NC}"
    echo -e "${YELLOW}💡 Initializing git repository...${NC}"
    git init
    echo -e "${YELLOW}💡 Please set up your remote repository URL manually:${NC}"
    echo -e "${YELLOW}   git remote add origin https://github.com/NinaKivanani/Tutorials_low-resource-llm.git${NC}"
    echo -e "${YELLOW}💡 Then run this script again.${NC}"
    exit 1
fi

# Check if remote exists
if ! git remote get-url origin >/dev/null 2>&1; then
    echo -e "${RED}❌ Error: No remote repository configured${NC}"
    echo -e "${YELLOW}💡 Please add your remote repository:${NC}"
    echo -e "${YELLOW}   git remote add origin https://github.com/NinaKivanani/Tutorials_low-resource-llm.git${NC}"
    exit 1
fi

# Check current branch (default to main)
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
if [ -z "$CURRENT_BRANCH" ]; then
    CURRENT_BRANCH="main"
fi

# Check for untracked files and changes
UNTRACKED_FILES=$(git ls-files --others --exclude-standard)
HAS_CHANGES=false

# Check if there are any commits yet
if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
    # No commits yet - check for untracked files
    if [ ! -z "$UNTRACKED_FILES" ]; then
        HAS_CHANGES=true
        echo -e "${YELLOW}📝 New repository detected with untracked files${NC}"
    fi
else
    # Has commits - check for both changes and untracked files
    if ! git diff --quiet || ! git diff --cached --quiet || [ ! -z "$UNTRACKED_FILES" ]; then
        HAS_CHANGES=true
    fi
fi

if [ "$HAS_CHANGES" = false ]; then
    echo -e "${YELLOW}ℹ️  No changes detected. Nothing to commit.${NC}"
    
    # Still try to push in case there are unpushed commits
    echo -e "${YELLOW}🔍 Checking for unpushed commits...${NC}"
    if git log origin/$CURRENT_BRANCH..HEAD --oneline 2>/dev/null | grep -q .; then
        echo -e "${YELLOW}📤 Found unpushed commits. Pushing...${NC}"
        if [ "$DRY_RUN" = false ]; then
            echo -e "${YELLOW}📤 Pushing tutorial content...${NC}"
            if [ "$GIT_LFS_AVAILABLE" = true ]; then
                git lfs push origin $CURRENT_BRANCH
            fi
            git push origin $CURRENT_BRANCH
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ Successfully pushed unpushed commits!${NC}"
            else
                echo -e "${RED}❌ Failed to push unpushed commits${NC}"
                exit 1
            fi
        else
            echo -e "${CYAN}🧪 DRY RUN: Would push unpushed commits${NC}"
        fi
    else
        echo -e "${GREEN}✅ Repository is up to date!${NC}"
    fi
    exit 0
fi

# Show what will be committed
echo -e "${YELLOW}📋 Changes to be committed:${NC}"
git status --short

# Add all changes (respecting .gitignore)
echo -e "${YELLOW}📦 Adding changes...${NC}"
if [ "$DRY_RUN" = false ]; then
    # Add .gitattributes first if it was created
    if [ -f ".gitattributes" ]; then
        git add .gitattributes
        echo -e "${GREEN}✅ Added Git LFS configuration${NC}"
    fi
    
    # Add all other changes
    git add .
else
    echo -e "${CYAN}🧪 DRY RUN: Would add all changes including DVC files${NC}"
fi

# Commit changes
echo -e "${YELLOW}💾 Committing with message: '${COMMIT_MSG}'${NC}"
if [ "$DRY_RUN" = false ]; then
    git commit -m "$COMMIT_MSG"
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Failed to commit changes${NC}"
        exit 1
    fi
else
    echo -e "${CYAN}🧪 DRY RUN: Would commit with message: '${COMMIT_MSG}'${NC}"
fi

# Push to GitHub
echo -e "${YELLOW}📤 Pushing to GitHub...${NC}"
if [ "$DRY_RUN" = false ]; then
    # Always fetch first to check remote state
    echo -e "${YELLOW}🔍 Checking remote repository state...${NC}"
    git fetch origin $CURRENT_BRANCH 2>/dev/null
    
    # Check if remote has commits we don't have
    REMOTE_HAS_COMMITS=false
    if git rev-parse --verify origin/$CURRENT_BRANCH >/dev/null 2>&1; then
        if git log HEAD..origin/$CURRENT_BRANCH --oneline 2>/dev/null | grep -q .; then
            REMOTE_HAS_COMMITS=true
        fi
    fi
    
    # Check if we have commits remote doesn't have
    LOCAL_HAS_COMMITS=false
    if git rev-parse --verify HEAD >/dev/null 2>&1; then
        if [ -z "$(git rev-parse --verify origin/$CURRENT_BRANCH 2>/dev/null)" ] || \
           git log origin/$CURRENT_BRANCH..HEAD --oneline 2>/dev/null | grep -q .; then
            LOCAL_HAS_COMMITS=true
        fi
    fi
    
    UPSTREAM_EXISTS=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
    
    if [ "$REMOTE_HAS_COMMITS" = true ]; then
        # Remote has content we don't have - need to merge first
        echo -e "${YELLOW}⚠️  Remote repository has commits we don't have locally.${NC}"
        echo -e "${YELLOW}   This usually happens when GitHub creates an initial README or license.${NC}"
        
        if [ "$FORCE_PUSH" = true ]; then
            echo -e "${RED}🚨 Force push enabled - overwriting remote (dangerous!)${NC}"
            if [ "$GIT_LFS_AVAILABLE" = true ]; then
                git lfs push origin $CURRENT_BRANCH --force
            fi
            git push --force origin $CURRENT_BRANCH
            if [ -z "$UPSTREAM_EXISTS" ]; then
                git branch --set-upstream-to=origin/$CURRENT_BRANCH $CURRENT_BRANCH
            fi
        else
            echo -e "${YELLOW}📥 Pulling remote changes first (using merge strategy)...${NC}"
            git pull origin $CURRENT_BRANCH --no-rebase --allow-unrelated-histories
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✅ Successfully merged remote changes. Now pushing...${NC}"
                echo -e "${YELLOW}📤 Pushing tutorial content...${NC}"
                if [ "$GIT_LFS_AVAILABLE" = true ]; then
                    git lfs push origin $CURRENT_BRANCH
                fi
                if [ -z "$UPSTREAM_EXISTS" ]; then
                    git push -u origin $CURRENT_BRANCH
                else
                    git push origin $CURRENT_BRANCH
                fi
            else
                echo -e "${RED}❌ Failed to merge. You may have conflicts.${NC}"
                echo -e "${YELLOW}💡 Options:${NC}"
                echo -e "${YELLOW}   1. Resolve conflicts manually, then run this script again${NC}"
                echo -e "${YELLOW}   2. Use --force flag to overwrite remote (⚠️  will lose remote changes!)${NC}"
                exit 1
            fi
        fi
    elif [ "$LOCAL_HAS_COMMITS" = true ]; then
        # We have commits to push
        echo -e "${YELLOW}📤 Pushing tutorial content...${NC}"
        if [ "$GIT_LFS_AVAILABLE" = true ]; then
            git lfs push origin $CURRENT_BRANCH
        fi
        if [ -z "$UPSTREAM_EXISTS" ]; then
            git push -u origin $CURRENT_BRANCH
        else
            git push origin $CURRENT_BRANCH
        fi
    else
        echo -e "${GREEN}✅ Local and remote are in sync. Nothing to push.${NC}"
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Successfully synced to Low-Resource LLM Tutorials repository!${NC}"
        echo -e "${GREEN}🌐 View at: $(git remote get-url origin)${NC}"
        
        # Show summary
        echo -e "${BLUE}📊 Sync Summary:${NC}"
        echo -e "   📝 Commit: ${COMMIT_MSG}"
        echo -e "   🌿 Branch: ${CURRENT_BRANCH}"
        echo -e "   📅 Time: $(date '+%Y-%m-%d %H:%M:%S')"
        echo -e "   📦 LFS: $([ -f '.gitattributes' ] && echo 'Enabled for large files' || echo 'Not configured')"
        echo -e "   📓 Notebooks: $(find . -name '*.ipynb' | grep -v '.git' | wc -l | tr -d ' ') tutorial files"
        
        # Show recent commits
        echo -e "${BLUE}📜 Recent commits:${NC}"
        git log --oneline -3
    else
        echo -e "${RED}❌ Failed to push to GitHub${NC}"
        echo -e "${YELLOW}💡 You may need to pull first if there are remote changes${NC}"
        echo -e "${YELLOW}💡 Try: git pull origin $CURRENT_BRANCH --rebase${NC}"
        echo -e "${YELLOW}💡 Or use --force flag for force push (dangerous!)${NC}"
        exit 1
    fi
else
    echo -e "${CYAN}🧪 DRY RUN: Would push to GitHub (including LFS files)${NC}"
    echo -e "${CYAN}📊 Summary of what would happen:${NC}"
    echo -e "   📝 Commit: ${COMMIT_MSG}"
    echo -e "   🌿 Branch: ${CURRENT_BRANCH}"
    echo -e "   📅 Time: $(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "   📹 LFS files would be pushed separately"
fi