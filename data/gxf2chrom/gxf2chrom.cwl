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
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to output .chrom file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxf2chrom:0.1.0--h9948957_1
