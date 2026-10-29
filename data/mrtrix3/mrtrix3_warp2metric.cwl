cwlVersion: v1.2
class: CommandLineTool
baseCommand: warp2metric
label: mrtrix3_warp2metric
doc: "Compute fixel-wise or voxel-wise metrics from a 4D deformation field\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: warp_in
    type: File
    doc: "the input deformation field"
    inputBinding:
      position: 1
  - id: fc
    type: ['null', fc_record]
    doc: "use an input template fixel image to define fibre orientations and output a fixel image describing the change in fibre cross-section (FC) in the perpendicular plane to the fixel orientation. e.g. warp2metric warp.mif -fc fixel_template_directory output_fixel_directory fc.mif"
    inputBinding:
      position: 10
      prefix: -fc
  - id: jmat
    type: ['null', string]
    doc: "output a Jacobian matrix image stored in column-major order along the 4th dimension.Note the output jacobian describes the warp gradient w.r.t the scanner space coordinate system"
    inputBinding:
      position: 10
      prefix: -jmat
  - id: jdet
    type: ['null', string]
    doc: "output the Jacobian determinant instead of the full matrix"
    inputBinding:
      position: 10
      prefix: -jdet
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: fc_output_fixel_directory
    type: ['null', Directory]
    doc: Output fixel directory written by -fc.
    outputBinding:
      glob: "$(inputs.fc ? inputs.fc.output_fixel_directory : null)"
  - id: jmat_file
    type: ['null', File]
    doc: Output file given by -jmat.
    outputBinding:
      glob: $(inputs.jmat)
  - id: jdet_file
    type: ['null', File]
    doc: Output file given by -jdet.
    outputBinding:
      glob: $(inputs.jdet)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: fc_record
        type: record
        fields:
          - name: template_fixel_directory
            type: Directory
            inputBinding:
              position: 1
          - name: output_fixel_directory
            type: string
            inputBinding:
              position: 2
          - name: output_fixel_data
            type: string
            inputBinding:
              position: 3
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
