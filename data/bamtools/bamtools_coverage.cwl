cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - coverage
label: bamtools_coverage
doc: "prints coverage data for a single BAM file.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: the input BAM file [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: the output file [stdout]
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
