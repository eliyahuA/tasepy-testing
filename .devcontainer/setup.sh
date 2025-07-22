#!/bin/bash
set -e

echo "Installing tasepy and other Python dependencies..."
python3 -m pip install -r requirements.txt

echo "clone tasepy"
git git clone https://x-access-token:${GH_TASEPY_READONLY}@github.com/eliyahuA/tasepy.git

echo "Switch to 'to be tested' branch"
(cd tasepy; git checkout alpha-release)

echo "Installing development dependencies..."
python3 -m pip install -r tasepy/dev-requirements.txt

echo "Run unit tests"
pytest tasepy/tests/unit

echo "Run selected integration test"
pytest tasepy/tests/integration/client/test_indices_online.py
