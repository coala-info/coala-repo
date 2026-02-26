cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer merge
label: unikmer_merge
doc: "Merge k-mers from sorted chunk files\n\nTool homepage: https://github.com/shenwei356/unikmer"
inputs:
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
    default: -1
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing NCBI Taxonomy files, including nodes.dmp, 
      names.dmp, merged.dmp and delnodes.dmp
    default: '"/root/.unikmer"'
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
  - id: is_dir
    type:
      - 'null'
      - boolean
    doc: intput files are directory containing chunk files
    inputBinding:
      position: 101
      prefix: --is-dir
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
    default: 400
    inputBinding:
      position: 101
      prefix: --max-open-files
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: for smaller TaxIds, we can use less space to store TaxIds. default 
      value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds
    default: 4294967295
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
    default: '"-"'
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: pattern
    type:
      - 'null'
      - string
    doc: chunk file pattern (regular expression)
    default: ^chunk_\\d+\\.unik$
    inputBinding:
      position: 101
      prefix: --pattern
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
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: directory for intermediate files
    default: '"./"'
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
stdout: unikmer_merge.out
