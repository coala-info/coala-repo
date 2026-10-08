cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/LengthFilter.py
label: desman_LengthFilter.py
doc: "Keep the FASTA sequences longer than a minimum length and write them to
  stdout.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: inputfile
    type: File
    doc: fasta file
    inputBinding:
      position: 10
  - id: minlength
    type:
      - 'null'
      - float
    doc: minimum sequence length to keep (default 1000)
    inputBinding:
      position: 1
      prefix: -m
  - id: output_name
    type: string
    doc: Name of the file that receives the filtered FASTA written to stdout
    default: filtered.fa
outputs:
  - id: filtered
    type: File
    doc: Sequences longer than the minimum length (FASTA)
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
