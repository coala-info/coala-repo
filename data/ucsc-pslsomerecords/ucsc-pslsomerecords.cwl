cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSomeRecords
label: ucsc-pslsomerecords
doc: "The provided text does not contain help information for the tool. It is a container
  execution error log. Based on the tool name, this utility is typically used to extract
  specific records from a PSL file based on a list of names.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsomerecords:482--h0b57e2e_0
stdout: ucsc-pslsomerecords.out
