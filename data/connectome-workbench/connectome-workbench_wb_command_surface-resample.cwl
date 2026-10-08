cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-resample
label: connectome-workbench_wb_command_surface-resample
doc: "Resamples a surface file, given two spherical surfaces that are in register. If ADAP_BARY_AREA is used, exactly one of -area-surfs or -area-metrics must be specified. This method is not generally recommended for surface resampling, but is provided for completeness.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface_in
    type: File
    doc: "the surface file to resample"
    inputBinding:
      position: 1
  - id: current_sphere
    type: File
    doc: "a sphere surface with the mesh that the input surface is currently on"
    inputBinding:
      position: 2
  - id: new_sphere
    type: File
    doc: "a sphere surface that is in register with <current-sphere> and has the desired output mesh"
    inputBinding:
      position: 3
  - id: method
    type: string
    doc: "the method name: ADAP_BARY_AREA or BARYCENTRIC"
    inputBinding:
      position: 4
  - id: surface_out
    type: string
    doc: "output - the output surface file"
    inputBinding:
      position: 5
  - id: area_surfs_current_area
    type:
      - 'null'
      - File
    doc: "a relevant surface with <current-sphere> mesh (-area-surfs argument 1 of 2)"
    inputBinding:
      position: 6
      prefix: -area-surfs
  - id: area_surfs_new_area
    type:
      - 'null'
      - File
    doc: "a relevant surface with <new-sphere> mesh (-area-surfs argument 2 of 2)"
    inputBinding:
      position: 7
  - id: area_metrics_current_area
    type:
      - 'null'
      - File
    doc: "a metric file with vertex areas for <current-sphere> mesh (-area-metrics argument 1 of 2)"
    inputBinding:
      position: 8
      prefix: -area-metrics
  - id: area_metrics_new_area
    type:
      - 'null'
      - File
    doc: "a metric file with vertex areas for <new-sphere> mesh (-area-metrics argument 2 of 2)"
    inputBinding:
      position: 9
outputs:
  - id: output_surface
    type: File
    doc: "the output surface file"
    outputBinding:
      glob: $(inputs.surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
