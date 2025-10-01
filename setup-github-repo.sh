#!/bin/bash
set -e

# --- COLORS & STYLES ---
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
RED="\e[31m"
BOLD="\e[1m"
RESET="\e[0m"

# --- DEFAULTS ---
repo_type="node"       # default gitignore type
license_type="MIT"     # default license
visibility="private"   # default repo visibility

# --- PARSE ARGUMENTS ---
while [[ $# -gt 0 ]]; do
  case $1 in
    --public) visibility="public"; shift ;;
    --private) visibility="private"; shift ;;
    --type) repo_type="$2"; shift 2 ;;
    --license) license_type="$2"; shift 2 ;;
    *) 
       if [ -z "$repo_name" ]; then
         repo_name=$1
       else
         repo_desc=$1
       fi
       shift
       ;;
  esac
done

# --- INTERACTIVE FALLBACK ---
if [ -z "$repo_name" ]; then
  read -p "Enter repository name: " repo_name
fi

if [ -z "$repo_desc" ]; then
  read -p "Enter description (optional): " repo_desc
fi

# --- DEFAULT DESCRIPTION ---
if [ -z "$repo_desc" ]; then
  repo_desc="Created with automation script"
fi

# --- CREATE GITHUB REPO ---
echo -e "${CYAN}${BOLD}🌐 Creating GitHub repo '${repo_name}' (${visibility})...${RESET}"
gh repo create "$repo_name" --"$visibility" --description "$repo_desc"

# --- CREATE LOCAL FOLDER ---
echo -e "${YELLOW}📂 Creating local folder and initializing git...${RESET}"
mkdir "$repo_name" && cd "$repo_name"
git init
echo "# $repo_name" > README.md

# --- ADD .GITIGNORE ---
if [ -n "$repo_type" ]; then
  echo -e "${BLUE}🌱 Adding .gitignore for $repo_type...${RESET}"
  curl -s https://raw.githubusercontent.com/github/gitignore/main/${repo_type^}.gitignore -o .gitignore || \
    echo -e "${RED}⚠️  .gitignore template not found, skipping.${RESET}"
fi

# --- ADD LICENSE ---
if [ -n "$license_type" ]; then
  echo -e "${MAGENTA}📜 Adding $license_type license...${RESET}"
  
  # Fetch license manually
  license_lower=$(echo "$license_type" | tr '[:upper:]' '[:lower:]')
  curl -s https://raw.githubusercontent.com/github/choosealicense.com/gh-pages/_licenses/${license_lower}.txt -o LICENSE || \
    echo -e "${RED}⚠️ License not added.${RESET}"
fi

# --- INITIAL COMMIT ---
echo -e "${YELLOW}📝 Creating initial commit...${RESET}"
git add .
git commit -m "Initial commit"

# --- SET REMOTE & PUSH ---
echo -e "${CYAN}🚀 Setting remote and pushing to GitHub...${RESET}"
git branch -M main
git remote add origin https://github.com/$(gh api user --jq .login)/$repo_name.git
git push -u origin main

# --- DONE ---
echo -e "${GREEN}${BOLD} GitHub repo '${repo_name}' created and linked locally!${RESET}"
echo -e "${CYAN} cd $repo_name${RESET}"

