cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpGraph
label: admixtools_qpGraph
doc: "qpGraph is a tool for fitting population graphs to f-statistics.\n\nTool homepage:
  https://github.com/DReichLab/AdmixTools"
inputs:
  - id: graph_name
    type:
      - 'null'
      - File
    doc: use <nam> as graph name (graph topology file)
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
    type: File
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
  - id: out_graph_path
    type:
      - 'null'
      - string
    doc: Use this name as the output graph.
    inputBinding:
      position: 103
      prefix: -o
  - id: graph_dot_name_path
    type:
      - 'null'
      - string
    doc: Use this name for the graph dot file.
    inputBinding:
      position: 104
      prefix: -d
  - id: data_files
    type:
      type: array
      items: File
    doc: Genotype, SNP, individual and population list files that the 
      parameter file names. They are staged into the working directory, so 
      the parameter file must refer to them by file name only.
outputs:
  - id: out_graph
    type:
      - 'null'
      - File
    doc: use <nam> as out graph
    outputBinding:
      glob: $(inputs.out_graph_path)
  - id: graph_dot_name
    type:
      - 'null'
      - File
    doc: use <nam> for graph dot name
    outputBinding:
      glob: $(inputs.graph_dot_name_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_qpGraph.out
