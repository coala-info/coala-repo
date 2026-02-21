cwlVersion: v1.2
class: CommandLineTool
baseCommand: PneumoCaT.py
label: pneumocat_PneumoCaT.py
doc: "Pneumococcal Capsular Typing Tool (PneumoCaT). Note: The provided text contains
  container runtime logs and a fatal error rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/phe-bioinformatics/pneumocat/archive/v1.1.tar.gz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pneumocat:1.2.1--0
stdout: pneumocat_PneumoCaT.py.out
