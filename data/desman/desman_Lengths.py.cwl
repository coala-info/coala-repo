cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Lengths.py
label: desman_Lengths.py
doc: "Print the identifier and length of each sequence in a FASTA file as a
  tab-separated table.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: inputfile
    type: File
    doc: fasta file
    inputBinding:
      position: 1
      prefix: --inputfile=
      separate: false
  - id: output_name
    type: string
    doc: Name of the file that receives the length table written to stdout
    default: lengths.tsv
outputs:
  - id: lengths
    type: File
    doc: Sequence id and length (TSV)
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
