cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blockclust.py
label: blockclust_blockclust.py_pre
doc: "BlockClust pre-processing mode (-m PRE): convert reads BAM to tags BED (one line
  per unique read sequence and locus, with read count, number of loci and normalized
  count; chrM is skipped)\n\nTool homepage: https://github.com/pavanvidem/blockclust"
arguments:
  - position: 100
    prefix: --mode
    valueFrom: PRE
inputs:
  - id: bam
    type: File
    doc: Input bam file (indexed; the .bai index must sit beside it)
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: --bam
  - id: tags_bed_path
    type: string
    doc: BED file of tags (output)
    inputBinding:
      position: 102
      prefix: --tags_bed
outputs:
  - id: tags_bed
    type: File
    doc: BED file of tags
    outputBinding:
      glob: $(inputs.tags_bed_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
