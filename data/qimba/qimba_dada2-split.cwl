cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qimba
  - dada2-split
label: qimba_dada2-split
doc: "Split DADA2 TSV file into FASTA and simplified TSV.\n\nTool homepage: https://github.com/quadram-institute-bioscience/qimba"
inputs:
  - id: input_file
    type: File
    doc: DADA2-format TSV file containing sequences and their counts across 
      samples.
    inputBinding:
      position: 1
  - id: output_basename
    type: string
    doc: Output basename (without extension)
    inputBinding:
      position: 102
      prefix: --output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print detailed progress information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
stdout: qimba_dada2-split.out
