#!/bin/bash

# The following repositories are private, so they need to be added as submodules under the third_party directory.
# To use them as Python modules, you need to install them by executing the provided Shell script.
# This script will handle copying the submodules to the appropriate locations and installing them as Python packages.

# Define source directories
SOURCE_LAB="$HSRLAB_PATH/source/hsrlab"
SOURCE_ASSETS="$HSRLAB_PATH/source/hsrlab_assets"
SOURCE_RL="$HSRLAB_PATH/source/hsrlab_rl"
SOURCE_SCENES="$HSRLAB_PATH/source/hsrlab_scenes"
SOURCE_TASKS="$HSRLAB_PATH/source/hsrlab_tasks"

# Function to link and install a package
install_source() {
    local SOURCE_PATH=$1
    local PACKAGE_NAME=$(basename "$SOURCE_DIR")

    if [ -d "$SOURCE_PATH" ]; then
        # Install the package
        cd "$SOURCE_PATH" || { echo "Failed to enter directory: $SOURCE_PATH"; exit 1; }
        echo "Installing $PACKAGE_NAME with pip"
        ${ISAACLAB_PATH}/_isaac_sim/python.sh -m pip install -e . || { echo "Failed to install $PACKAGE_NAME"; exit 1; }
        cd - > /dev/null
    else
        echo "Source directory $SOURCE_PATH does not exist. Skipping."
    fi
}

# Link and install hsrlab
install_source "$SOURCE_LAB"

# Link and install hsrlab_assets
install_source "$SOURCE_ASSETS"

# Link and install hsrlab_rl
install_source "$SOURCE_RL"

# Link and install hsrlab_scenes
install_source "$SOURCE_SCENES"

# Link and install hsrlab_tasks
install_source "$SOURCE_TASKS"

echo "All tasks completed successfully."

# Execute any additional commands provided to the container
exec "$@"