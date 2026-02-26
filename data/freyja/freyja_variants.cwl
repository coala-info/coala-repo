cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja_variants
label: freyja_variants
doc: "Perform variant calling using samtools and iVar on a BAMFILE\n\nTool homepage:
  https://github.com/andersen-lab/Freyja"
inputs:
  - id: bamfile
    type: File
    doc: BAMFILE
    inputBinding:
      position: 1
  - id: annot
    type:
      - 'null'
      - File
    doc: provide an annotation file in gff3 format
    default: ''
    inputBinding:
      position: 102
      prefix: --annot
  - id: minq
    type:
      - 'null'
      - int
    doc: Minimum base quality score
    default: 20
    inputBinding:
      position: 102
      prefix: --minq
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference file in fasta format
    default: data/NC_045512_Hu-1.fasta
    inputBinding:
      position: 102
      prefix: --ref
  - id: refname
    type:
      - 'null'
      - string
    doc: Ref name (for bams with multiple sequences)
    default: ''
    inputBinding:
      position: 102
      prefix: --refname
  - id: varthresh
    type:
      - 'null'
      - float
    doc: Variant frequency threshold
    default: 0.0
    inputBinding:
      position: 102
      prefix: --varthresh
outputs:
  - id: variants
    type:
      - 'null'
      - File
    doc: Variant calling output file
    outputBinding:
      glob: $(inputs.variants)
  - id: depths
    type:
      - 'null'
      - File
    doc: Sequencing depth output file
    outputBinding:
      glob: $(inputs.depths)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
