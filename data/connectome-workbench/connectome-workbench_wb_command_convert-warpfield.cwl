cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-convert-warpfield'
label: connectome-workbench_wb_command_convert-warpfield
doc: "Convert a warpfield between conventions (NIFTI world, ITK, fnirt). This command does not invert the warpfield. You must specify exactly one -from option, but you may specify multiple -to options, and -to-fnirt may be specified more than once.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: from_world
    type:
      - 'null'
      - File
    doc: "input is a NIFTI 'world' warpfield"
    inputBinding:
      position: 1
      prefix: '-from-world'
  - id: from_itk
    type:
      - 'null'
      - File
    doc: input is an ITK warpfield
    inputBinding:
      position: 2
      prefix: '-from-itk'
  - id: from_fnirt
    type:
      - 'null'
      - type: array
        items: File
    doc: 'input is a fnirt warpfield; two files: input warpfield, source volume used when generating it'
    inputBinding:
      position: 3
      prefix: '-from-fnirt'
  - id: from_fnirt_absolute
    type:
      - 'null'
      - boolean
    doc: 'with from_fnirt: warpfield was written in absolute convention, rather than relative'
    inputBinding:
      position: 4
      prefix: '-absolute'
  - id: to_world
    type:
      - 'null'
      - string
    doc: "output - write output as a NIFTI 'world' warpfield"
    inputBinding:
      position: 5
      prefix: '-to-world'
  - id: to_itk
    type:
      - 'null'
      - string
    doc: output - write output as an ITK warpfield
    inputBinding:
      position: 6
      prefix: '-to-itk'
  - id: to_fnirt_outputs
    type:
      - 'null'
      - type: array
        items: string
    doc: output names for repeatable -to-fnirt, paired with to_fnirt_source_volumes
  - id: to_fnirt_source_volumes
    type:
      - 'null'
      - type: array
        items: File
    doc: 'repeatable -to-fnirt: the volume you want to apply the warpfield to, one per output in to_fnirt_outputs'
    inputBinding:
      position: 7
      valueFrom: "${ if (!self) return null; var a = []; for (var i = 0; i < self.length; i++) { a.push('-to-fnirt', inputs.to_fnirt_outputs[i], self[i].path); } return a; }"
outputs:
  - id: world_warpfield
    type:
      - 'null'
      - File
    doc: the NIFTI world warpfield
    outputBinding:
      glob: $(inputs.to_world)
  - id: itk_warpfield
    type:
      - 'null'
      - File
    doc: the ITK warpfield
    outputBinding:
      glob: $(inputs.to_itk)
  - id: fnirt_warpfields
    type:
      type: array
      items: File
    doc: the fnirt warpfields
    outputBinding:
      glob: '$(inputs.to_fnirt_outputs ? inputs.to_fnirt_outputs : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
