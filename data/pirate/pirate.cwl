cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirate
label: pirate
doc: "PIRATE (Pangenome Iterative Refinement and Alignment Threshold Evaluation) -
  A toolbox for pangenome analysis and comparative genomics.\n\nTool homepage: https://github.com/SionBayliss/PIRATE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirate:1.0.5--hdfd78af_3
stdout: pirate.out
