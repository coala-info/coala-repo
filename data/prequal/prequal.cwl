cwlVersion: v1.2
class: CommandLineTool
baseCommand: prequal
label: prequal
doc: "PREQUAL v.1.02\n\nTool homepage: https://github.com/simonwhelan/prequal"
inputs:
  - id: input_file
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: corerun
    type:
      - 'null'
      - int
    doc: "X number of high posterior residues at beginning and end before \n\t\t\t
      a core region is defined [DEFAULT 3]"
    default: 3
    inputBinding:
      position: 102
  - id: filterjoin
    type:
      - 'null'
      - int
    doc: Extend filtering over regions of unfiltered sequence less than X 
      [DEFAULT X = 10]
    default: 10
    inputBinding:
      position: 102
  - id: filterthresh
    type:
      - 'null'
      - float
    doc: "Filter the sequences to the posterior probabilities threshold X [DEFAULT
      = 0.994]\n\t\t\t(range 0.0 - 1.0). DEFAULT filtering option with threshold"
    default: 0.994
    inputBinding:
      position: 102
  - id: nofilterlist
    type:
      - 'null'
      - File
    doc: "Specify a file X that contains a list of taxa names that will \n\t\t\tnot
      be filtered. In X one name per line."
    inputBinding:
      position: 102
  - id: pptype
    type:
      - 'null'
      - string
    doc: "Specify the algorithm used to calculate posterior probabilities\n\t\t\t\
      X = all : for all against all sequence comparisons\n\t\t\tX = closest : for
      Y closest relatives [DEFAULT; Y = 10]\n\t\t\tX = longest : for comparing the
      Y longest sequences [Y = 10]"
    default: closest
    inputBinding:
      position: 102
  - id: pptype_y
    type:
      - 'null'
      - int
    doc: Number of closest or longest sequences for pptype option
    default: 10
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prequal:1.02--hb97b32f_2
stdout: prequal.out
