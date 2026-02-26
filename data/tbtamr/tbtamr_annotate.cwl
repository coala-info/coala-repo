cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbtamr_annotate
label: tbtamr_annotate
doc: "Annotate a BAM file with sequence ID and VCF information.\n\nTool homepage:
  https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: seq_id
    type:
      - 'null'
      - string
    doc: Sequence name.
    default: tbtamr
    inputBinding:
      position: 101
      prefix: --seq_id
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file generated using the H37rV v3 reference genome
    default: ''
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
stdout: tbtamr_annotate.out
