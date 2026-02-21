cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitInfo
label: ucsc-twobitinfo
doc: "Get information about a .2bit file. (Note: The provided help text contains only
  container runtime error logs and does not list command-line arguments.)\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitinfo:482--hdc0a859_0
stdout: ucsc-twobitinfo.out
