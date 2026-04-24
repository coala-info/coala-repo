cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer_union
label: unikmer_union
doc: "Union of k-mers in multiple binary files\n\nTool homepage: https://github.com/shenwei356/unikmer"
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
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: "directory containing NCBI Taxonomy files, including nodes.dmp,\n       \
      \                         names.dmp, merged.dmp and delnodes.dmp"
    inputBinding:
      position: 101
      prefix: --data-dir
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
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                           appended to files from cli arguments"
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: "for smaller TaxIds, we can use less space to store TaxIds. default value\n\
      \                                is 1<<32-1, that's enough for NCBI Taxonomy
      TaxIds"
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
  - id: sort
    type:
      - 'null'
      - boolean
    doc: "sort k-mers, this significantly reduce file size for k<=25. This flag\n\
      \                            overides global flag -c/--compact"
    inputBinding:
      position: 101
      prefix: --sort
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs to use
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
stdout: unikmer_union.out
