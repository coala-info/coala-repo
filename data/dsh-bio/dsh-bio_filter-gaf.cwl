cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-gaf
label: dsh-bio_filter-gaf
doc: "Filter GAF files based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_gaf_path
    type:
      - 'null'
      - File
    doc: input GAF path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gaf-path
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: filter by mapping quality
    inputBinding:
      position: 101
      prefix: --mapping-quality
  - id: query
    type:
      - 'null'
      - string
    doc: filter by query range, specify as queryName:start-end in 0-based 
      coordindates
    inputBinding:
      position: 101
      prefix: --query
  - id: script
    type:
      - 'null'
      - string
    doc: filter by script, eval against r
    inputBinding:
      position: 101
      prefix: --script
  - id: output_gaf_file_path
    type: string
    doc: Output or path parameter `output_gaf_file_path`
    inputBinding:
      position: 102
      prefix: --output-gaf-file
outputs:
  - id: output_gaf_file
    type:
      - 'null'
      - File
    doc: output GAF file, default stdout
    outputBinding:
      glob: $(inputs.output_gaf_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
