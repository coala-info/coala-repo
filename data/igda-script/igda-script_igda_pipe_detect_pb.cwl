cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_detect_pb
label: igda-script_igda_pipe_detect_pb
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_detect_pb.out
