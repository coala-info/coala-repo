cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_rename_contigs
label: ppanini_rename_contigs
doc: "Prefix every FASTA header with the sample name taken from the input file name.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: input
    type: File
    doc: "FASTA file"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_path
    type: string
    doc: "Output FASTA file"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: File
    doc: FASTA file with renamed contigs
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_rename_contigs.out
