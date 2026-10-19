cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - complexity
  - fasta
label: quasitools_complexity_fasta
doc: "Report the per-amplicon complexity of a quasispecies FASTA file using several measures (Gregori et al. 2016).\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: fasta_location
    type: File
    doc: "FASTA file of the amplicon sequences"
    inputBinding:
      position: 1
  - id: output_location
    type:
      - 'null'
      - string
    doc: "Output the quasispecies complexity in CSV format to the specified file."
    inputBinding:
      position: 100
      prefix: --output_location
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Complexity CSV file
    outputBinding:
      glob: $(inputs.output_location)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
