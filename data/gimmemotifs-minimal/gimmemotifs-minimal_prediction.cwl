cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - prediction
label: gimmemotifs-minimal_prediction
doc: "Run a specific motif prediction tool\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: params
    type:
      - 'null'
      - File
    doc: "YAML file with paramaters"
    inputBinding:
      position: 1
      prefix: -p
  - id: params_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files that the parameter YAML names (for example the background file), staged in the working directory"
  - id: name
    type: string
    doc: "Specific motif prediction tool to run"
    inputBinding:
      position: 100
  - id: input_file
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 101
  - id: output_file
    type: string
    doc: "Output PFM file"
    inputBinding:
      position: 102
outputs:
  - id: output
    type: File
    doc: "Predicted motifs in PFM format"
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.params_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
