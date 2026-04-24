cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxf2bed
label: gxf2bed
doc: "Fastest GTF/GFF-to-BED converter chilling around\n\nTool homepage: https://github.com/alejandrogzi/gxf2bed"
inputs:
  - id: additional_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: BED additional fields
    inputBinding:
      position: 101
      prefix: --additional-fields
  - id: child_attribute
    type:
      - 'null'
      - string
    doc: Child feature to extract
    inputBinding:
      position: 101
      prefix: --child-attribute
  - id: child_features
    type:
      - 'null'
      - type: array
        items: string
    doc: Child features
    inputBinding:
      position: 101
      prefix: --child-features
  - id: chunks
    type:
      - 'null'
      - int
    doc: Chunk size for parallel processing
    inputBinding:
      position: 101
      prefix: --chunks
  - id: input
    type: File
    doc: "The fastest G{T,F}F-to-BED converter chilling around the world!\n\n    \
      \      This program converts GTF/GFF3 files to BED format blazingly fast. Start
      by providing the path to the GTF/GFF3 file with -i/--input file.gtf or -i/--input
      file.gff3."
    inputBinding:
      position: 101
      prefix: --input
  - id: parent_attribute
    type:
      - 'null'
      - string
    doc: Feature to extract
    inputBinding:
      position: 101
      prefix: --parent-attribute
  - id: parent_feature
    type:
      - 'null'
      - string
    doc: Parent feature
    inputBinding:
      position: 101
      prefix: --parent-feature
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: type
    type:
      - 'null'
      - string
    doc: BED type format
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output
    type: File
    doc: Path to output BED file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxf2bed:0.3.2--ha6fb395_0
