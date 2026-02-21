cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase
label: igda-script_igda_pipe_phase
doc: "Integrated Genome-wide DNA Methylation Analysis (IGDA) pipeline phase script.
  Note: The provided text contains container runtime error messages and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_phase.out
