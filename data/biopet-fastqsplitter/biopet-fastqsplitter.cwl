cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqSplitter
label: biopet-fastqsplitter
doc: "A tool for splitting FastQ files into multiple output files.\n\nTool homepage:
  https://github.com/biopet/fastq-splitter"
inputs:
  - id: input_file
    type: File
    doc: Path to input file
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Path to output file. Multiple output files can be specified.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-fastqsplitter:0.1--2
