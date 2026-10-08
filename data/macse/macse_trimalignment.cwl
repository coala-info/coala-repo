cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - trimAlignment
label: macse_trimalignment
doc: "trims the input alignment by removing gappy sites at the beginning/end of the alignment.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: align
    type: File
    doc: "input FASTA file containing aligned nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -align
  - id: allow_NT
    type:
      - 'null'
      - string
    doc: "extra nucleotide characters to consider as N (example: -allow_NT \"#?\")"
    inputBinding:
      position: 102
      prefix: -allow_NT
  - id: half_window_size
    type:
      - 'null'
      - int
    doc: "the sliding window size is equal to (1 + 2*half_window_size) (default: 0)"
    inputBinding:
      position: 102
      prefix: -half_window_size
  - id: min_NT_at_ends
    type:
      - 'null'
      - int
    doc: "minimum number of sequences that should be present in the alignment extremities. If this parameter and min_percent_NT_at_ends are both set, the smallest (non null) percentage will be used. This is useful to indicate that alignment ends should be trimmed until having at least XX sequences or YY% percentage of the sequences. (default: 0)"
    inputBinding:
      position: 102
      prefix: -min_NT_at_ends
  - id: min_percent_NT_at_ends
    type:
      - 'null'
      - float
    doc: "trims alignmnent by removing sites from the end of the alignment up to the first site for which the percentage of nucleotides is greater than this value (default: 0.0)"
    inputBinding:
      position: 102
      prefix: -min_percent_NT_at_ends
  - id: out_NT
    type: string
    default: "macse_NT.fasta"
    doc: "output FASTA file containing aligned nucleotide sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_NT
  - id: out_trim_info
    type: string
    default: "macse_trim_info.csv"
    doc: "output CSV file containing information about the triming/filtering process (output file name)"
    inputBinding:
      position: 102
      prefix: -out_trim_info
  - id: respect_first_RF_ON
    type:
      - 'null'
      - boolean
    doc: "if this option is set, the triming will preserve the (first) reading frame (the number of trimmed sites will be a mulitple of 3)."
    inputBinding:
      position: 102
      prefix: -respect_first_RF_ON
  - id: trimed_seq_only_stat_ON
    type:
      - 'null'
      - boolean
    doc: "trimed_seq_only_stat_ON"
    inputBinding:
      position: 102
      prefix: -trimed_seq_only_stat_ON
outputs:
  - id: out_NT_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing aligned nucleotide sequences"
    outputBinding:
      glob: $(inputs.out_NT)
  - id: out_trim_info_file
    type:
      - 'null'
      - File
    doc: "output CSV file containing information about the triming/filtering process"
    outputBinding:
      glob: $(inputs.out_trim_info)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
