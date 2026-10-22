cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr-screen.py
label: superstr_superstr-screen.py
doc: "Screen repeat motifs for differences between case groups and controls (Mann-Whitney statistic of information scores with permutation testing).\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs:
  - id: manifest
    type: File
    doc: path to manifest file
    inputBinding:
      position: 1
      prefix: -m
  - id: input_path
    type: Directory
    doc: input path (output of superstr-multiparse.py)
    inputBinding:
      position: 2
      prefix: -i
  - id: output
    type: string
    doc: output prefix
    inputBinding:
      position: 3
      prefix: -o
  - id: label
    type:
      - 'null'
      - string
    doc: column label to use for group status
    inputBinding:
      position: 4
      prefix: --label
  - id: control_label
    type:
      - 'null'
      - string
    doc: label used for controls
    inputBinding:
      position: 5
      prefix: --controllab
  - id: swap_labels
    type:
      - 'null'
      - boolean
    doc: use manifest file labels
    inputBinding:
      position: 6
      prefix: --swaplabs
  - id: nprocs
    type:
      - 'null'
      - int
    doc: Number of processes (default 6)
    inputBinding:
      position: 7
      prefix: '-@'
  - id: min_motif
    type:
      - 'null'
      - int
    doc: Minimum motif length (inclusive, default 3)
    inputBinding:
      position: 8
      prefix: --min_motif
  - id: max_motif
    type:
      - 'null'
      - int
    doc: Maximum motif length (inclusive, default 6)
    inputBinding:
      position: 9
      prefix: --max_motif
  - id: permutations
    type:
      - 'null'
      - int
    doc: Number of permutations (default 10,000)
    inputBinding:
      position: 10
      prefix: '-p'
  - id: min_thresh
    type:
      - 'null'
      - int
    doc: Minimum number of samples for a group to be tested
    inputBinding:
      position: 11
      prefix: --min_thresh
outputs:
  - id: screen_results
    type:
      type: array
      items: File
    doc: Screening results written with the output prefix
    outputBinding:
      glob: "$(inputs.output)*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
