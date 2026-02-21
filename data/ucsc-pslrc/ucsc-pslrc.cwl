cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslRc
label: ucsc-pslrc
doc: "The provided text does not contain help information as it is a container runtime
  error log. Based on the tool name hint, this tool is part of the UCSC Genome Browser
  utilities used to reverse complement PSL files.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslrc:482--h0b57e2e_0
stdout: ucsc-pslrc.out
