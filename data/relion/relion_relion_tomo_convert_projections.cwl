cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_convert_projections
label: relion_relion_tomo_convert_projections
doc: "Convert the tilt-series geometry of an IMOD alignment (newst.com and tilt.com) into the RELION projection\
  \ file.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: tilt_series
    type: File
    doc: Original tilt series (only size needed, unless views have to be excluded)
    inputBinding:
      position: 101
      prefix: --ts
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: newst_com
    type:
      - 'null'
      - File
    doc: 'Input command to IMOD''s newstack (RELION default: newst.com)'
    inputBinding:
      position: 101
      prefix: --nc
  - id: tilt_com
    type:
      - 'null'
      - File
    doc: 'Input command to IMOD''s tilt (RELION default: tilt.com)'
    inputBinding:
      position: 101
      prefix: --tc
  - id: thickness
    type:
      - 'null'
      - float
    doc: 'Thickness of original IMOD tomogram (overrides the value in tilt.com) (RELION default: -1.0)'
    inputBinding:
      position: 101
      prefix: --thick
  - id: offset_x
    type:
      - 'null'
      - float
    doc: '3D offset, X (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --offx
  - id: offset_y
    type:
      - 'null'
      - float
    doc: '3D offset, Y (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --offy
  - id: offset_z
    type:
      - 'null'
      - float
    doc: '3D offset, Z (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --offz
  - id: flip_yz
    type:
      - 'null'
      - boolean
    doc: Interchange the Y and Z coordinates
    inputBinding:
      position: 101
      prefix: --flipYZ
  - id: flip_z
    type:
      - 'null'
      - boolean
    doc: Change the sign of the Z coordinate
    inputBinding:
      position: 101
      prefix: --flipZ
  - id: flip_angles
    type:
      - 'null'
      - boolean
    doc: Change the sign of all tilt angles
    inputBinding:
      position: 101
      prefix: --flipAng
  - id: aligned_stack
    type:
      - 'null'
      - boolean
    doc: Map to aligned stack (.ali)
    inputBinding:
      position: 101
      prefix: --ali
  - id: use_newst_size
    type:
      - 'null'
      - boolean
    doc: Use the size indicated in newst.com
    inputBinding:
      position: 101
      prefix: --ali_size
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: culled_stack_name
    type:
      - 'null'
      - string
    doc: Output filename for culled stack (with frames excluded)
    inputBinding:
      position: 101
      prefix: --oc
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: projections
    type: File
    doc: Projection (tilt geometry) file
    outputBinding:
      glob: $(inputs.output)
  - id: culled_stack
    type:
      type: array
      items: File
    doc: Culled stack (only with --oc)
    outputBinding:
      glob: $(inputs.culled_stack_name)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_convert_projections.out
