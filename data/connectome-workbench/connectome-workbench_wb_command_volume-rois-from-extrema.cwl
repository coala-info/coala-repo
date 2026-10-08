cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-rois-from-extrema
label: connectome-workbench_wb_command_volume-rois-from-extrema
doc: "For each nonzero value in each map, make a map with an ROI around that location. If the -gaussian option is specified, then normalized gaussian kernels are output instead of ROIs. The <method> argument to -overlap-logic must be one of ALLOW, CLOSEST, or EXCLUDE. ALLOW is the default, and means that ROIs are treated independently and may overlap. CLOSEST means that ROIs may not overlap, and that no ROI contains vertices that are closer to a different seed vertex. EXCLUDE means that ROIs may not overlap, and that any vertex within range of more than one ROI does not belong to any ROI.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the input volume"
    inputBinding:
      position: 1
  - id: limit
    type: float
    doc: "distance limit from voxel center, in mm"
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 3
  - id: gaussian
    type:
      - 'null'
      - float
    doc: "generate a gaussian kernel instead of a flat ROI: the sigma for the gaussian kernel, in mm"
    inputBinding:
      position: 4
      prefix: -gaussian
  - id: roi
    type:
      - 'null'
      - File
    doc: "select a region of interest to use: the region to use"
    inputBinding:
      position: 5
      prefix: -roi
  - id: overlap_logic
    type:
      - 'null'
      - string
    doc: "how to handle overlapping ROIs, default ALLOW: the method of resolving overlaps: ALLOW, CLOSEST or EXCLUDE"
    inputBinding:
      position: 6
      prefix: -overlap-logic
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
