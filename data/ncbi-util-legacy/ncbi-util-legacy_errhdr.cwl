cwlVersion: v1.2
class: CommandLineTool
baseCommand: errhdr
label: ncbi-util-legacy_errhdr
doc: "NCBI legacy utility (Note: The provided help text contains only container runtime
  error messages and no usage information).\n\nTool homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--ha14ba45_0
stdout: ncbi-util-legacy_errhdr.out
