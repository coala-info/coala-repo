cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx fq2fa
label: pyfastx_fq2fa
doc: "Converts FASTQ to FASTA format.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx
    type: File
    doc: fastq file, gzip support
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file, default: output to stdout'
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
