cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrconvert]
label: mrtrix3_mrconvert
doc: |-
  Perform conversion between different file types and optionally extract a subset of the input image

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: mrconvert_coord_rec
        type: record
        fields:
          - name: axis
            type: int
            doc: axis
            inputBinding:
              position: 1
          - name: selection
            type: string
            doc: selection
            inputBinding:
              position: 2
      - name: mrconvert_set_property_rec
        type: record
        fields:
          - name: key
            type: string
            doc: key
            inputBinding:
              position: 1
          - name: value
            type: string
            doc: value
            inputBinding:
              position: 2
      - name: mrconvert_append_property_rec
        type: record
        fields:
          - name: key
            type: string
            doc: key
            inputBinding:
              position: 1
          - name: value
            type: string
            doc: value
            inputBinding:
              position: 2
      - name: mrconvert_fslgrad_rec
        type: record
        fields:
          - name: bvecs
            type: File
            doc: bvecs
            inputBinding:
              position: 1
          - name: bvals
            type: File
            doc: bvals
            inputBinding:
              position: 2
      - name: mrconvert_export_grad_fsl_rec
        type: record
        fields:
          - name: bvecs_path
            type: string
            doc: bvecs_path
            inputBinding:
              position: 1
          - name: bvals_path
            type: string
            doc: bvals_path
            inputBinding:
              position: 2
      - name: mrconvert_import_pe_eddy_rec
        type: record
        fields:
          - name: config
            type: File
            doc: config
            inputBinding:
              position: 1
          - name: indices
            type: File
            doc: indices
            inputBinding:
              position: 2
      - name: mrconvert_export_pe_eddy_rec
        type: record
        fields:
          - name: config
            type: string
            doc: config
            inputBinding:
              position: 1
          - name: indices
            type: string
            doc: indices
            inputBinding:
              position: 2
inputs:
  - id: input
    type: File
    doc: the input image.
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: the output image.
    inputBinding:
      position: 2
  - id: coord
    type:
      - 'null'
      - type: array
        items: mrconvert_coord_rec
        inputBinding:
          prefix: -coord
    doc: retain data from the input image only at the coordinates specified in the selection along the
      specified axis. The selection argument expects a number sequence, which can also include the 'end'
      keyword.
  - id: vox
    type: ['null', string]
    doc: change the voxel dimensions reported in the output image header
    inputBinding:
      prefix: -vox
  - id: axes
    type: ['null', string]
    doc: specify the axes from the input image that will be used to form the output image
    inputBinding:
      prefix: -axes
  - id: scaling
    type: ['null', string]
    doc: specify the data scaling parameters used to rescale the intensity values
    inputBinding:
      prefix: -scaling
  - id: json_import
    type: ['null', File]
    doc: import data from a JSON file into header key-value pairs
    inputBinding:
      prefix: -json_import
  - id: json_export
    type: ['null', string]
    doc: export data from an image header key-value pairs into a JSON file
    inputBinding:
      prefix: -json_export
  - id: clear_property
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -clear_property
    doc: remove the specified key from the image header altogether.
  - id: set_property
    type:
      - 'null'
      - type: array
        items: mrconvert_set_property_rec
        inputBinding:
          prefix: -set_property
    doc: set the value of the specified key in the image header.
  - id: append_property
    type:
      - 'null'
      - type: array
        items: mrconvert_append_property_rec
        inputBinding:
          prefix: -append_property
    doc: append the given value to the specified key in the image header (this adds the value specified
      as a new line in the header value).
  - id: copy_properties
    type: ['null', File]
    doc: clear all generic properties and replace with the properties from the image / file specified.
    inputBinding:
      prefix: -copy_properties
  - id: strides
    type: ['null', string]
    doc: specify the strides of the output data in memory; either as a comma-separated list of (signed)
      integers, or as a template image from which the strides shall be extracted and used. The actual
      strides produced will depend on whether the output image format can support it.
    inputBinding:
      prefix: -strides
  - id: datatype
    type: ['null', string]
    doc: 'specify output image data type. Valid choices are: float32, float32le, float32be, float64, float64le,
      float64be, int64, uint64, int64le, uint64le, int64be, uint64be, int32, uint32, int32le, uint32le,
      int32be, uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32, cfloat32le, cfloat32be,
      cfloat64, cfloat64le, cfloat64be, int8, uint8, bit. (choices: float32 float32le float32be float64
      float64le float64be int64 uint64 int64le uint64le int64be uint64be int32 uint32 int32le uint32le
      int32be uint32be int16 uint16 int16le uint16le int16be uint16be cfloat32 cfloat32le cfloat32be cfloat64
      cfloat64le cfloat64be int8 uint8 bit)'
    inputBinding:
      prefix: -datatype
  - id: grad
    type: ['null', File]
    doc: Provide the diffusion-weighted gradient scheme used in the acquisition in a text file. This should
      be supplied as a 4xN text file with each line is in the format [ X Y Z b ], where [ X Y Z ] describe
      the direction of the applied gradient, and b gives the b-value in units of s/mm^2. If a diffusion
      gradient scheme is present in the input image header, the data provided with this option will be
      instead used.
    inputBinding:
      prefix: -grad
  - id: fslgrad
    type: ['null', mrconvert_fslgrad_rec]
    doc: Provide the diffusion-weighted gradient scheme used in the acquisition in FSL bvecs/bvals format
      files. If a diffusion gradient scheme is present in the input image header, the data provided with
      this option will be instead used.
    inputBinding:
      prefix: -fslgrad
  - id: bvalue_scaling
    type: ['null', string]
    doc: 'enable or disable scaling of diffusion b-values by the square of the corresponding DW gradient
      norm (see Desciption). Valid choices are yes/no, true/false, 0/1 (default: automatic).'
    inputBinding:
      prefix: -bvalue_scaling
  - id: export_grad_mrtrix
    type: ['null', string]
    doc: export the diffusion-weighted gradient table to file in MRtrix format
    inputBinding:
      prefix: -export_grad_mrtrix
  - id: export_grad_fsl
    type: ['null', mrconvert_export_grad_fsl_rec]
    doc: export the diffusion-weighted gradient table to files in FSL (bvecs / bvals) format
    inputBinding:
      prefix: -export_grad_fsl
  - id: import_pe_table
    type: ['null', File]
    doc: import a phase-encoding table from file
    inputBinding:
      prefix: -import_pe_table
  - id: import_pe_topup
    type: ['null', File]
    doc: import a phase-encoding table intended for FSL TOPUP from file
    inputBinding:
      prefix: -import_pe_topup
  - id: import_pe_eddy
    type: ['null', mrconvert_import_pe_eddy_rec]
    doc: import phase-encoding information from an EDDY-style config / index file pair
    inputBinding:
      prefix: -import_pe_eddy
  - id: export_pe_table
    type: ['null', string]
    doc: export phase-encoding table to file
    inputBinding:
      prefix: -export_pe_table
  - id: export_pe_topup
    type: ['null', string]
    doc: export phase-encoding table to a file intended for FSL topup
    inputBinding:
      prefix: -export_pe_topup
  - id: export_pe_eddy
    type: ['null', mrconvert_export_pe_eddy_rec]
    doc: export phase-encoding information to an EDDY-style config / index file pair
    inputBinding:
      prefix: -export_pe_eddy
  - id: info
    type: ['null', boolean]
    doc: display information messages.
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: do not display information messages or progress status; alternatively, this can be achieved by
      setting the MRTRIX_QUIET environment variable to a non-empty string.
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: display debugging messages.
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: 'force overwrite of output files (caution: using the same file as input and output might cause
      unexpected behaviour).'
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).
    inputBinding:
      prefix: -nthreads
outputs:
  - id: output_out
    type: File
    doc: 'Output: the output image.'
    outputBinding:
      glob: $(inputs.output)
  - id: json_export_out
    type: ['null', File]
    doc: 'Output file for -json_export: export data from an image header key-value pairs into a JSON file'
    outputBinding:
      glob: $(inputs.json_export)
  - id: export_grad_mrtrix_out
    type: ['null', File]
    doc: 'Output file for -export_grad_mrtrix: export the diffusion-weighted gradient table to file in
      MRtrix format'
    outputBinding:
      glob: $(inputs.export_grad_mrtrix)
  - id: export_grad_fsl_bvecs_path_out
    type: ['null', File]
    doc: 'Output bvecs_path of -export_grad_fsl: export the diffusion-weighted gradient table to files
      in FSL (bvecs / bvals) format'
    outputBinding:
      glob: '$(inputs.export_grad_fsl ? inputs.export_grad_fsl.bvecs_path : null)'
  - id: export_grad_fsl_bvals_path_out
    type: ['null', File]
    doc: 'Output bvals_path of -export_grad_fsl: export the diffusion-weighted gradient table to files
      in FSL (bvecs / bvals) format'
    outputBinding:
      glob: '$(inputs.export_grad_fsl ? inputs.export_grad_fsl.bvals_path : null)'
  - id: export_pe_table_out
    type: ['null', File]
    doc: 'Output file for -export_pe_table: export phase-encoding table to file'
    outputBinding:
      glob: $(inputs.export_pe_table)
  - id: export_pe_topup_out
    type: ['null', File]
    doc: 'Output file for -export_pe_topup: export phase-encoding table to a file intended for FSL topup'
    outputBinding:
      glob: $(inputs.export_pe_topup)
  - id: export_pe_eddy_config_out
    type: ['null', File]
    doc: 'Output config of -export_pe_eddy: export phase-encoding information to an EDDY-style config
      / index file pair'
    outputBinding:
      glob: '$(inputs.export_pe_eddy ? inputs.export_pe_eddy.config : null)'
  - id: export_pe_eddy_indices_out
    type: ['null', File]
    doc: 'Output indices of -export_pe_eddy: export phase-encoding information to an EDDY-style config
      / index file pair'
    outputBinding:
      glob: '$(inputs.export_pe_eddy ? inputs.export_pe_eddy.indices : null)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
