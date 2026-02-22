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
outputs:
  - id: output
    type: File
    doc: Path to the output file where reformatted data will be written.
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type:
      - 'null'
      - File
    doc: Path to the log file.
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexi-formatter:1.0.1--pyhdfd78af_0
