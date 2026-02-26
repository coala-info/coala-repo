cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProteomIQon.PeptideDB
label: proteomiqon-peptidedb
doc: "Create a peptide database\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs:
  - id: fasta_path
    type:
      - 'null'
      - Directory
    doc: Specify fasta file path
    inputBinding:
      position: 101
      prefix: --fastapath
  - id: param_file
    type:
      - 'null'
      - File
    doc: Specify param file for the creation of the
    inputBinding:
      position: 101
      prefix: --paramfile
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Specify peptide data base output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-peptidedb:0.0.7--hdfd78af_1
