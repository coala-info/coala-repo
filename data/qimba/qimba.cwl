cwlVersion: v1.2
class: CommandLineTool
baseCommand: qimba
label: qimba
doc: "Quantification of Isoforms from Methylation-aware Bisulfite-seq Alignment (Note:
  The provided text appears to be a container engine error log rather than CLI help
  text; no arguments could be extracted from the input).\n\nTool homepage: https://github.com/quadram-institute-bioscience/qimba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
stdout: qimba.out
