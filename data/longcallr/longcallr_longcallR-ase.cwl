cwlVersion: v1.2
class: CommandLineTool
baseCommand: longcallR-ase
label: longcallr_longcallR-ase
doc: "Allele-specific expression analysis using long-read sequencing data (Note: The
  provided help text contains only container runtime errors and no argument definitions).\n
  \nTool homepage: https://github.com/huangnengCSU/longcallR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longcallr:1.12.0--py312h67e1f27_0
stdout: longcallr_longcallR-ase.out
