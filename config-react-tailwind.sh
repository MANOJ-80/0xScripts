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

# --- HANDLE PROJECT NAME ---
if [ -n "$1" ]; then
  project_name=$1
else
  read -p "Enter project name: " project_name
fi

echo -e "${CYAN}${BOLD}🌐 Creating Vite + React project '${project_name}'...${RESET}"

# --- CREATE PROJECT WITHOUT PROMPTS ---
yes "n" | npm create vite@latest $project_name -- --template react

cd $project_name

# --- INSTALL DEPENDENCIES ---
echo -e "${YELLOW}📦 Installing dependencies...${RESET}"
npm install

# --- INSTALL TAILWIND + PLUGIN + COMMON PACKAGES ---
echo -e "${BLUE}🎨 Installing TailwindCSS, Vite plugin, and helper packages...${RESET}"
npm install -D tailwindcss @tailwindcss/vite
npm install react-dom axios dotenv classnames uuid

# --- UPDATE VITE CONFIG ---
echo -e "${MAGENTA}⚙️  Configuring vite.config.js with Tailwind plugin...${RESET}"
cat > vite.config.js <<EOL
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],
})
EOL

# --- CREATE TAILWIND ENTRY CSS ---
echo -e "${CYAN}💅 Creating Tailwind entry CSS...${RESET}"
cat > src/index.css <<EOL
@import "tailwindcss";
EOL

# --- REPLACE APP.JSX WITH DEMO ---
echo -e "${GREEN}🚀 Creating demo App.jsx with Tailwind setup...${RESET}"
cat > src/App.jsx <<EOL
function App() {
  return (
    <div className="flex items-center justify-center h-screen bg-gray-100">
      <h1 className="text-4xl font-bold text-blue-600">
        🚀 Vite + React + TailwindCSS Ready!
      </h1>
    </div>
  )
}
export default App;
EOL

# --- DONE ---
echo -e "${GREEN}${BOLD} Project '${project_name}' created successfully!${RESET}"
echo -e "${CYAN} Run '${BOLD}npm run dev${RESET}${CYAN}' to start your dev server.${RESET}"

# --- START DEV SERVER ---
npm run dev

