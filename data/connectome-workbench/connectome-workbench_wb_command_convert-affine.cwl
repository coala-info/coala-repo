cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-convert-affine'
label: connectome-workbench_wb_command_convert-affine
doc: "Convert an affine file between conventions (NIFTI world, ITK, flirt). You must specify exactly one -from option, but you may specify multiple -to options, and -to-flirt may be specified more than once. wb_command assumes world matrices transform source coordinates to target coordinates.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: from_world
    type:
      - 'null'
      - File
    doc: "input is a NIFTI 'world' affine"
    inputBinding:
      position: 1
      prefix: '-from-world'
  - id: from_world_inverse
    type:
      - 'null'
      - boolean
    doc: "with from_world: for files that use 'target to source' convention"
    inputBinding:
      position: 2
      prefix: '-inverse'
  - id: from_itk
    type:
      - 'null'
      - File
    doc: input is an ITK matrix
    inputBinding:
      position: 3
      prefix: '-from-itk'
  - id: from_flirt
    type:
      - 'null'
      - type: array
        items: File
    doc: 'input is a flirt matrix; three files: input affine, source volume, target volume'
    inputBinding:
      position: 4
      prefix: '-from-flirt'
  - id: to_world
    type:
      - 'null'
      - string
    doc: "output - write output as a NIFTI 'world' affine"
    inputBinding:
      position: 5
      prefix: '-to-world'
  - id: to_world_inverse
    type:
      - 'null'
      - boolean
    doc: "with to_world: write file using 'target to source' convention"
    inputBinding:
      position: 6
      prefix: '-inverse'
  - id: to_itk
    type:
      - 'null'
      - string
    doc: output - write output as an ITK affine
    inputBinding:
      position: 7
      prefix: '-to-itk'
  - id: to_flirt_outputs
    type:
      - 'null'
      - type: array
        items: string
    doc: output names for repeatable -to-flirt, paired with to_flirt_source_volumes and to_flirt_target_volumes
  - id: to_flirt_target_volumes
    type:
      - 'null'
      - type: array
        items: File
    doc: 'for -to-flirt: the target space you want the transformed volume to match, one per output'
  - id: to_flirt_source_volumes
    type:
      - 'null'
      - type: array
        items: File
    doc: 'repeatable -to-flirt: the volume you want to apply the transform to, one per output in to_flirt_outputs'
    inputBinding:
      position: 8
      valueFrom: "${ if (!self) return null; var a = []; for (var i = 0; i < self.length; i++) { a.push('-to-flirt', inputs.to_flirt_outputs[i], self[i].path, inputs.to_flirt_target_volumes[i].path); } return a; }"
outputs:
  - id: world_affine
    type:
      - 'null'
      - File
    doc: the NIFTI world affine
    outputBinding:
      glob: $(inputs.to_world)
  - id: itk_affine
    type:
      - 'null'
      - File
    doc: the ITK affine
    outputBinding:
      glob: $(inputs.to_itk)
  - id: flirt_affines
    type:
      type: array
      items: File
    doc: the flirt matrices
    outputBinding:
      glob: '$(inputs.to_flirt_outputs ? inputs.to_flirt_outputs : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
