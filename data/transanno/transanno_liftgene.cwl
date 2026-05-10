cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transanno
  - liftgene
label: transanno_liftgene
doc: "Lift GENCODE or Ensemble GFF3/GTF file\n\nTool homepage: https://github.com/informationsea/transanno"
inputs:
  - id: gff
    type: File
    doc: input GFF3/GTF file (GENCODE/Ensemble)
    inputBinding:
      position: 1
  - id: chain
    type: File
    doc: chain file
    inputBinding:
      position: 102
      prefix: --chain
  - id: format
    type:
      - 'null'
      - string
    doc: 'Input file format [possible values: auto, gff3, gtf]'
    inputBinding:
      position: 102
      prefix: --format
  - id: failed_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `failed_path`
    inputBinding:
      position: 103
      prefix: --failed
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type: File
    doc: GFF3/GTF output path (unsorted)
    outputBinding:
      glob: $(inputs.output_path)
  - id: failed
    type: File
    doc: Failed to liftOver GFF3/GTF output path
    outputBinding:
      glob: $(inputs.failed_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transanno:0.4.5--h4349ce8_0
