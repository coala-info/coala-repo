cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-apply-affine
label: connectome-workbench_wb_command_surface-apply-affine
doc: 'For flirt matrices, you must use the -flirt option, because flirt matrices are
  not a complete description of the coordinate transform they represent. If the -flirt
  option is not present, the affine must be a nifti ''world'' affine, which can be
  obtained with the -convert-affine command, or aff_conv from the 4dfp suite.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: flirt_rec
        type: record
        fields:
          - name: source_volume
            type: File
            doc: the source volume used when generating the affine
            inputBinding:
              position: 1
          - name: target_volume
            type: File
            doc: the target volume used when generating the affine
            inputBinding:
              position: 2
inputs:
  - id: in_surf
    type: File
    doc: the surface to transform
    inputBinding:
      position: 1
  - id: affine
    type: File
    doc: the affine file
    inputBinding:
      position: 2
  - id: out_surf
    type: string
    doc: output - the output transformed surface
    inputBinding:
      position: 3
  - id: flirt
    type:
      - 'null'
      - flirt_rec
    doc: MUST be used if affine is a flirt affine
    inputBinding:
      position: 4
      prefix: -flirt
outputs:
  - id: out_surf_file
    type: File
    doc: the output transformed surface
    outputBinding:
      glob: $(inputs.out_surf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
