cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedAnnotateGC
label: ngs-bits_BedAnnotateGC
doc: "The provided text is a system error message (out of disk space during container
  image extraction) and does not contain the help documentation for the tool. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_BedAnnotateGC.out
