cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosomer
  - fastalength
label: chromosomer_fastalength
doc: "Get lengths of sequences in the specified FASTA file (required to build a fragment
  map).\n\nTool homepage: https://github.com/gtamazian/chromosomer"
inputs:
  - id: fasta
    type: File
    doc: a FASTA file which sequence lengths are to be obtained
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: an output file of sequence lengths
    inputBinding:
      position: 2
outputs:
  - id: out_output
    type: File
    doc: an output file of sequence lengths
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
