cwlVersion: v1.2
class: CommandLineTool
baseCommand: [neff]
label: neffy-cli_neff
doc: "This program computes the Number of Effective Sequences (NEFF) for a given multiple
  sequence alignment (MSA). NEFF is used to assess the diversity of sequences by accounting
  for redundancy and sequence similarity.\n\nTool homepage: https://maryam-haghani.github.io/NEFFy"
inputs:
  - id: file
    type:
      type: array
      items: File
    doc: Input file(s) containing the MSA(s). Several files are joined with commas.
    inputBinding:
      position: 101
      prefix: --file=
      separate: false
      itemSeparator: ','
  - id: format
    type:
      - 'null'
      - type: array
        items: string
    doc: "Format(s) of the input file(s), joined with commas."
    inputBinding:
      position: 102
      prefix: "--format="
      separate: false
      itemSeparator: ','
  - id: alphabet
    type: ['null', int]
    doc: "Valid alphabet: 0 Protein (default), 1 RNA, 2 DNA."
    inputBinding:
      position: 101
      prefix: "--alphabet="
      separate: false
  - id: check_validation
    type: ['null', boolean]
    doc: "Whether to validate sequences to include only letters from the chosen alphabet (default false)."
    inputBinding:
      position: 101
      prefix: "--check_validation="
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: threshold
    type: ['null', float]
    doc: "Similarity threshold used to decide if two sequences are similar (default 0.8)."
    inputBinding:
      position: 101
      prefix: "--threshold="
      separate: false
  - id: norm
    type: ['null', int]
    doc: "NEFF normalization: 0 sqrt(length) (default), 1 length, 2 none."
    inputBinding:
      position: 101
      prefix: "--norm="
      separate: false
  - id: omit_query_gaps
    type: ['null', boolean]
    doc: "If true, gap positions in the query (first) sequence are omitted from all sequences (default true)."
    inputBinding:
      position: 101
      prefix: "--omit_query_gaps="
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: is_symmetric
    type: ['null', boolean]
    doc: "Whether gap positions count in the similarity cutoff (symmetric, default true) or not."
    inputBinding:
      position: 101
      prefix: "--is_symmetric="
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: non_standard_option
    type: ['null', int]
    doc: "Handling of non-standard letters: 0 AsStandard (default), 1 ConsiderGapInCutoff, 2 ConsiderGap."
    inputBinding:
      position: 101
      prefix: "--non_standard_option="
      separate: false
  - id: depth
    type: ['null', int]
    doc: "Limits the number of sequences (MSA depth) used."
    inputBinding:
      position: 101
      prefix: "--depth="
      separate: false
  - id: gap_cutoff
    type: ['null', float]
    doc: "Removes alignment positions whose gap fraction is greater than or equal to this value (default 1)."
    inputBinding:
      position: 101
      prefix: "--gap_cutoff="
      separate: false
  - id: pos_start
    type: ['null', int]
    doc: "Start position (inclusive) for the NEFF computation (default 1)."
    inputBinding:
      position: 101
      prefix: "--pos_start="
      separate: false
  - id: pos_end
    type: ['null', int]
    doc: "End position (inclusive) for the NEFF computation (default end of MSA)."
    inputBinding:
      position: 101
      prefix: "--pos_end="
      separate: false
  - id: only_weights
    type: ['null', boolean]
    doc: "If true, return only the sequence weights instead of the NEFF value (default false)."
    inputBinding:
      position: 101
      prefix: "--only_weights="
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: multimer_MSA
    type: ['null', boolean]
    doc: "If true, compute NEFF for a multimeric MSA (default false)."
    inputBinding:
      position: 101
      prefix: "--multimer_MSA="
      separate: false
      valueFrom: '$(self ? "true" : "false")'
  - id: stoichiom
    type: ['null', string]
    doc: "Stoichiometry for a multimeric MSA; required when multimer_MSA is true."
    inputBinding:
      position: 101
      prefix: "--stoichiom="
      separate: false
  - id: chain_length
    type:
      - 'null'
      - type: array
        items: int
    doc: "Chain lengths for heteromer multimer MSAs, joined with commas."
    inputBinding:
      position: 101
      prefix: "--chain_length="
      separate: false
      itemSeparator: ','
  - id: residue_neff
    type: ['null', boolean]
    doc: "If true, compute per-residue (column-wise) NEFF (default false)."
    inputBinding:
      position: 101
      prefix: "--residue_neff="
      separate: false
      valueFrom: '$(self ? "true" : "false")'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
stdout: neffy-cli_neff.out
