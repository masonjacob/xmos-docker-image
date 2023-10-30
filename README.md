# xmos-dev
A XMOS development container with Build-Essential, XTC Tools, and the XCORE-VOICE SDK.

## TODO
[x] V1
  [x] Create Inital Docker Image
  [x] Add XTC Tools and XCORE VOICE SDK by copying and unzipping tar file
  [x] Add XTC Tools "source SetEnv" to .bashrc 
[] V2
  [] Figure out authetication workaround and use wget to pull XTC Tools directly from xmos.ai (build from source?)
  [] Set up SSH to clone the private sln_voice (XCORE VOICE SDK) repository and recurse through submodules
