cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/lib/python3.11/site-packages/neffy/bin/neff
label: neffy_neff
doc: "NEFF - Number of Effective Sequences Computation Tool. Computes the Number of\
  \ Effective Sequences (NEFF) for a multiple sequence alignment (MSA), accounting\
  \ for redundancy and sequence similarity. Prints the MSA length, depth and NEFF.\n\
  \nTool homepage: https://github.com/Maryam-Haghani/NEFFy"
inputs:
  - id: file
    type:
      type: array
      items: File
    doc: Input file(s) containing the MSA(s). Several files are given as a comma-separated
      list; NEFFy combines them.
    inputBinding:
      position: 1
      prefix: --file=
      separate: false
      itemSeparator: ','
  - id: format
    type:
      - 'null'
      - type: array
        items: string
    doc: Format(s) of the input file(s) (comma-separated); inferred from the file
      extension if absent.
    inputBinding:
      position: 10
      prefix: --format=
      separate: false
      itemSeparator: ','
  - id: alphabet
    type:
      - 'null'
      - int
    doc: 'Valid alphabet for the sequences: 0 Protein (default), 1 RNA, 2 DNA.'
    inputBinding:
      position: 10
      prefix: --alphabet=
      separate: false
  - id: threshold
    type:
      - 'null'
      - double
    doc: Similarity threshold used to decide if two sequences are considered similar
      (default 0.8).
    inputBinding:
      position: 10
      prefix: --threshold=
      separate: false
  - id: norm
    type:
      - 'null'
      - int
    doc: 'NEFF normalization: 0 sqrt(Length of alignment) (default), 1 Length of alignment,
      2 no normalization.'
    inputBinding:
      position: 10
      prefix: --norm=
      separate: false
  - id: non_standard_option
    type:
      - 'null'
      - int
    doc: 'How non-standard letters are handled: 0 AsStandard (default), 1 ConsiderGapInCutoff,
      2 ConsiderGap.'
    inputBinding:
      position: 10
      prefix: --non_standard_option=
      separate: false
  - id: depth
    type:
      - 'null'
      - int
    doc: 'Limits the number of sequences (MSA depth) considered in the computation
      (default: all).'
    inputBinding:
      position: 10
      prefix: --depth=
      separate: false
  - id: gap_cutoff
    type:
      - 'null'
      - double
    doc: 'Removes alignment positions where the fraction of gaps is greater than or
      equal to this value (default 1: none removed).'
    inputBinding:
      position: 10
      prefix: --gap_cutoff=
      separate: false
  - id: pos_start
    type:
      - 'null'
      - int
    doc: Start position (inclusive) in the alignment for NEFF computation (default
      1).
    inputBinding:
      position: 10
      prefix: --pos_start=
      separate: false
  - id: pos_end
    type:
      - 'null'
      - int
    doc: 'End position (inclusive) in the alignment for NEFF computation (default:
      end of the MSA).'
    inputBinding:
      position: 10
      prefix: --pos_end=
      separate: false
  - id: stoichiom
    type:
      - 'null'
      - string
    doc: Stoichiometry for a multimeric MSA; required when multimer_msa is true.
    inputBinding:
      position: 10
      prefix: --stoichiom=
      separate: false
  - id: chain_length
    type:
      - 'null'
      - type: array
        items: int
    doc: For heteromer multimer MSAs, the lengths of the individual chains (comma-separated);
      required when multimer_msa is true and stoichiom has several letters.
    inputBinding:
      position: 10
      prefix: --chain_length=
      separate: false
      itemSeparator: ','
  - id: check_validation
    type:
      - 'null'
      - boolean
    doc: Whether to validate sequences to include only letters from the chosen alphabet
      (default false).
  - id: omit_query_gaps
    type:
      - 'null'
      - boolean
    doc: If true, gap positions in the query (first) sequence are omitted from all
      sequences (default true).
  - id: is_symmetric
    type:
      - 'null'
      - boolean
    doc: Whether gap positions are considered in similarity cutoff computation (symmetric,
      default true) or not (asymmetric).
  - id: only_weights
    type:
      - 'null'
      - boolean
    doc: If true, the program returns only the sequence weights instead of the final
      NEFF value (default false).
  - id: multimer_msa
    type:
      - 'null'
      - boolean
    doc: If true, computes NEFF for a multimeric MSA (default false).
  - id: residue_neff
    type:
      - 'null'
      - boolean
    doc: If true, computes per-residue (column-wise) NEFF (default false).
outputs:
  - id: stdout
    type: stdout
    doc: MSA length, depth and NEFF (or weights) printed by the tool
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 10
    valueFrom: '${ return (inputs.check_validation === null || inputs.check_validation
      === undefined) ? [] : ["--check_validation=" + inputs.check_validation]; }'
  - position: 10
    valueFrom: '${ return (inputs.omit_query_gaps === null || inputs.omit_query_gaps
      === undefined) ? [] : ["--omit_query_gaps=" + inputs.omit_query_gaps]; }'
  - position: 10
    valueFrom: '${ return (inputs.is_symmetric === null || inputs.is_symmetric ===
      undefined) ? [] : ["--is_symmetric=" + inputs.is_symmetric]; }'
  - position: 10
    valueFrom: '${ return (inputs.only_weights === null || inputs.only_weights ===
      undefined) ? [] : ["--only_weights=" + inputs.only_weights]; }'
  - position: 10
    valueFrom: '${ return (inputs.multimer_msa === null || inputs.multimer_msa ===
      undefined) ? [] : ["--multimer_MSA=" + inputs.multimer_msa]; }'
  - position: 10
    valueFrom: '${ return (inputs.residue_neff === null || inputs.residue_neff ===
      undefined) ? [] : ["--residue_neff=" + inputs.residue_neff]; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy:0.1.1--py311he264feb_1
stdout: neffy_neff.out
