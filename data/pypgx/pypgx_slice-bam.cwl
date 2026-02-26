cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx slice-bam
label: pypgx_slice-bam
doc: "Slice BAM file for all genes used by PyPGx.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: input
    type: File
    doc: Input BAM file. It must be already indexed to allow random access.
    inputBinding:
      position: 1
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    default: GRCh37
    inputBinding:
      position: 102
      prefix: --assembly
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified genes. Ignored when --genes is not used.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of genes to include.
    inputBinding:
      position: 102
      prefix: --genes
outputs:
  - id: output
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
