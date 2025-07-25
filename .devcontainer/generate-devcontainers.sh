#!/bin/bash

# Define which Python versions you want
VERSIONS=('3.13' '3.12' '3.11' '3.10')

# Path to your template
TEMPLATE='.devcontainer/template.json'

echo "Generating devcontainer configurations..."

for version in "${VERSIONS[@]}"; do
    echo "generate devcontainer file for python version $version"
    # Create directory for this version
    target_dir="python-${version}"
    mkdir -p "$target_dir"

    # Replace PYTHON_VERSION placeholder with actual version
    PYTHON_VERSION="$version" envsubst < devcontainer_template.json > "${target_dir}/devcontainer.json"

    echo "✓ Created ${target_dir}/devcontainer.json"
done

echo "Done! Generated ${#VERSIONS[@]} devcontainer configurations."