cwlVersion: v1.2
class: CommandLineTool
baseCommand: raiss
label: raiss
doc: "Robust AI-based imputation of Summary Statistics (Note: The provided text appears
  to be a container execution error log rather than help text, so no arguments could
  be extracted).\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/raiss/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raiss:4.0.1--pyhdfd78af_0
stdout: raiss.out
