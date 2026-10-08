cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-tfce
label: connectome-workbench_wb_command_volume-tfce
doc: "Threshold-free cluster enhancement is a method to increase the relative value of regions that would form clusters in a standard thresholding test.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the volume to run TFCE on"
    inputBinding:
      position: 1
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 2
  - id: presmooth
    type:
      - 'null'
      - float
    doc: "smooth the volume before running TFCE: the sigma for the gaussian smoothing kernel, in mm"
    inputBinding:
      position: 3
      prefix: -presmooth
  - id: roi
    type:
      - 'null'
      - File
    doc: "select a region of interest to run TFCE on: the area to run TFCE on, as a volume"
    inputBinding:
      position: 4
      prefix: -roi
  - id: parameters_e
    type:
      - 'null'
      - float
    doc: "exponent for cluster volume (default 0.5) (-parameters argument 1 of 2)"
    inputBinding:
      position: 5
      prefix: -parameters
  - id: parameters_h
    type:
      - 'null'
      - float
    doc: "exponent for threshold value (default 2.0) (-parameters argument 2 of 2)"
    inputBinding:
      position: 6
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume: the subvolume number or name"
    inputBinding:
      position: 7
      prefix: -subvolume
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
