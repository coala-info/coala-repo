cwlVersion: v1.2
class: CommandLineTool
baseCommand: lavToPsl
label: ucsc-lavtopsl
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log. Based on the tool name hint, this tool is
  typically used to convert LAV alignment files to PSL format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-lavtopsl:482--h0b57e2e_0
stdout: ucsc-lavtopsl.out
