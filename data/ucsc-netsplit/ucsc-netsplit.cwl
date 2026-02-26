cwlVersion: v1.2
class: CommandLineTool
baseCommand: netSplit
label: ucsc-netsplit
doc: "Split a net file into multiple files. (Note: The provided help text was a Docker
  error message and did not contain usage information; arguments listed are based
  on standard tool documentation).\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_net
    type: File
    doc: The input .net file to be split.
    inputBinding:
      position: 1
outputs:
  - id: output_directory
    type: Directory
    doc: The directory where the split net files will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netsplit:482--h0b57e2e_0
