cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnavirhost predict
label: rnavirhost_predict
doc: "Predict hosts of the query viruses\n\nTool homepage: https://github.com/GreyGuoweiChen/VirHost.git"
inputs:
  - id: input_file
    type: File
    doc: The query fasta file.
    inputBinding:
      position: 101
      prefix: --input
  - id: taxa_file
    type: File
    doc: The virus order taxa of query sequences. (.csv)
    inputBinding:
      position: 101
      prefix: --taxa
outputs:
  - id: output_directory
    type: Directory
    doc: "The output directory，including the output and\n                        intermediate
      file."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnavirhost:1.0.5--pyh7cba7a3_0
