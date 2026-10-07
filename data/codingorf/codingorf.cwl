cwlVersion: v1.2
class: CommandLineTool
baseCommand: codingorf
label: codingorf
doc: "Find translatable ORFs in an input nucleotide sequence. Prints, for each of the
  six reading frames that has an ORF, the frame sequence followed by each translated
  ORF (M...*): ORF_SEQ  AA_SEQ1  AA_SEQ2  ...  AA_SEQn.\n\nTool homepage: https://github.com/Woosub-Kim/codingorf"
inputs:
  - id: input_sequence
    type: string
    doc: The input nucleotide sequence (given on the command line).
    inputBinding:
      position: 1
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file that receives the standard output.
    default: codingorf.txt
outputs:
  - id: output_file
    type: File
    doc: Frame sequences with their translated ORFs.
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codingorf:v1.0.0--pyh5e36f6f_0
