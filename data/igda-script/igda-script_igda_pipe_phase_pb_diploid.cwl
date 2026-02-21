cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase_pb_diploid
label: igda-script_igda_pipe_phase_pb_diploid
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a log of a fatal error occurring during a container build process
  (no space left on device).\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_phase_pb_diploid.out
