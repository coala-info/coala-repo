cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-estimate-fwhm
label: connectome-workbench_wb_command_cifti-estimate-fwhm
doc: "Estimate the smoothness of the components of the cifti file, printing the estimates to standard output. If -merged-volume is used, all voxels are used as a single component, rather than separated by structure. <structure> must be one of the following:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: surface_item
        type: record
        fields:
          - name: structure
            type: string
            doc: what structure to use this surface for
            inputBinding:
              position: 1
              prefix: -surface
          - name: surface
            type: File
            doc: the surface file
            inputBinding:
              position: 2
inputs:
  - id: cifti
    type: File
    doc: the input cifti file
    inputBinding:
      position: 1
  - id: merged_volume
    type:
      - 'null'
      - boolean
    doc: treat volume components as if they were a single component
    inputBinding:
      position: 2
      prefix: -merged-volume
  - id: column
    type:
      - 'null'
      - string
    doc: 'only output estimates for one column: the column number'
    inputBinding:
      position: 3
      prefix: -column
  - id: whole_file
    type:
      - 'null'
      - boolean
    doc: estimate for the whole file at once, not each column separately
    inputBinding:
      position: 4
      prefix: -whole-file
  - id: demean
    type:
      - 'null'
      - boolean
    doc: subtract the mean image before estimating smoothness (use with -whole-file)
    inputBinding:
      position: 5
      prefix: -demean
  - id: surface
    type:
      - 'null'
      - type: array
        items: surface_item
    doc: specify an input surface (repeatable; one record per use of -surface)
    inputBinding:
      position: 6
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: cifti-estimate-fwhm.txt
outputs:
  - id: fwhm_estimates
    type: File
    doc: estimated FWHM smoothness for each structure and column
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
