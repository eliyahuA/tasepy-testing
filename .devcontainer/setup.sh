#!/bin/bash
set -e

echo "Installing tasepy and other Python dependencies..."

if [[ -z "${TASEPY_TESTING_PYPI_INDEX}" || "${TASEPY_TESTING_PYPI_INDEX}" == "https://pypi.org/simple/" ]]; then
    python3 -m pip install tasepy==${TASEPY_VERSION}
else
    python3 -m pip install --extra-index-url ${TASEPY_TESTING_PYPI_INDEX} tasepy==${TASEPY_VERSION}
fi

python3 -m pip install -r requirements.txt

echo "clone tasepy release branch"
git clone -b release https://x-access-token:${GH_TASEPY_READONLY}@github.com/eliyahuA/tasepy.git

echo "Installing development dependencies..."
python3 -m pip install -r tasepy/dev-requirements.txt

echo "Run unit tests"
pytest tasepy/tests/unit

echo "Run selected integration test"
export API_KEY=$TASEPY_TESTING_WORKFLOW
# add variable for future terminal sessions
echo 'export API_KEY=$TASEPY_TESTING_WORKFLOW' >> ~/.bashrc
pytest tasepy/tests/integration/client/test_indices_online.py
