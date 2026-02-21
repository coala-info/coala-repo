cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedGraphToBigWig
label: ucsc-bedgraphtobigwig
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding a failed container build (no space left on device).\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedgraphtobigwig:482--hdc0a859_0
stdout: ucsc-bedgraphtobigwig.out
