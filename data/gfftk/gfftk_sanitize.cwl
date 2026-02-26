cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfftk_sanitize
label: gfftk_sanitize
doc: "sanitize GFF3 file, load GFF3 and output cleaned up GFF3 output.\n\nTool homepage:
  https://github.com/nextgenusfs/gfftk"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'write/keep intermediate files (default: False)'
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: genome in FASTA format (optional for combined GFF3+FASTA files)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gff3_file
    type: File
    doc: annotation in GFF3 format (or combined GFF3+FASTA)
    inputBinding:
      position: 101
      prefix: --gff3
  - id: url_encode
    type:
      - 'null'
      - boolean
    doc: 'URL encode attribute values in GFF3 output for downstream tool compatibility
      (default: False)'
    default: false
    inputBinding:
      position: 101
      prefix: --url-encode
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'write santized GFF3 output to file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
