cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase_pb
label: igda-script_igda_pipe_phase_pb
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error indicating a failure to build the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_phase_pb.out
