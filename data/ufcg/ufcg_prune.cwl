cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg_prune
label: ufcg_prune
doc: "Fix UFCG tree labels or get a single gene tree\n\nTool homepage: https://ufcg.steineggerlab.com"
inputs:
  - id: developer
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: gene_name
    type: string
    doc: Gene name - "UFCG" for a UFCG tree, proper gene name for a single gene 
      tree
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: string
    doc: Input .trm file provided by tree module
    inputBinding:
      position: 101
      prefix: -i
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Remove ANSI escapes from standard output
    inputBinding:
      position: 101
      prefix: --nocolor
  - id: no_time
    type:
      - 'null'
      - boolean
    doc: Remove timestamp in front of the prompt string
    inputBinding:
      position: 101
      prefix: --notime
  - id: tree_label_format
    type: string
    doc: 'Tree label format, comma-separated string containing one or more of the
      following keywords: [uid, acc, label, taxon, strain, type, taxonomy]'
    inputBinding:
      position: 101
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make program verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
stdout: ufcg_prune.out
