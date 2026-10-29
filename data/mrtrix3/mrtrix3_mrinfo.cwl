cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrinfo]
label: mrtrix3_mrinfo
doc: |-
  Display image header information, or extract specific information from the header

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: mrinfo_fslgrad_rec
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
      - name: mrinfo_export_grad_fsl_rec
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
      - name: mrinfo_export_pe_eddy_rec
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
  - id: image
    type:
      type: array
      items: File
    doc: the input image(s).
    inputBinding:
      position: 1
  - id: all
    type: ['null', boolean]
    doc: print all properties, rather than the first and last 2 of each.
    inputBinding:
      prefix: -all
  - id: name
    type: ['null', boolean]
    doc: print the file system path of the image
    inputBinding:
      prefix: -name
  - id: format
    type: ['null', boolean]
    doc: image file format
    inputBinding:
      prefix: -format
  - id: ndim
    type: ['null', boolean]
    doc: number of image dimensions
    inputBinding:
      prefix: -ndim
  - id: size
    type: ['null', boolean]
    doc: image size along each axis
    inputBinding:
      prefix: -size
  - id: spacing
    type: ['null', boolean]
    doc: voxel spacing along each image dimension
    inputBinding:
      prefix: -spacing
  - id: datatype
    type: ['null', boolean]
    doc: data type used for image data storage
    inputBinding:
      prefix: -datatype
  - id: strides
    type: ['null', boolean]
    doc: data strides i.e. order and direction of axes data layout
    inputBinding:
      prefix: -strides
  - id: offset
    type: ['null', boolean]
    doc: image intensity offset
    inputBinding:
      prefix: -offset
  - id: multiplier
    type: ['null', boolean]
    doc: image intensity multiplier
    inputBinding:
      prefix: -multiplier
  - id: transform
    type: ['null', boolean]
    doc: the transformation from image coordinates [mm] to scanner / real world coordinates [mm]
    inputBinding:
      prefix: -transform
  - id: property
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -property
    doc: any text properties embedded in the image header under the specified key (use 'all' to list all
      keys found)
  - id: json_keyval
    type: ['null', string]
    doc: export header key/value entries to a JSON file
    inputBinding:
      prefix: -json_keyval
  - id: json_all
    type: ['null', string]
    doc: export all header contents to a JSON file
    inputBinding:
      prefix: -json_all
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
    type: ['null', mrinfo_fslgrad_rec]
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
    type: ['null', mrinfo_export_grad_fsl_rec]
    doc: export the diffusion-weighted gradient table to files in FSL (bvecs / bvals) format
    inputBinding:
      prefix: -export_grad_fsl
  - id: dwgrad
    type: ['null', boolean]
    doc: the diffusion-weighting gradient table, as interpreted by MRtrix3
    inputBinding:
      prefix: -dwgrad
  - id: shell_bvalues
    type: ['null', boolean]
    doc: list the average b-value of each shell
    inputBinding:
      prefix: -shell_bvalues
  - id: shell_sizes
    type: ['null', boolean]
    doc: list the number of volumes in each shell
    inputBinding:
      prefix: -shell_sizes
  - id: shell_indices
    type: ['null', boolean]
    doc: list the image volumes attributed to each b-value shell
    inputBinding:
      prefix: -shell_indices
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
    type: ['null', mrinfo_export_pe_eddy_rec]
    doc: export phase-encoding information to an EDDY-style config / index file pair
    inputBinding:
      prefix: -export_pe_eddy
  - id: petable
    type: ['null', boolean]
    doc: print the phase encoding table
    inputBinding:
      prefix: -petable
  - id: nodelete
    type: ['null', boolean]
    doc: don't delete temporary images or images passed to mrinfo via Unix pipes
    inputBinding:
      prefix: -nodelete
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
  - id: json_keyval_out
    type: ['null', File]
    doc: 'Output file for -json_keyval: export header key/value entries to a JSON file'
    outputBinding:
      glob: $(inputs.json_keyval)
  - id: json_all_out
    type: ['null', File]
    doc: 'Output file for -json_all: export all header contents to a JSON file'
    outputBinding:
      glob: $(inputs.json_all)
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
  - id: stdout_out
    type: stdout
    doc: Text printed by the command.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrinfo_stdout.txt
