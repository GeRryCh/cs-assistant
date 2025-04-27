#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Clean previous builds
echo "Cleaning previous builds..."
rm -rf dist/
rm -rf build/
rm -rf *.egg-info/

# Build the package
echo "Building the package..."
python -m build

# Upload to TestPyPI
echo "Uploading to TestPyPI..."
twine upload --repository testpypi dist/*

echo "Successfully packaged and uploaded to TestPyPI." 