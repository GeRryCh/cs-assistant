#!/bin/bash
set -e

# Script to initialize Python environment for CS Assistant
# This script creates a virtual environment and installs required packages

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up CS Assistant environment...${NC}"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo -e "${BLUE}Creating virtual environment...${NC}"
    python3 -m venv venv
else
    echo -e "${BLUE}Virtual environment already exists.${NC}"
fi

# Activate virtual environment
echo -e "${BLUE}Activating virtual environment...${NC}"
source venv/bin/activate

# Upgrade pip
echo -e "${BLUE}Upgrading pip...${NC}"
pip install --upgrade pip

# Install requirements
echo -e "${BLUE}Installing dependencies from requirements.txt...${NC}"
pip install -r requirements.txt

if [ ! -f ".env" ]; then
    echo -e "${BLUE}Creating .env file...${NC}"
    echo -e "OPENAI_API_KEY=your_openai_api_key_here" >> .env
    echo -e "GOOGLE_API_KEY=your_google_api_key_here" >> .env
    echo -e "ANTHROPIC_API_KEY=your_anthropic_api_key_here" >> .env
    echo -e "${GREEN}Created .env file with API keys.${NC}"
else
    echo -e "${BLUE}.env file already exists.${NC}"
fi

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}To activate the environment:${NC}"
echo -e "    source venv/bin/activate"
echo -e "${GREEN}To deactivate when done:${NC}"
echo -e "    deactivate" 