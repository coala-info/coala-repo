cwlVersion: v1.2
class: CommandLineTool
baseCommand: nasp
label: nasp
doc: "This is the \"Northern Arizona SNP Pipeline\", version 1.2.0\n\nTool homepage:
  https://github.com/TGenNorth/nasp"
inputs:
  - id: reference_fasta
    type: File
    doc: Path to the reference fasta.
    inputBinding:
      position: 1
  - id: output_folder
    type: Directory
    doc: Folder to store the output files.
    inputBinding:
      position: 2
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the configuration xml file.
    inputBinding:
      position: 103
      prefix: --config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
stdout: nasp.out
