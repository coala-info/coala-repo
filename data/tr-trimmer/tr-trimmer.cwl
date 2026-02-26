cwlVersion: v1.2
class: CommandLineTool
baseCommand: tr-trimmer
label: tr-trimmer
doc: "Trim terminal repeats from sequences in FASTA files\n\nTool homepage: https://github.com/apcamargo/tr-trimmer"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s). Use '-' for stdin
    default: '-'
    inputBinding:
      position: 1
  - id: disable_dtr_trimming
    type:
      - 'null'
      - boolean
    doc: Disable identification of direct terminal repeats (DTRs) from sequences
      (requires --enable-itr-trimming)
    inputBinding:
      position: 102
      prefix: --disable-dtr-trimming
  - id: disable_trimming
    type:
      - 'null'
      - boolean
    doc: Disable trimming of terminal repeats from sequences. Can be used with 
      `--include-tr-info` or `--exclude-non-tr-seqs` to identify and report 
      sequences with terminal repeats without modifying the sequences
    inputBinding:
      position: 102
      prefix: --disable-trimming
  - id: enable_itr_identification
    type:
      - 'null'
      - boolean
    doc: Identify inverted terminal repeats (ITRs) from sequences
    inputBinding:
      position: 102
      prefix: --enable-itr-identification
  - id: exclude_non_tr_seqs
    type:
      - 'null'
      - boolean
    doc: Retain only the sequences for which terminal repeats were identified
    inputBinding:
      position: 102
      prefix: --exclude-non-tr-seqs
  - id: ignore_ambiguous
    type:
      - 'null'
      - boolean
    doc: Ignore terminal repeats that contain a high proportion of ambiguous 
      bases (e.g. 'N')
    inputBinding:
      position: 102
      prefix: --ignore-ambiguous
  - id: ignore_low_complexity
    type:
      - 'null'
      - boolean
    doc: Ignore terminal repeats that contain a high proportion of low 
      complexity sequences
    inputBinding:
      position: 102
      prefix: --ignore-low-complexity
  - id: include_tr_info
    type:
      - 'null'
      - boolean
    doc: Add terminal repeat information to the sequence headers (e.g., 'tr=dtr 
      tr_length=55')
    inputBinding:
      position: 102
      prefix: --include-tr-info
  - id: max_ambiguous_frac
    type:
      - 'null'
      - float
    doc: Maximum fraction of the terminal repeat length that is comprised of 
      ambiguous bases
    default: 0.0
    inputBinding:
      position: 102
      prefix: --max-ambiguous-frac
  - id: max_low_complexity_frac
    type:
      - 'null'
      - float
    doc: Maximum fraction of the terminal repeat length that is comprised of 
      low-complexity sequence
    default: 0.5
    inputBinding:
      position: 102
      prefix: --max-low-complexity-frac
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of terminal repeat
    default: 21
    inputBinding:
      position: 102
      prefix: --min-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tr-trimmer:0.4.0--h4349ce8_0
stdout: tr-trimmer.out
