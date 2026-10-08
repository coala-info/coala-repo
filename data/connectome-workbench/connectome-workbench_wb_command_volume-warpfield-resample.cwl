cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-warpfield-resample
label: connectome-workbench_wb_command_volume-warpfield-resample
doc: "Resample a volume file with a warpfield. The recommended methods are CUBIC (cubic spline) for most data, and ENCLOSING_VOXEL for label data.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "volume to resample"
    inputBinding:
      position: 1
  - id: warpfield
    type: File
    doc: "the warpfield to apply"
    inputBinding:
      position: 2
  - id: volume_space
    type: File
    doc: "a volume file in the volume space you want for the output"
    inputBinding:
      position: 3
  - id: method
    type: string
    doc: "the resampling method: CUBIC, ENCLOSING_VOXEL or TRILINEAR"
    inputBinding:
      position: 4
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 5
  - id: fnirt_source_volume
    type:
      - 'null'
      - File
    doc: "MUST be used if using a fnirt warpfield: the source volume used when generating the warpfield"
    inputBinding:
      position: 6
      prefix: -fnirt
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
