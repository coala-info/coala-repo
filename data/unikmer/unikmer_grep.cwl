cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer_grep
label: unikmer_grep
doc: "Search k-mers from binary files\n\nTool homepage: https://github.com/shenwei356/unikmer"
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
    doc: directory containing NCBI Taxonomy files, including nodes.dmp, 
      names.dmp, merged.dmp and delnodes.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: degenerate
    type:
      - 'null'
      - boolean
    doc: query k-mers contains degenerate base
    inputBinding:
      position: 101
      prefix: --degenerate
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite output directory
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
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: invert the sense of matching, to select non-matching records
    inputBinding:
      position: 101
      prefix: --invert-match
  - id: max_taxid
    type:
      - 'null'
      - string
    doc: for smaller TaxIds, we can use less space to store TaxIds. default 
      value is 1<<32-1, that's enough for NCBI Taxonomy TaxIds
    inputBinding:
      position: 101
      prefix: --max-taxid
  - id: multiple_outfiles
    type:
      - 'null'
      - boolean
    doc: write results into separated files for multiple input files
    inputBinding:
      position: 101
      prefix: --multiple-outfiles
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
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: out file prefix ("-" for stdout)
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: output suffix
    inputBinding:
      position: 101
      prefix: --out-suffix
  - id: query
    type:
      - 'null'
      - type: array
        items: string
    doc: query k-mers/taxids (multiple values delimted by comma supported)
    inputBinding:
      position: 101
      prefix: --query
  - id: query_file
    type:
      - 'null'
      - type: array
        items: File
    doc: query file (one k-mer/taxid per line)
    inputBinding:
      position: 101
      prefix: --query-file
  - id: query_is_taxid
    type:
      - 'null'
      - boolean
    doc: queries are taxids
    inputBinding:
      position: 101
      prefix: --query-is-taxid
  - id: query_unik_file
    type:
      - 'null'
      - type: array
        items: File
    doc: query file in .unik format
    inputBinding:
      position: 101
      prefix: --query-unik-file
  - id: repeated
    type:
      - 'null'
      - boolean
    doc: only print duplicate k-mers
    inputBinding:
      position: 101
      prefix: --repeated
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort k-mers, this significantly reduce file size for k<=25. This flag 
      overides global flag -c/--compact
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
stdout: unikmer_grep.out
