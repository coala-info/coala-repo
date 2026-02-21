cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase_diploid
label: igda-script_igda_pipe_phase_diploid
doc: "The provided text does not contain help information for the tool. It contains
  a system error message regarding container image conversion and disk space.\n\n
  Tool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_phase_diploid.out
