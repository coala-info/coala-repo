cwlVersion: v1.2
class: CommandLineTool
baseCommand: Filter_tooshort.py
label: metabinner_Filter_tooshort.py
doc: "Filters out short sequences from a FASTA file.\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: k
    type: int
    doc: Minimum sequence length to keep
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: metabinner_Filter_tooshort.py.out
