cwlVersion: v1.2
class: CommandLineTool
baseCommand: count
label: seqfu_count
doc: "Count sequences in paired-end aware format\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: inputfile
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: abs_path
    type:
      - 'null'
      - boolean
    doc: Print absolute paths
    inputBinding:
      position: 102
      prefix: --abs-path
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Print only filenames
    inputBinding:
      position: 102
      prefix: --basename
  - id: for_tag
    type:
      - 'null'
      - string
    doc: Forward tag
    inputBinding:
      position: 102
      prefix: --for-tag
  - id: rev_tag
    type:
      - 'null'
      - string
    doc: Reverse tag
    inputBinding:
      position: 102
      prefix: --rev-tag
  - id: threads
    type:
      - 'null'
      - int
    doc: Working threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: unpair
    type:
      - 'null'
      - boolean
    doc: Print separate records for paired end files
    inputBinding:
      position: 102
      prefix: --unpair
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_count.out
