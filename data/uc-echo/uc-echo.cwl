cwlVersion: v1.2
class: CommandLineTool
baseCommand: ErrorCorrection.py
label: uc-echo
doc: "Error correction tool\n\nTool homepage: https://github.com/dh-orko/Help-me-get-rid-of-unhumans"
inputs:
  - id: read_file_name
    type: File
    doc: Input read file name
    inputBinding:
      position: 1
  - id: block_size
    type:
      - 'null'
      - int
    doc: Split data into blocks of specified size
    inputBinding:
      position: 102
      prefix: --block_size
  - id: hash_merge_batch_size
    type:
      - 'null'
      - int
    doc: Merge n adjacency lists at a time
    inputBinding:
      position: 102
      prefix: --hm
  - id: heterozygous_rate
    type:
      - 'null'
      - float
    doc: Rate for heterozygous site
    inputBinding:
      position: 102
      prefix: --h_rate
  - id: keep_all_files
    type:
      - 'null'
      - boolean
    doc: Keep all temporary files. By default, temporary files are deleted 
      automatically.
    inputBinding:
      position: 102
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size used for hashing
    inputBinding:
      position: 102
      prefix: --kmer
  - id: log_filename
    type:
      - 'null'
      - File
    doc: Log file name
    inputBinding:
      position: 102
      prefix: --log
  - id: max_error_tolerance
    type:
      - 'null'
      - float
    doc: Maximum error tolerance for parameter searching
    inputBinding:
      position: 102
      prefix: --max_error_tolerance
  - id: max_minimum_overlap
    type:
      - 'null'
      - int
    doc: Maximum minimum overlap length for parameter searching
    inputBinding:
      position: 102
      prefix: --hH
  - id: min_error_tolerance
    type:
      - 'null'
      - float
    doc: Minimum error tolerance for parameter searching
    inputBinding:
      position: 102
      prefix: --min_error_tolerance
  - id: min_minimum_overlap
    type:
      - 'null'
      - int
    doc: Minimum minimum overlap length for parameter searching
    inputBinding:
      position: 102
      prefix: --hh
  - id: model_selection_size
    type:
      - 'null'
      - int
    doc: Model selection data set size
    inputBinding:
      position: 102
  - id: n_hash_block
    type:
      - 'null'
      - int
    doc: Split hash table into n tables
    inputBinding:
      position: 102
      prefix: --nh
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of processes used in training
    inputBinding:
      position: 102
      prefix: --ncpu
  - id: read_merge_size
    type:
      - 'null'
      - int
    doc: Merge n hash tables at a time
    inputBinding:
      position: 102
      prefix: --rm
  - id: tmp_directory
    type:
      - 'null'
      - Directory
    doc: Temporary data directory
    inputBinding:
      position: 102
      prefix: --DD
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/uc-echo:v1.12-11-deb_cv1
