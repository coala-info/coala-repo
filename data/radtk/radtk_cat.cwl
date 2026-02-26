cwlVersion: v1.2
class: CommandLineTool
baseCommand: radtk_cat
label: radtk_cat
doc: "concatenate the records in a sequence of RAD files\n\nTool homepage: https://github.com/COMBINE-lab/radtk"
inputs:
  - id: inputs
    type: string
    doc: "',' separated list of input RAD files"
    inputBinding:
      position: 101
      prefix: --inputs
outputs:
  - id: output
    type: File
    doc: output RAD file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radtk:0.2.0--ha6fb395_1
