cwlVersion: v1.2
class: CommandLineTool
baseCommand: foldcomp
label: foldcomp_extract
doc: "Command-line tool for manipulating PDB/CIF files, including compression, decompression,
  extraction, and comparison.\n\nTool homepage: https://github.com/steineggerlab/foldcomp"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (compress, decompress, extract, check, rmsd)
    inputBinding:
      position: 1
  - id: input_format_or_file
    type: string
    doc: Input format (pdb|cif) or file/directory/tar/db
    inputBinding:
      position: 2
  - id: output_file_or_format
    type:
      - 'null'
      - string
    doc: Output file or format (fcz, pdb, dir, tar, db, fasta)
    inputBinding:
      position: 3
  - id: alternative_atom_order
    type:
      - 'null'
      - boolean
    doc: use alternative atom order
    inputBinding:
      position: 104
      prefix: --alt
  - id: break_interval
    type:
      - 'null'
      - int
    doc: interval size to save absolute atom coordinates
    inputBinding:
      position: 104
      prefix: --break
  - id: check_fcz
    type:
      - 'null'
      - boolean
    doc: check FCZ before and skip entries with error (only for batch 
      decompression)
    inputBinding:
      position: 104
      prefix: --check
  - id: extract_amino_acid_sequence
    type:
      - 'null'
      - boolean
    doc: extract amino acid sequence (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --amino-acid
  - id: extract_fasta
    type:
      - 'null'
      - boolean
    doc: extract amino acid sequence (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --fasta
  - id: extract_plddt
    type:
      - 'null'
      - boolean
    doc: extract pLDDT score (only for extraction mode)
    inputBinding:
      position: 104
      prefix: --plddt
  - id: file_input
    type:
      - 'null'
      - boolean
    doc: input is a list of files
    inputBinding:
      position: 104
      prefix: --file
  - id: id_list_file
    type:
      - 'null'
      - File
    doc: a file of id list to be processed (only for database input)
    inputBinding:
      position: 104
      prefix: --id-list
  - id: id_mode
    type:
      - 'null'
      - int
    doc: 'id mode for database input. 0: database keys, 1: names (.lookup)'
    inputBinding:
      position: 104
      prefix: --id-mode
  - id: measure_time
    type:
      - 'null'
      - boolean
    doc: measure time for compression/decompression
    inputBinding:
      position: 104
      prefix: --time
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: do not merge output files (only for extraction mode)
    inputBinding:
      position: 104
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite existing files
    inputBinding:
      position: 104
      prefix: --overwrite
  - id: plddt_digits
    type:
      - 'null'
      - string
    doc: 'extract pLDDT score with specified number of digits (only for extraction
      mode) - 1: single digit (fasta-like format), 2: 2-digit(00-99; tsv), 3: 3-digit,
      4: 4-digit (max)'
    inputBinding:
      position: 104
      prefix: --plddt-digits
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: recursively look for files in directory
    inputBinding:
      position: 104
      prefix: --recursive
  - id: save_as_database
    type:
      - 'null'
      - boolean
    doc: save as database
    inputBinding:
      position: 104
      prefix: --db
  - id: save_as_tar
    type:
      - 'null'
      - boolean
    doc: save as tar file
    inputBinding:
      position: 104
      prefix: --tar
  - id: skip_discontinuous
    type:
      - 'null'
      - boolean
    doc: skip PDB with with discontinuous residues (only batch compression)
    inputBinding:
      position: 104
  - id: threads
    type:
      - 'null'
      - int
    doc: threads for (de)compression of folders/tar files
    inputBinding:
      position: 104
      prefix: --threads
  - id: use_cache
    type:
      - 'null'
      - boolean
    doc: use cached index for database input
    inputBinding:
      position: 104
      prefix: --use-cache
  - id: use_title_as_filename
    type:
      - 'null'
      - boolean
    doc: use TITLE as the output file name (only for extraction mode)
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
stdout: foldcomp_extract.out
