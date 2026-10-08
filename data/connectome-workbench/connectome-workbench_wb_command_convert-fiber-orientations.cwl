cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-convert-fiber-orientations'
label: connectome-workbench_wb_command_convert-fiber-orientations
doc: "Convert bingham parameter volumes to a fiber orientation file. Takes precomputed bingham parameters from volume files and converts them to the format workbench uses for display. <label-volume> must be a label volume whose labels use cifti structure names.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_volume
    type: File
    doc: volume of cifti structure labels
    inputBinding:
      position: 1
  - id: fiber_out
    type: string
    doc: output - the output fiber orientation file
    inputBinding:
      position: 2
  - id: fiber
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: File
        inputBinding:
          prefix: '-fiber'
    doc: 'repeatable -fiber: the parameter volumes for a fiber; seven files each: mean-f, stdev-f, theta, phi, psi, ka, kb'
    inputBinding:
      position: 3
outputs:
  - id: fiber_orientations
    type: File
    doc: the output fiber orientation file
    outputBinding:
      glob: $(inputs.fiber_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
