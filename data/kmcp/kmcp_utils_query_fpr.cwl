cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - utils
  - query-fpr
label: kmcp_utils_query_fpr
doc: "Compute the false positive rate of a query\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: add_header
    type: ['null', boolean]
    doc: "Add header line (column names)"
    inputBinding:
      position: 1
      prefix: "--add-header"
  - id: all
    type: ['null', boolean]
    doc: "Also show the value of -f, -n, and -t"
    inputBinding:
      position: 1
      prefix: "--all"
  - id: false_positive_rate
    type: ['null', float]
    doc: "False positive rate of a single k-mer, i.e., FPR of the bloom filters in the database. range: (0, 1) (default 0.3)"
    inputBinding:
      position: 1
      prefix: "--false-positive-rate"
  - id: matched_kmers
    type: ['null', int]
    doc: "The number of matched k-mers of a query (default 35)"
    inputBinding:
      position: 1
      prefix: "--matched-kmers"
  - id: num_kmers
    type: ['null', int]
    doc: "Number of unique k-mers of the query (default 70)"
    inputBinding:
      position: 1
      prefix: "--num-kmers"
  - id: out_file
    type: ['null', string]
    default: "query_fpr.txt"
    doc: "Out file, supports a \".gz\" suffix (\"-\" for stdout)"
    inputBinding:
      position: 1
      prefix: "--out-file"
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
stdout: kmcp_utils_query_fpr.out
