cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panaln
  - align
label: panaln_align
doc: "Align fastq sequences using panaln\n\nTool homepage: https://github.com/Lilu-guo/Panaln"
inputs:
  - id: index_basename
    type: string
    doc: Index basename
    inputBinding:
      position: 101
      prefix: -x
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 101
      prefix: -f
  - id: output_sam_path
    type: string
    doc: Output or path parameter `output_sam_path`
    inputBinding:
      position: 102
      prefix: --output-sam
outputs:
  - id: output_sam
    type: File
    doc: Output SAM file
    outputBinding:
      glob: $(inputs.output_sam_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
