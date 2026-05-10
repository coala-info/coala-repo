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
    inputBinding:
      position: 102
      prefix: --annot
  - id: minq
    type:
      - 'null'
      - int
    doc: Minimum base quality score
    inputBinding:
      position: 102
      prefix: --minq
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference file in fasta format
    inputBinding:
      position: 102
      prefix: --ref
  - id: refname
    type:
      - 'null'
      - string
    doc: Ref name (for bams with multiple sequences)
    inputBinding:
      position: 102
      prefix: --refname
  - id: varthresh
    type:
      - 'null'
      - float
    doc: Variant frequency threshold
    inputBinding:
      position: 102
      prefix: --varthresh
  - id: depths_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `depths_path`
    inputBinding:
      position: 103
      prefix: --depths
  - id: variants_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `variants_path`
    inputBinding:
      position: 104
      prefix: --variants
outputs:
  - id: variants
    type:
      - 'null'
      - File
    doc: Variant calling output file
    outputBinding:
      glob: $(inputs.variants_path)
  - id: depths
    type:
      - 'null'
      - File
    doc: Sequencing depth output file
    outputBinding:
      glob: $(inputs.depths_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
