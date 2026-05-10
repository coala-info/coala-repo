cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexi-formatter
label: flexi-formatter
doc: "A tool for reformatting genomic data, often used for processing barcodes and
  UMIs.\n\nTool homepage: https://github.com/VIB-CCB-BioIT/flexiplex_tag_formatter"
inputs:
  - id: config
    type: File
    doc: Path to the configuration file (JSON format) defining the formatting 
      rules.
    inputBinding:
      position: 101
      prefix: --config
  - id: input
    type: File
    doc: Path to the input file (typically FASTQ).
    inputBinding:
      position: 101
      prefix: --input
  - id: log_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `log_path`
    inputBinding:
      position: 102
      prefix: --log
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to the output file where reformatted data will be written.
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Path to the log file.
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexi-formatter:1.0.1--pyhdfd78af_0
