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
    doc: Input format (e.g., fas, a2m, a3m, sto, psi, clu)
    inputBinding:
      position: 1
  - id: outformat
    type:
      - 'null'
      - string
    doc: Output format (e.g., fas, a2m, a3m, sto, psi, clu)
    inputBinding:
      position: 2
  - id: fileglob
    type:
      - 'null'
      - string
    doc: File glob pattern for input files
    inputBinding:
      position: 3
  - id: infile
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 4
  - id: output_extension
    type:
      - 'null'
      - string
    doc: Extension for output files
    inputBinding:
      position: 5
  - id: add_number_prefix
    type:
      - 'null'
      - boolean
    doc: "add number prefix to sequence names: 'name', '1:name' '2:name' etc"
    inputBinding:
      position: 106
      prefix: --num
  - id: keep_solvent_accessibility
    type:
      - 'null'
      - boolean
    doc: do not remove solvent accessibility sequences (beginning with >sa_)
    inputBinding:
      position: 106
      prefix: --sa
  - id: lowercase_residues
    type:
      - 'null'
      - boolean
    doc: write all residues in lower case (AFTER all other options have been 
      processed)
    inputBinding:
      position: 106
      prefix: -lc
  - id: match_columns_with_gap_percentage
    type:
      - 'null'
      - int
    doc: make all columns with less than X% gaps match columns (for output 
      format a2m or a3m)
    inputBinding:
      position: 106
      prefix: -M
  - id: match_residue_in_first_sequence
    type:
      - 'null'
      - boolean
    doc: make all columns with residue in first sequence match columns (default 
      for output format a2m or a3m)
    inputBinding:
      position: 106
      prefix: -M first
  - id: max_nameline_characters
    type:
      - 'null'
      - int
    doc: maximum number of characers in nameline
    default: 1000
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
      been processed)
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
      prefix: --noss
  - id: residues_per_line
    type:
      - 'null'
      - int
    doc: number of residues per line (for Clustal, FASTA, A2M, A3M formats)
    default: 100
    inputBinding:
      position: 106
      prefix: -l
  - id: suppress_gaps
    type:
      - 'null'
      - string
    doc: suppress all gaps
    inputBinding:
      position: 106
      prefix: -g ''
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
      - string
    doc: write all gaps as '-'
    inputBinding:
      position: 106
      prefix: -g '-'
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
