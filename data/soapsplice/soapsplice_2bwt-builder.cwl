cwlVersion: v1.2
class: CommandLineTool
baseCommand: 2bwt-builder
label: soapsplice_2bwt-builder
doc: "2BWT-Builder: builds the reference index used by SOAPsplice from a sequence
  file.\n\nTool homepage: http://soap.genomics.org.cn/soapsplice.html"
inputs:
  - id: sequence_file
    type: File
    doc: Sequence file (FASTA)
    inputBinding:
      position: 1
  - id: output_index_prefix
    type: string
    doc: Output index prefix (2bwt-builder writes <prefix>.index.* files)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written with the output prefix
    outputBinding:
      glob: $(inputs.output_index_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapsplice:1.10--2
stdout: soapsplice_2bwt-builder.out
