cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - utils
  - filter
label: kmcp_utils_filter
doc: "Filter search results and find species/assembly-specific queries\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: level
    type: ['null', string]
    doc: "Level to filter. available values: species, strain/assembly (default \"species\")"
    inputBinding:
      position: 1
      prefix: "--level"
  - id: line_chunk_size
    type: ['null', int]
    doc: "Number of lines to process for each thread (default 5000)"
    inputBinding:
      position: 1
      prefix: "--line-chunk-size"
  - id: max_fpr
    type: ['null', float]
    doc: "Maximum false positive rate of a read in search result (default 0.05)"
    inputBinding:
      position: 1
      prefix: "--max-fpr"
  - id: min_query_cov
    type: ['null', float]
    doc: "Minimum query coverage of a read in search result (default 0.55)"
    inputBinding:
      position: 1
      prefix: "--min-query-cov"
  - id: no_header_row
    type: ['null', boolean]
    doc: "Do not print header row"
    inputBinding:
      position: 1
      prefix: "--no-header-row"
  - id: out_file
    type: ['null', string]
    default: "kmcp_filtered.tsv.gz"
    doc: "Out file, supports a \".gz\" suffix (\"-\" for stdout)"
    inputBinding:
      position: 1
      prefix: "--out-file"
  - id: taxdump
    type: ['null', Directory]
    doc: "Directory of NCBI taxonomy dump files: names.dmp, nodes.dmp, optional with merged.dmp and delnodes.dmp"
    inputBinding:
      position: 1
      prefix: "--taxdump"
  - id: taxid_map
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --taxid-map
    doc: "Tabular two-column file(s) mapping reference IDs to TaxIds"
    inputBinding:
      position: 1
  - id: search_results
    type:
      type: array
      items: File
    doc: "Search result files"
    inputBinding:
      position: 50
  - id: infile_list
    type: ['null', File]
    doc: "File of input files list (one file per line). If given, they are appended to files from CLI arguments. The listed files must be given in infile_list_files"
    inputBinding:
      position: 1
      prefix: "--infile-list"
  - id: infile_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in infile_list, staged in the working directory"
  - id: log_file
    type: ['null', string]
    doc: "Log file"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print any verbose information. But you can write them to file with --log"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: threads
    type: ['null', int]
    doc: "Number of CPUs cores to use (default 20)"
    inputBinding:
      position: 1
      prefix: "--threads"
outputs:
  - id: out_file_out
    type: ['null', File]
    doc: "Output file written with --out-file"
    outputBinding:
      glob: $(inputs.out_file)
  - id: log
    type: ['null', File]
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile_list_files)
      - $(inputs.infile_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_utils_filter.out
