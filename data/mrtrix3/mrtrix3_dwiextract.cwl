cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwiextract
doc: "Extract diffusion-weighted volumes, b=0 volumes, or certain shells from a DWI dataset\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwiextract]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "the input DW image."
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "the output image (diffusion-weighted volumes by default)."
    inputBinding:
      position: 11
  - id: bzero
    type: ['null', boolean]
    doc: "Output b=0 volumes (instead of the diffusion weighted volumes, if -singleshell is not specified)."
    inputBinding:
      prefix: -bzero
  - id: no_bzero
    type: ['null', boolean]
    doc: "Output only non b=0 volumes (default, if -singleshell is not specified)."
    inputBinding:
      prefix: -no_bzero
  - id: singleshell
    type: ['null', boolean]
    doc: "Force a single-shell (single non b=0 shell) output. This will include b=0 volumes, if present. Use with -bzero to enforce presence of b=0 volumes (error if not present) or with -no_bzero to exclude them."
    inputBinding:
      prefix: -singleshell
  - id: grad
    type: ['null', File]
    doc: "Provide the diffusion-weighted gradient scheme used in the acquisition in a text file. This should be supplied as a 4xN text file with each line is in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the applied gradient, and b gives the b-value in units of s/mm^2. If a diffusion gradient scheme is present in the input image header, the data provided with this option will be instead used."
    inputBinding:
      prefix: -grad
  - id: fslgrad
    type:
      - 'null'
      - type: array
        items: File
    doc: "Provide the diffusion-weighted gradient scheme used in the acquisition in FSL bvecs/bvals format files. If a diffusion gradient scheme is present in the input image header, the data provided with this option will be instead used."
    inputBinding:
      prefix: -fslgrad
  - id: shells
    type: ['null', string]
    doc: "specify one or more b-values to use during processing, as a comma-separated list of the desired approximate b-values (b-values are clustered to allow for small deviations). Note that some commands are incompatible with multiple b-values, and will report an error if more than one b-value is provided. WARNING: note that, even though the b=0 volumes are never referred to as shells in the literature, they still have to be explicitly included in the list of b-values as provided to the -shell option! Several algorithms which include the b=0 volumes in their computations may otherwise return an undesired result."
    inputBinding:
      prefix: -shells
  - id: export_grad_mrtrix
    type: ['null', string]
    doc: "export the diffusion-weighted gradient table to file in MRtrix format"
    inputBinding:
      prefix: -export_grad_mrtrix
  - id: export_grad_fsl
    type:
      - 'null'
      - type: array
        items: string
    doc: "export the diffusion-weighted gradient table to files in FSL (bvecs / bvals) format"
    inputBinding:
      prefix: -export_grad_fsl
  - id: import_pe_table
    type: ['null', File]
    doc: "import a phase-encoding table from file"
    inputBinding:
      prefix: -import_pe_table
  - id: import_pe_topup
    type: ['null', File]
    doc: "import a phase-encoding table intended for FSL TOPUP from file"
    inputBinding:
      prefix: -import_pe_topup
  - id: import_pe_eddy
    type:
      - 'null'
      - type: array
        items: File
    doc: "import phase-encoding information from an EDDY-style config / index file pair"
    inputBinding:
      prefix: -import_pe_eddy
  - id: pe
    type: ['null', string]
    doc: "select volumes with a particular phase encoding; this can be three comma-separated values (for i,j,k components of vector direction) or four (direction & total readout time)"
    inputBinding:
      prefix: -pe
  - id: strides
    type: ['null', string]
    doc: "specify the strides of the output data in memory; either as a comma-separated list of (signed) integers, or as a template image from which the strides shall be extracted and used. The actual strides produced will depend on whether the output image format can support it."
    inputBinding:
      prefix: -strides
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      prefix: -nthreads
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: "temporarily set the value of an MRtrix config file entry."
    inputBinding:
      prefix: -config
outputs:
  - id: output_file
    type: File
    doc: "the output image (diffusion-weighted volumes by default)."
    outputBinding:
      glob: $(inputs.output)
  - id: export_grad_mrtrix_file
    type: ['null', File]
    doc: "export the diffusion-weighted gradient table to file in MRtrix format"
    outputBinding:
      glob: $(inputs.export_grad_mrtrix)
  - id: export_grad_fsl_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "export the diffusion-weighted gradient table to files in FSL (bvecs / bvals) format"
    outputBinding:
      glob: $(inputs.export_grad_fsl)
