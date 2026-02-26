cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer_num
label: unikmer_num
doc: "Quickly inspect the number of k-mers in binary files\n\nTool homepage: https://github.com/shenwei356/unikmer"
inputs:
  - id: basename
    type:
      - 'null'
      - boolean
    doc: only output basename of files
    inputBinding:
      position: 101
      prefix: --basename
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
    default: /root/.unikmer
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: file_name
    type:
      - 'null'
      - boolean
    doc: show file name
    inputBinding:
      position: 101
      prefix: --file-name
  - id: force
    type:
      - 'null'
      - boolean
    doc: read the whole file and count k-mers
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
      - string
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
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
  - id: out_file
    type:
      - 'null'
      - string
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    default: '"- " for stdout, suffix .gz for gzipped out)'
    inputBinding:
      position: 101
      prefix: --out-file
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
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
stdout: unikmer_num.out
