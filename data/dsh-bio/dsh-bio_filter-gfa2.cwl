cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-gfa2
label: dsh-bio_filter-gfa2
doc: "Filter GFA2 files\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gfa2_path
    type:
      - 'null'
      - File
    doc: input GFA 2.0 path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gfa2-path
  - id: script
    type:
      - 'null'
      - string
    doc: filter by script, eval against r
    inputBinding:
      position: 101
      prefix: --script
  - id: output_gfa2_file_path
    type: string
    doc: Output or path parameter `output_gfa2_file_path`
    inputBinding:
      position: 102
      prefix: --output-gfa2-file
outputs:
  - id: output_gfa2_file
    type:
      - 'null'
      - File
    doc: output GFA 2.0 file, default stdout
    outputBinding:
      glob: $(inputs.output_gfa2_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
