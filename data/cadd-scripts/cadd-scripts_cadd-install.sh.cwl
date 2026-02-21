cwlVersion: v1.2
class: CommandLineTool
baseCommand: cadd-install.sh
label: cadd-scripts_cadd-install.sh
doc: "Installation script for CADD (Combined Annotation Dependent Depletion) scripts
  and data.\n\nTool homepage: https://github.com/kircherlab/CADD-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cadd-scripts:1.7.3--hdfd78af_0
stdout: cadd-scripts_cadd-install.sh.out
