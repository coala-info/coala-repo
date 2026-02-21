cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythomics_iBAQ
label: pythomics_iBAQ
doc: "A tool for Intensity Based Absolute Quantification (iBAQ) in proteomics. Note:
  The provided help text contains only system logs and error messages; no specific
  arguments or usage instructions were available for extraction.\n\nTool homepage:
  https://github.com/pandeylab/pythomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythomics:0.4.1--pyh7cba7a3_0
stdout: pythomics_iBAQ.out
