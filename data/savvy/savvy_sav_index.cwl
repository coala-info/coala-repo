cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - index
label: savvy_sav_index
doc: "Indexes SAV file\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: input_sav
    type: File
    doc: Input SAV file
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Output path (default: appends index to SAV file)'
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: indexed_sav
    type: File
    doc: SAV file with the index appended (when no output path is given)
    outputBinding:
      glob: $(inputs.input_sav.basename)
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index written to the output path
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_sav)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
