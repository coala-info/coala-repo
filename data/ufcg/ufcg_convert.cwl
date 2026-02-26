cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg_convert
label: ufcg_convert
doc: "Convert core gene profile into a FASTA file\n\nTool homepage: https://ufcg.steineggerlab.com"
inputs:
  - id: developer
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force to overwrite the existing files
    default: false
    inputBinding:
      position: 101
      prefix: -f
  - id: header_format
    type:
      - 'null'
      - string
    doc: 'FASTA header format, comma-separated string containing one or more of the
      following keywords: [acc] [uid, acc, label, taxon, strain, type, taxonomy]'
    inputBinding:
      position: 101
      prefix: -l
  - id: include_copied_genes
    type:
      - 'null'
      - boolean
    doc: Include multiple copied genes (tag with numerical suffix)
    default: false
    inputBinding:
      position: 101
      prefix: -c
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
  - id: profile
    type: File
    doc: Input core gene profile (.ucg)
    inputBinding:
      position: 101
      prefix: -i
  - id: sequence_type
    type: string
    doc: Sequence type [nuc, pro]
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make program verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
