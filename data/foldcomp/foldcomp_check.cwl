cwlVersion: v1.2
class: CommandLineTool
baseCommand: foldcomp
label: foldcomp_check
doc: "Command-line tool for compressing, decompressing, checking, and comparing protein
  structure files.\n\nTool homepage: https://github.com/steineggerlab/foldcomp"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (compress, decompress, extract, check, rmsd)
    inputBinding:
      position: 1
  - id: input1
    type: string
    doc: First input file or directory (e.g., pdb, cif, fcz, tar, dir)
    inputBinding:
      position: 2
  - id: input2
    type:
      - 'null'
      - string
    doc: Second input file or directory (e.g., fcz, pdb, fasta, dir, tar, db)
    inputBinding:
      position: 3
  - id: alternative_atom_order
    type:
      - 'null'
      - boolean
    doc: Use alternative atom order
    default: false
    inputBinding:
      position: 104
      prefix: --alt
  - id: break_interval
    type:
      - 'null'
      - int
    doc: Interval size to save absolute atom coordinates
    default: 25
    inputBinding:
      position: 104
      prefix: --break
  - id: check_fcz
    type:
      - 'null'
      - boolean
    doc: Check FCZ before and skip entries with error (only for batch 
      decompression)
    inputBinding:
      position: 104
      prefix: --check
  - id: extract_amino_acid
    type:
      - 'null'
      - boolean
    doc: Extract amino acid sequence (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --amino-acid
  - id: extract_plddt
    type:
      - 'null'
      - boolean
    doc: Extract pLDDT score (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --plddt
  - id: extract_sequence
    type:
      - 'null'
      - boolean
    doc: Extract amino acid sequence (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --fasta
  - id: file_list
    type:
      - 'null'
      - boolean
    doc: Input is a list of files
    default: false
    inputBinding:
      position: 104
      prefix: --file
  - id: id_list_file
    type:
      - 'null'
      - File
    doc: A file of id list to be processed (only for database input)
    inputBinding:
      position: 104
      prefix: --id-list
  - id: id_mode
    type:
      - 'null'
      - int
    doc: 'ID mode for database input. 0: database keys, 1: names (.lookup)'
    default: 1
    inputBinding:
      position: 104
      prefix: --id-mode
  - id: measure_time
    type:
      - 'null'
      - boolean
    doc: Measure time for compression/decompression
    inputBinding:
      position: 104
      prefix: --time
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Do not merge output files (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --no-merge
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    default: false
    inputBinding:
      position: 104
      prefix: --overwrite
  - id: plddt_digits
    type:
      - 'null'
      - string
    doc: 'Extract pLDDT score with specified number of digits (only for extraction
      mode). Options: 1 (single digit, fasta-like), 2 (2-digit, 00-99, tsv), 3 (3-digit),
      4 (4-digit, max)'
    inputBinding:
      position: 104
      prefix: --plddt-digits
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively look for files in directory
    default: false
    inputBinding:
      position: 104
      prefix: --recursive
  - id: save_as_database
    type:
      - 'null'
      - boolean
    doc: Save as database
    default: false
    inputBinding:
      position: 104
      prefix: --db
  - id: save_as_tar
    type:
      - 'null'
      - boolean
    doc: Save as tar file
    default: false
    inputBinding:
      position: 104
      prefix: --tar
  - id: skip_discontinuous
    type:
      - 'null'
      - boolean
    doc: Skip PDB with discontinuous residues (only batch compression)
    inputBinding:
      position: 104
      prefix: --skip-discontinuous
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for (de)compression of folders/tar files
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
  - id: use_cache
    type:
      - 'null'
      - boolean
    doc: Use cached index for database input
    default: false
    inputBinding:
      position: 104
      prefix: --use-cache
  - id: use_title
    type:
      - 'null'
      - boolean
    doc: Use TITLE as the output file name (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --use-title
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
stdout: foldcomp_check.out
