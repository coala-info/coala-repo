cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ggcat
  - dump-colors
label: ggcat_dump-colors
doc: "Dumps the colors from a colormap file.\n\nTool homepage: https://github.com/algbio/ggcat"
inputs:
  - id: input_colormap
    type: File
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output file path; the tool replaces its extension with .jsonl
    inputBinding:
      position: 2
outputs:
  - id: out_output_file
    type: File
    doc: Colors in JSON lines format
    outputBinding:
      glob: "$(inputs.output_file.replace(/\\.[^./]*$/, '') + '.jsonl')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
