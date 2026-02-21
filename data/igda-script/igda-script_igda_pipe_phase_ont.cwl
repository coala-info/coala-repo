cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase_ont
label: igda-script_igda_pipe_phase_ont
doc: "IGDA pipeline phase for ONT (Oxford Nanopore Technologies) data. Note: The provided
  help text contains only container runtime error messages and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_phase_ont.out
