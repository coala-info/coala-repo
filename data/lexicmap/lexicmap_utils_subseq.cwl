cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lexicmap
  - utils
  - subseq
label: lexicmap_utils_subseq
doc: "Extract subsequences from the index by genome ID, sequence ID and region, or from search results.\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: index
    type: Directory
    doc: 'Index directory created by "lexicmap index".'
    inputBinding:
      position: 1
      prefix: -d
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: 'Size of buffer, supported unit: K, M, G. [20M]'
    inputBinding:
      position: 2
      prefix: -b
  - id: downstream
    type:
      - 'null'
      - int
    doc: 'Extract extra N bp on the downstream of the aligned/specified region.'
    inputBinding:
      position: 3
      prefix: -D
  - id: ignore_err
    type:
      - 'null'
      - boolean
    doc: 'Ignore errors such as ''reference name not found'' or ''failed to extract subsequence''.'
    inputBinding:
      position: 4
      prefix: -e
  - id: line_width
    type:
      - 'null'
      - int
    doc: 'Line width of sequence (0 for no wrap). [60]'
    inputBinding:
      position: 5
      prefix: -w
  - id: max_open_files
    type:
      - 'null'
      - int
    doc: 'Maximum opened files. [1024]'
    inputBinding:
      position: 6
      prefix: --max-open-files
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: 'The search result file has no header row.'
    inputBinding:
      position: 7
      prefix: -H
  - id: out_file
    type:
      - 'null'
      - string
    doc: 'Out file, supports the ".gz" suffix'
    inputBinding:
      position: 8
      prefix: -o
  - id: ref_name
    type:
      - 'null'
      - string
    doc: 'Reference name (genome ID).'
    inputBinding:
      position: 9
      prefix: -n
  - id: region
    type:
      - 'null'
      - string
    doc: 'Region of the subsequence (1-based).'
    inputBinding:
      position: 10
      prefix: -r
  - id: revcom
    type:
      - 'null'
      - boolean
    doc: 'Extract subsequence on the negative strand.'
    inputBinding:
      position: 11
      prefix: -R
  - id: search_result
    type:
      - 'null'
      - File
    doc: 'Use search result file from "lexicmap search" as input.'
    inputBinding:
      position: 12
      prefix: -f
  - id: seq_id
    type:
      - 'null'
      - string
    doc: 'Sequence ID. If the value is empty, the positions in the region are treated as that in the concatenated sequence.'
    inputBinding:
      position: 13
      prefix: -s
  - id: upstream
    type:
      - 'null'
      - int
    doc: 'Extract extra N bp on the upstream of the aligned/specified region.'
    inputBinding:
      position: 14
      prefix: -U
  - id: infile_list
    type:
      - 'null'
      - File
    doc: 'File of input file list (one file per line). If given, they are appended to files from CLI arguments.'
    inputBinding:
      position: 90
      prefix: -X
  - id: log
    type:
      - 'null'
      - string
    doc: 'Log file.'
    inputBinding:
      position: 91
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Do not print any verbose information. But you can write them to a file with --log.'
    inputBinding:
      position: 92
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores to use. By default, it uses all available cores.'
    inputBinding:
      position: 93
      prefix: -j
outputs:
  - id: output
    type: File?
    doc: 'The extracted subsequences'
    outputBinding:
      glob: $(inputs.out_file)
  - id: log_out
    type: File?
    doc: 'Log file, written when log is set'
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
