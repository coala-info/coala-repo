cwlVersion: v1.2
class: CommandLineTool
baseCommand: happer
label: happer
doc: "Write haplotype sequences to the specified file\n\nTool homepage: https://github.com/bioforensics/happer/"
inputs:
  - id: seqfile
    type: File
    doc: input sequences in Fasta format
    inputBinding:
      position: 1
  - id: bed
    type: File
    doc: haplotypes annotated in BED format
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write haplotype sequences to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happer:0.1.1--py_0
