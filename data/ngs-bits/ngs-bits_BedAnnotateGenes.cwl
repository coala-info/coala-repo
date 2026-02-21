cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedAnnotateGenes
label: ngs-bits_BedAnnotateGenes
doc: "Annotates BED files with gene information.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_BedAnnotateGenes.out
