# XMOS Docker Development Container
An XMOS development container with Build-Essential, XTC Tools, and the XCORE-VOICE SDK. Latest Docker image is available [here](https://hub.docker.com/r/masonjacob/xmos-dev).

## How to Use
To build your own image:
- Download the XTC Tools .tgz file directly from [www.xmos.com](www.xmos.com).
- Clone the XCORE VOICE SDK (xmos/sln_voice) repository from [here](www.github.com/xmos/sln_voice), making sure to recurse through submodules. Zip the repository to a .tgz file.
- Clone this repository, and add both .tgz files to the directory where the Dockerfile in this repository is located.
- Edit the Dockerfile, changing the ARGs (e.g. XTC_TOOLS_SOURCE, XTC_TOOLS_VERSION, etc...) to match the name and version of the .tgz tools and SDK. 
- In a terminal, set the directory to the local cloned folder of this repository, and run `docker build . -t <name-of-image>:<version> 


## TO DO
- [x] V1
  - [x] Create Inital Docker Image
  - [x] Add XTC Tools and XCORE VOICE SDK by copying and unzipping tar file
  - [x] Add XTC Tools "source SetEnv" to .bashrc
- [ ] V2
  - [ ] Figure out authetication workaround and use wget to pull XTC Tools directly from xmos.com (build from source?) 
  - [ ] Set up SSH to clone the private sln_voice (XCORE VOICE SDK) repository and recurse through submodules
