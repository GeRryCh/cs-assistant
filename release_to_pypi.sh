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

# Confirm before uploading to PyPI
echo ""
echo "Package built successfully. Ready to upload to PyPI (production)."
echo "This action will make the package publicly available on PyPI."
read -p "Do you want to continue? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Upload to PyPI
    echo "Uploading to PyPI (production)..."
    twine upload dist/*
    
    echo "Successfully packaged and uploaded to PyPI."
    echo "Package is now available via: pip install cs-assistant"
else
    echo "Upload cancelled."
fi