cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-paf
label: dsh-bio_filter-paf
doc: "Filters a PAF file based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_paf_path
    type:
      - 'null'
      - File
    doc: input PAF path, default stdin
    inputBinding:
      position: 101
      prefix: --input-paf-path
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: filter by mapping quality
    inputBinding:
      position: 101
      prefix: --mapping-quality
  - id: query_range
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
  - id: target_range
    type:
      - 'null'
      - string
    doc: filter by target range, specify as targetName:start-end in 0-based 
      coordindates
    inputBinding:
      position: 101
      prefix: --target
outputs:
  - id: output_paf_file
    type:
      - 'null'
      - File
    doc: output PAF file, default stdout
    outputBinding:
      glob: $(inputs.output_paf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
