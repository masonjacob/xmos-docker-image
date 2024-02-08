#!/bin/sh

# Function to show usage information
show_usage() {
    echo "Usage: $0 [--run | --flash | --debug]"
}

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

git config --global --add safe.directory '*'
cmake -B build_host
cd build_host
make install
export PATH=$PATH:/opt/xmos/bin
cd ..
cmake -B build --toolchain xmos_cmake_toolchain/xs3a.cmake
cd build
make example_ffd

# Parse arguments
while [ $# -gt 0 ]; do
    key="$1"

    case $key in
        --run)
            # Action for --run option
            # echo "Executing run..."
            make run_example_ffd
            if [ $? -ne 0 ]; then
                exit 1
            fi
            ;;
        --flash)
            # Action for --flash option
            # echo "Flashing..."
            make flash_app_example_ffd
            if [ $? -ne 0 ]; then
                exit 1
            fi
            ;;
        --debug)
            # Action for --debug option
            # echo "Debugging..."
            make debug_example_ffd
            if [ $? -ne 0 ]; then
                exit 1
            fi
            ;;
        *)
            # Unknown option
            echo "Unknown option: $key"
            show_usage
            exit 1
            ;;
    esac
    shift
done
