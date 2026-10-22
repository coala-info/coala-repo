cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tbtamr
  - annotate
label: tbtamr_annotate
doc: "Annotate a BAM file with sequence ID and VCF information.\n\nTool homepage:
  https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: seq_id
    type:
      - 'null'
      - string
    doc: Sequence name.
    inputBinding:
      position: 101
      prefix: --seq_id
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file generated using the H37rV v3 reference genome
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_dir
    type:
      - 'null'
      - Directory
    doc: Output folder named after the sequence id
    outputBinding:
      glob: $(inputs.seq_id || 'tbtamr')
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
stdout: tbtamr_annotate.out
