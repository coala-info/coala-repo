cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxf2chrom
label: gxf2chrom
doc: "Everythin in .chrom from GTF/GFF\n\nTool homepage: https://github.com/alejandrogzi/gxf2chrom"
inputs:
  - id: feature
    type:
      - 'null'
      - string
    doc: Feature to extract
    default: protein_id
    inputBinding:
      position: 101
      prefix: --feature
  - id: input
    type: File
    doc: Path to the GTF/GFF3 file
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Path to output .chrom file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxf2chrom:0.1.0--h9948957_1
