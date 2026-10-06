cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, copy]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${
          if (!inputs.existing_output) { return []; }
          return [
            {entry: {class: 'File', location: inputs.existing_output.location}, entryname: inputs.output_name + '.cfl', writable: true},
            {entry: {class: 'File', location: inputs.existing_output.secondaryFiles[0].location}, entryname: inputs.output_name + '.hdr', writable: true}
          ];
        }
label: bart_copy
doc: "Copy an array (to a given position in the output file - which then must exist).\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimensions_positions
    type:
      - 'null'
      - type: array
        items: string
    doc: Dimensions and their positions
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: Input array
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
  - id: existing_output
    type:
      - 'null'
      - File
    doc: Existing array to copy into at the given positions (needed with dimensions_positions); it is staged
      as <output_name>.cfl/.hdr and the result is written into that copy
    secondaryFiles:
      - ^.hdr
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
