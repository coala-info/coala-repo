cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iva_qc
label: iva_iva_qc
doc: "IVA quality control tool (Note: The provided text is a container execution error
  log and does not contain help information or argument definitions).\n\nTool homepage:
  https://github.com/sanger-pathogens/iva"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iva:1.0.11--py_0
stdout: iva_iva_qc.out
