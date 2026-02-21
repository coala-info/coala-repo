cwlVersion: v1.2
class: CommandLineTool
baseCommand: slivar
label: slivar_pslivar
doc: "A tool for genomic filtering and manipulation (Note: The provided input text
  appears to be a container execution error log rather than help text, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/brentp/slivar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slivar:0.3.3--h5f107b1_0
stdout: slivar_pslivar.out
