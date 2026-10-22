cwlVersion: v1.2
class: CommandLineTool
baseCommand: [short_read_connector_counter.sh, query]
label: short-read-connector_short_read_connector_counter.sh_query
doc: "Query an index with a file of read files (short_read_connector counter mode).\n\nTool homepage: https://github.com/GATB/short_read_connector"
inputs:
  - id: index_name
    type: string
    doc: "Name of the index created by the index command, e.g. my_index.dumped (the index files are staged in the working directory)"
    inputBinding:
      position: 102
      prefix: -i
  - id: index_files
    type: File[]
    doc: "Index files created by the index command"
  - id: query_fof
    type: File
    doc: "Read file of files for the query (one file name per line)"
    inputBinding:
      position: 103
      prefix: -q
      valueFrom: $(self.basename)
  - id: query_files
    type: File[]
    doc: "Read files named in the query file of files (staged in the working directory)"
  - id: window_size
    type: ['null', int]
    doc: "Window size. If zero (default), the full read is considered. Default=0"
    inputBinding:
      position: 101
      prefix: -w
  - id: kmer_threshold
    type: ['null', int]
    doc: "Minimal percentage of shared kmer span for considering a query read as similar"
    inputBinding:
      position: 101
      prefix: -s
  - id: keep_low_complexity
    type: ['null', boolean]
    doc: "Keep low complexity regions (default false)"
    inputBinding:
      position: 101
      prefix: -l
  - id: prefix
    type: ['null', string]
    doc: "Prefix of all output files. Default=short_read_connector_res"
    inputBinding:
      position: 101
      prefix: -p
  - id: threads
    type: ['null', int]
    doc: "Number of threads used. Default=0 (all)"
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results
    type: File[]
    doc: "Result files (named with the prefix)"
    outputBinding:
      glob: $(inputs.prefix || 'short_read_connector_res')*
stdout: short-read-connector_short_read_connector_counter.sh_query.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index_files)
      - entry: $(inputs.query_fof)
        writable: true
      - entry: $(inputs.query_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/short-read-connector:1.2.0--h5ca1c30_3
