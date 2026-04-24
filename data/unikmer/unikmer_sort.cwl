cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer sort
label: unikmer_sort
doc: "Sort k-mers to reduce the file size and accelerate downstream analysis\n\nTool
  homepage: https://github.com/shenwei356/unikmer"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: split input into chunks of N k-mers, supports K/M/G suffix, type 
      "unikmer sort -h" for detail
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: compact
    type:
      - 'null'
      - boolean
    doc: write compact binary file with little loss of speed
    inputBinding:
      position: 101
      prefix: --compact
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing NCBI Taxonomy files, including nodes.dmp, 
      names.dmp, merged.dmp and delnodes.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite tmp dir
    inputBinding:
      position: 101
      prefix: --force
  - id: ignore_taxid
    type:
      - 'null'
      - boolean
    doc: ignore taxonomy information
    inputBinding:
      position: 101
      prefix: --ignore-taxid
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: keep_tmp_dir
    type:
      - 'null'
      - boolean
    doc: keep tmp dir
    inputBinding:
      position: 101
      prefix: --keep-tmp-dir
  - id: max_open_files
    type:
      - 'null'
      - int
    doc: max number of open files
    inputBinding:
      position: 101
      prefix: --max-open-files
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: for smaller TaxIds, we can use less space to store TaxIds. default 
      value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds
    inputBinding:
      position: 101
      prefix: --max-taxid
  - id: no_compress
    type:
      - 'null'
      - boolean
    doc: do not compress binary file (not recommended)
    inputBinding:
      position: 101
      prefix: --no-compress
  - id: nocheck_file
    type:
      - 'null'
      - boolean
    doc: do not check binary file, when using process substitution or named pipe
    inputBinding:
      position: 101
      prefix: --nocheck-file
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: out file prefix ("-" for stdout)
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: repeated
    type:
      - 'null'
      - boolean
    doc: only print duplicate k-mers
    inputBinding:
      position: 101
      prefix: --repeated
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: directory for intermediate files
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: unique
    type:
      - 'null'
      - boolean
    doc: remove duplicate k-mers
    inputBinding:
      position: 101
      prefix: --unique
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
stdout: unikmer_sort.out
