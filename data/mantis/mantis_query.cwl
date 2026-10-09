cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mantis
  - query
label: mantis_query
doc: 'Query a mantis index with sequences (one sequence per line) and report the samples
  that contain their k-mers.


  Tool homepage: https://github.com/splatlab/mantis'
inputs:
  - id: use_colorclasses
    type:
      - 'null'
      - boolean
    doc: Use color classes as the color info representation instead of MST
    inputBinding:
      position: 1
      prefix: '-1'
  - id: json
    type:
      - 'null'
      - boolean
    doc: Write the output in JSON format
    inputBinding:
      position: 1
      prefix: -j
  - id: kmer
    type:
      - 'null'
      - int
    doc: size of k for kmer
    inputBinding:
      position: 1
      prefix: -k
  - id: index_prefix
    type: Directory
    doc: Directory of the mantis index
    inputBinding:
      position: 2
      prefix: -p
      valueFrom: $(self.path)/
  - id: output_file
    type:
      - 'null'
      - string
    doc: Where to write query output
    inputBinding:
      position: 3
      prefix: -o
  - id: query
    type: File
    doc: Query file with one sequence per line
    inputBinding:
      position: 4
outputs:
  - id: query_result
    type:
      - 'null'
      - File
    doc: Query result file
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_query.out
