cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmcp_merge
label: kmcp_merge
doc: "Merge search results from multiple databases\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: search_results
    type:
      type: array
      items: File
    doc: Search results files
    inputBinding:
      position: 1
  - id: field_hits
    type:
      - 'null'
      - int
    doc: Field of hits.
    default: 5
    inputBinding:
      position: 102
      prefix: --field-hits
  - id: field_queryidx
    type:
      - 'null'
      - int
    doc: Field of queryIdx.
    default: 15
    inputBinding:
      position: 102
      prefix: --field-queryIdx
  - id: infile_list
    type:
      - 'null'
      - string
    doc: File of input files list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 102
      prefix: --infile-list
  - id: log
    type:
      - 'null'
      - string
    doc: Log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: Do not print header row.
    inputBinding:
      position: 102
      prefix: --no-header-row
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to file 
      with --log.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sort_by
    type:
      - 'null'
      - string
    doc: Sort hits by "qcov", "tcov" or "jacc" (Jaccard Index).
    default: qcov
    inputBinding:
      position: 102
      prefix: --sort-by
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs cores to use.
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Out file, supports and recommends a ".gz" suffix ("-" for stdout).
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
