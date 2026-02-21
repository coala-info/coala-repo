cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - mfa2aln
label: treebest_mfa2aln
doc: "Convert MFA (Multi-FASTA) to alignment format\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: fasta_align
    type: File
    doc: Input FASTA alignment file
    inputBinding:
      position: 1
  - id: no_names
    type:
      - 'null'
      - boolean
    doc: Optional flag (typically used in treebest to suppress names or similar formatting
      options)
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_mfa2aln.out
