cwlVersion: v1.2
class: CommandLineTool
baseCommand: reformat.pl
label: hhsuite_reformat.pl
doc: "Read a multiple alignment in one format and write it in another format\n\nTool
  homepage: https://github.com/soedinglab/hh-suite"
inputs:
  - id: informat
    type:
      - 'null'
      - string
    doc: Input format (fas, a2m, a3m, sto, psi, clu). If no input or output format is given the file extension is interpreted as format specification ('aln' as 'clu').
    inputBinding:
      position: 1
  - id: outformat
    type:
      - 'null'
      - string
    doc: Output format (fas, a2m, a3m, sto, psi, clu)
    inputBinding:
      position: 2
  - id: infile
    type: File
    doc: Input alignment file
    inputBinding:
      position: 3
  - id: outfile_path
    type: string
    doc: Output alignment file
    inputBinding:
      position: 4
  - id: add_number_prefix
    type:
      - 'null'
      - boolean
    doc: "add number prefix to sequence names: 'name', '1:name' '2:name' etc"
    inputBinding:
      position: 106
      prefix: -num
  - id: keep_solvent_accessibility
    type:
      - 'null'
      - boolean
    doc: do not remove solvent accessibility sequences (beginning with >sa_)
    inputBinding:
      position: 106
      prefix: -sa
  - id: lowercase_residues
    type:
      - 'null'
      - boolean
    doc: write all residues in lower case (AFTER all other options have been 
      processed)
    inputBinding:
      position: 106
      prefix: -lc
  - id: match_columns
    type:
      - 'null'
      - string
    doc: "'first' makes all columns with residue in first sequence match columns (default for output format a2m or a3m); an integer X makes all columns with less than X% gaps match columns (for output format a2m or a3m)"
    inputBinding:
      position: 106
      prefix: -M
  - id: max_nameline_characters
    type:
      - 'null'
      - int
    doc: maximum number of characers in nameline
    inputBinding:
      position: 106
      prefix: -d
  - id: remove_lowercase_columns_with_gap_percentage
    type:
      - 'null'
      - int
    doc: remove all lower case columns with more than X% gaps
    inputBinding:
      position: 106
      prefix: -r
  - id: remove_lowercase_residues
    type:
      - 'null'
      - boolean
    doc: remove all lower case residues (insert states) (AFTER -M option has 
      been processed). Do not combine with remove_lowercase_columns_with_gap_percentage.
    inputBinding:
      position: 106
      prefix: -r
  - id: remove_secondary_structure
    type:
      - 'null'
      - boolean
    doc: remove secondary structure sequences (beginning with >ss_)
    inputBinding:
      position: 106
      prefix: -noss
  - id: residues_per_line
    type:
      - 'null'
      - int
    doc: number of residues per line (for Clustal, FASTA, A2M, A3M formats)
    inputBinding:
      position: 106
      prefix: -l
  - id: suppress_gaps
    type:
      - 'null'
      - boolean
    doc: suppress all gaps (-g '')
    inputBinding:
      position: 106
      valueFrom: '$(self ? ["-g", ""] : [])'
  - id: uppercase_residues
    type:
      - 'null'
      - boolean
    doc: write all residues in upper case (AFTER all other options have been 
      processed)
    inputBinding:
      position: 106
      prefix: -uc
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbose mode (0:off, 1:on)
    inputBinding:
      position: 106
      prefix: -v
  - id: write_gaps_as_dash
    type:
      - 'null'
      - boolean
    doc: write all gaps as '-' (-g '-')
    inputBinding:
      position: 106
      valueFrom: '$(self ? ["-g", "-"] : [])'
outputs:
  - id: outfile
    type: File
    doc: Output alignment file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
