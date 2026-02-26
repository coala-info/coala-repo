cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem seqs
label: singlem_seqs
doc: "Find the best window position for a SingleM package\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: alignment
    type: File
    doc: "Protein sequences hmmaligned and converted to fasta\n                  \
      \      format with seqmagick"
    inputBinding:
      position: 101
      prefix: --alignment
  - id: alignment_type
    type: string
    doc: alignment is 'aa' or 'dna'
    inputBinding:
      position: 101
      prefix: --alignment-type
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: hmm
    type:
      - 'null'
      - File
    doc: "HMM file used to generate alignment, used here to rank\n               \
      \         windows according to their information content."
    inputBinding:
      position: 101
      prefix: --hmm
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: window_size
    type:
      - 'null'
      - int
    doc: Number of nucleotides to use in continuous window
    default: 60
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_seqs.out
