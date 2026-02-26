cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpGraph
label: admixtools_qpGraph
doc: "qpGraph is a tool for fitting population graphs to f-statistics.\n\nTool homepage:
  https://github.com/DReichLab/AdmixTools"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: graph_name
    type:
      - 'null'
      - string
    doc: use <nam> as graph name
    inputBinding:
      position: 102
      prefix: -g
  - id: lambda_scale
    type:
      - 'null'
      - float
    doc: use <val> as lambda scale value
    inputBinding:
      position: 102
      prefix: -l
  - id: outlier_name
    type:
      - 'null'
      - string
    doc: use <nam> as oulier name
    inputBinding:
      position: 102
      prefix: -x
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: use parameters from <file>
    inputBinding:
      position: 102
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: use <val> seed
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: toggle verbose mode ON
    inputBinding:
      position: 102
      prefix: -V
  - id: z_threshold
    type:
      - 'null'
      - float
    doc: use <val> as Z threshold
    inputBinding:
      position: 102
      prefix: -z
outputs:
  - id: out_graph
    type:
      - 'null'
      - File
    doc: use <nam> as out graph
    outputBinding:
      glob: $(inputs.out_graph)
  - id: graph_dot_name
    type:
      - 'null'
      - File
    doc: use <nam> for graph dot name
    outputBinding:
      glob: $(inputs.graph_dot_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
