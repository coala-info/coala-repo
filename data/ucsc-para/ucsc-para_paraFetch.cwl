cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraFetch
label: ucsc-para_paraFetch
doc: "A tool from the UCSC Genome Browser utilities to fetch files in parallel. (Note:
  The provided help text contains container runtime error messages and does not list
  usage or arguments.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_paraFetch.out
