cwlVersion: v1.2
class: CommandLineTool
baseCommand: yacrd extract
label: yacrd_extract
doc: "Record mark as chimeric or NotCovered is extract\n\nTool homepage: https://github.com/natir/yacrd"
inputs:
  - id: input
    type: File
    doc: "path to sequence input (fasta|fastq), compression is autodetected\n    \
      \                         (none|gzip|bzip2|lzma)"
    inputBinding:
      position: 101
      prefix: --input
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: path to output file, format and compression of input is preserved
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yacrd:1.0.0--hc308579_0
