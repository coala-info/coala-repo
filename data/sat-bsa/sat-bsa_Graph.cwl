cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Sat-BSA
  - -w
  - Graph
label: sat-bsa_Graph
doc: "Draw graphs of the P-value and the SV regions from the SVs_detection result.\n\nTool homepage: https://github.com/SegawaTenta/Sat-BSA"
inputs:
  - id: result_file
    type: File
    doc: Full path of result.txt which is an output from SVs_detection command.
    inputBinding:
      position: 1
      prefix: -r
  - id: graph_data
    type: File
    doc: Full path of graph_data.txt listing the path to directory constructed by SVs_detection command and color used for the line of graph (Input format 6).
    inputBinding:
      position: 2
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number.
    inputBinding:
      position: 3
      prefix: -t
  - id: data_files
    type:
      type: array
      items: File
    doc: Files named in the list files. They are staged into the working directory /work, so list files must name them as /work/<file name>.
outputs:
  - id: graphs
    type:
      type: array
      items: File
    doc: Graph images, one per gene
    outputBinding:
      glob: "*.png"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sat-bsa:1.12--hdfd78af_1
    dockerOutputDirectory: /work
