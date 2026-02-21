cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHub
label: ucsc-para_paraHub
doc: "A tool from the ucsc-para package. Note: The provided help text contains container
  build logs and does not list specific usage instructions or arguments.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_paraHub.out
