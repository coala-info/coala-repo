cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./neff
label: neffy-cli_neff
doc: "This program computes the Number of Effective Sequences (NEFF) for a given multiple
  sequence alignment (MSA).\nNEFF is used to assess the diversity of sequences by
  accounting for redundancy and sequence similarity.\n\nTool homepage: https://maryam-haghani.github.io/NEFFy"
inputs:
  - id: alphabet
    type:
      - 'null'
      - string
    doc: "Specifies the valid alphabet for the sequences:\n        0 : Protein (default)\n\
      \        1 : RNA\n        2 : DNA"
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: chain_length
    type:
      - 'null'
      - type: array
        items: int
    doc: "For heteromer multimer MSAs, provides the lengths of the individual chains.\n\
      \      This parameter is required when --multimer_MSA=true and the --stoichiom
      value consists of multiple letters (indicating a heteromer).\n      (Default:
      0)"
    inputBinding:
      position: 101
      prefix: --chain_length
  - id: check_validation
    type:
      - 'null'
      - boolean
    doc: Whether to validate sequences to include only letters from the chosen 
      alphabet.
    inputBinding:
      position: 101
      prefix: --check_validation
  - id: depth
    type:
      - 'null'
      - int
    doc: "Limits the number of sequences (MSA depth) considered in the computation.\n\
      \      (Default: use all sequences in the input file)"
    inputBinding:
      position: 101
      prefix: --depth
  - id: file
    type:
      type: array
      items: File
    doc: Input file(s) containing the MSA(s). Multiple files can be specified as
      a comma-separated list (without spaces).
    inputBinding:
      position: 101
      prefix: --file
  - id: format
    type:
      - 'null'
      - type: array
        items: string
    doc: Format(s) of the input file(s) (comma-separated, no spaces).
    inputBinding:
      position: 101
      prefix: --format
  - id: gap_cutoff
    type:
      - 'null'
      - float
    doc: "Removes alignment positions where the fraction of gaps is greater than or
      equal to this value.\n      (Default: 1, meaning no positions are removed)"
    inputBinding:
      position: 101
      prefix: --gap_cutoff
  - id: is_symmetric
    type:
      - 'null'
      - boolean
    doc: "Determines whether gap positions are considered in similarity cutoff computation
      (symmetric) or not (asymmetric).\n      (Default: true, meaning symmetric)"
    inputBinding:
      position: 101
      prefix: --is_symmetric
  - id: multimer_MSA
    type:
      - 'null'
      - boolean
    doc: If true, computes NEFF for a multimeric MSA.
    inputBinding:
      position: 101
      prefix: --multimer_MSA
  - id: non_standard_option
    type:
      - 'null'
      - string
    doc: "Determines how non-standard letters are handled:\n        0 : AsStandard
      (default)\n        1 : ConsiderGapInCutoff\n        2 : ConsiderGap"
    inputBinding:
      position: 101
      prefix: --non_standard_option
  - id: norm
    type:
      - 'null'
      - string
    doc: "NEFF normalization option:\n        0 : Normalize by sqrt(Length of alignment)
      (default)\n        1 : Normalize by Length of alignment\n        2 : No normalization"
    inputBinding:
      position: 101
      prefix: --norm
  - id: omit_query_gaps
    type:
      - 'null'
      - boolean
    doc: If true, gap positions in the query (first) sequence are omitted from 
      all sequences.
    inputBinding:
      position: 101
      prefix: --omit_query_gaps
  - id: only_weights
    type:
      - 'null'
      - boolean
    doc: If true, the program returns only the sequence weights instead of the 
      final NEFF value.
    inputBinding:
      position: 101
      prefix: --only_weights
  - id: pos_end
    type:
      - 'null'
      - int
    doc: "End position (inclusive) in the alignment for NEFF computation.\n      (Default:
      length of the MSA sequence, meaning end of the sequences)"
    inputBinding:
      position: 101
      prefix: --pos_end
  - id: pos_start
    type:
      - 'null'
      - int
    doc: "Start position (inclusive) in the alignment for NEFF computation.\n    \
      \  (Default: 1, meaning start of the sequences)"
    inputBinding:
      position: 101
      prefix: --pos_start
  - id: residue_neff
    type:
      - 'null'
      - boolean
    doc: If true, computes per-residue (column-wise) NEFF.
    inputBinding:
      position: 101
      prefix: --residue_neff
  - id: stoichiom
    type:
      - 'null'
      - string
    doc: Specifies the stoichiometry for a multimeric MSA. This parameter is 
      required when --multimer_MSA=true.
    inputBinding:
      position: 101
      prefix: --stoichiom
  - id: threshold
    type:
      - 'null'
      - float
    doc: Similarity threshold (Θ) used to decide if two sequences are considered
      similar.
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
stdout: neffy-cli_neff.out
