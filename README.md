# 🤖 Automation Scripts

This repository contains a collection of **automation scripts** to speed up your development workflow.  
Currently included:

1. **React + Tailwind Setup** – Quickly scaffold a Vite + React project with TailwindCSS and essential frontend packages.  
2. **GitHub Repo Creation** – Automatically create a GitHub repository, initialize a local git repository, add `.gitignore` and LICENSE, and push the initial commit.

---

## 📋 Features

### GitHub Repo Creation

- Create GitHub repository (public or private)
- Initialize local git repository
- Add `.gitignore` (Node, Python, React, etc.)
- Add LICENSE (MIT, Apache, GPL)
- Push initial commit to GitHub
- Colorful, emoji-rich terminal output
- Fully argument-driven or interactive
### React + Tailwind Setup

- Fully automated Vite + React project creation
- TailwindCSS installed and configured
- Common frontend packages pre-installed:
  - `react-dom`, `axios`, `dotenv`, `classnames`, `uuid`
- Vite config updated automatically to include Tailwind plugin
- Tailwind entry CSS (`src/index.css`) created
- Demo `App.jsx` with Tailwind classes
- Colorful, emoji-rich terminal output
- Supports both interactive and non-interactive modes



---

## ⚡ Usage

### 1. Clone this repo

```bash
git clone https://github.com/MANOJ-80/Automation-Scripts.git
cd Automation-Scripts
```

### 2. Make scripts executable
```bash
chmod +x config-react-tailwind.sh
chmod +x config-github-advanced.sh
```

### 3. Run scripts
### ⚙️ GitHub Repo Creation

Non-interactive:
```bash
./config-github-advanced.sh my-new-repo --public --type react --license MIT
```

Interactive:
```bash
./config-github-advanced.sh
```

### 🎨 React + Tailwind

Non-interactive:
```bash
./config-react-tailwind.sh my-app
```

Interactive:
```bash
./config-react-tailwind.sh
```


## 🛠️ Requirements
```
Node.js >= 18
npm
Bash (Linux / macOS / WSL)
GitHub CLI (gh) authenticated for GitHub repo creation script
```

## 🤝 Contributing
Contributions are welcome! Feel free to fork the repo and submit a pull request.

## 📜 License
This project is licensed under the [MIT License](LICENSE).

## 📩 Contact
For any queries, reach out to:
- **GitHub**: [MANOJ-80](https://github.com/MANOJ-80)
