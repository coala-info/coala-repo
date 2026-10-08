cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_apply
label: ffindex_ffindex_apply
doc: "Run a program on every entry of an ffindex. Results go to standard output or\
  \ to a new ffindex.\n\nTool homepage: https://github.com/soedinglab/ffindex_soedinglab"
inputs:
  - id: data_file
    type: File
    doc: Input ffindex data file
    inputBinding:
      position: 3
  - id: index_file
    type: File
    doc: Input ffindex index file
    inputBinding:
      position: 4
  - id: program
    type: string
    doc: Program to be executed for every ffindex entry
    inputBinding:
      position: 6
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments of the program
    inputBinding:
      position: 7
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: silence the logging of every processed entry
    inputBinding:
      position: 1
      prefix: -q
  - id: keep_splits
    type:
      - 'null'
      - boolean
    doc: keep unmerged ffindex splits
    inputBinding:
      position: 1
      prefix: -k
  - id: out_data_file
    type:
      - 'null'
      - string
    doc: FFindex data file where the results will be saved to
    inputBinding:
      position: 2
      prefix: -d
  - id: out_index_file
    type:
      - 'null'
      - string
    doc: FFindex index file where the results will be saved to
    inputBinding:
      position: 2
      prefix: -i
arguments:
  - position: 5
    valueFrom: '--'
outputs:
  - id: stdout_results
    type: stdout
    doc: Program output (used when no output ffindex is given)
  - id: result_data
    type:
      - 'null'
      - File
    doc: Result ffindex data file
    outputBinding:
      glob: $(inputs.out_data_file)
  - id: result_index
    type:
      - 'null'
      - File
    doc: Result ffindex index file
    outputBinding:
      glob: $(inputs.out_index_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex_ffindex_apply.out
