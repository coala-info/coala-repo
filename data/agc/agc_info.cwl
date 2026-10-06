cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - info
label: agc_info
doc: "AGC (Assembled Genomes Compressor) - Get information about an AGC file\n\nTool
  homepage: https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC file
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Name of the file that captures the report. agc info 3.2 ignores -o and
      always writes the report to stderr, so stderr is captured into this file.
outputs:
  - id: output_file
    type: File
    doc: Archive information report (captured stderr).
    outputBinding:
      glob: $(inputs.output_file_path)
stderr: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
