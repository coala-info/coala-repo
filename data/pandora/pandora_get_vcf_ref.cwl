cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pandora
  - get_vcf_ref
label: pandora_get_vcf_ref
doc: "Outputs a fasta suitable for use as the VCF reference using input sequences\n
  \nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: prg
    type: File
    doc: PRG to index (in fasta format)
    inputBinding:
      position: 1
  - id: query
    type:
      - 'null'
      - File
    doc: Fast{a,q} file of sequences to retrive the PRG reference for
    inputBinding:
      position: 2
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the output with gzip
    inputBinding:
      position: 103
      prefix: --compress
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity of logging. Repeat for increased verbosity
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
stdout: pandora_get_vcf_ref.out
