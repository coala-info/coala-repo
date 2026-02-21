cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToAxt
label: ucsc-chaintoaxt
doc: "Convert chain files to axt format. (Note: The provided help text contained only
  container runtime logs and an error message; no usage information was available
  in the input text.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintoaxt:482--h0b57e2e_0
stdout: ucsc-chaintoaxt.out
