#!/bin/bash
set -e

echo "Installing tasepy and other Python dependencies..."
python3 -m pip install -r requirements.txt

echo "Authenticate with gh"
export GH_TOKEN="$GH_TASEPY_READONLY"
gh auth login
gh auth status

echo "clone tasepy"
git clone https://github.com/eliyahuA/tasepy-testing.git

echo "Installing development dependencies..."
