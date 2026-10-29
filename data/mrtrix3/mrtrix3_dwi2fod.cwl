cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwi2fod
doc: "Estimate fibre orientation distributions from diffusion data using spherical deconvolution\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwi2fod]
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: ResponseOdf
        type: record
        fields:
          - name: response
            type: File
            inputBinding:
              position: 1
          - name: odf
            type: string
            inputBinding:
              position: 2
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: algorithm
    type: string
    doc: "The algorithm to use for FOD estimation (csd or msmt_csd)."
    inputBinding:
      position: 10
  - id: dwi
    type: File
    doc: "The input diffusion-weighted image."
    inputBinding:
      position: 11
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
  - id: directions_file
    type: ['null', File]
    doc: "specify the directions over which to apply the non-negativity constraint (by default, the built-in 300 direction set is used). These should be supplied as a text file containing [ az el ] pairs for the directions."
    inputBinding:
      prefix: -directions
  - id: lmax
    type: ['null', string]
    doc: "the maximum spherical harmonic order for the output FOD(s).For algorithms with multiple outputs, this should be provided as a comma-separated list of integers, one for each output image; for single-output algorithms, only a single integer should be provided. If omitted, the command will use the lmax of the corresponding response function (i.e based on its number of coefficients), up to a maximum of 8."
    inputBinding:
      prefix: -lmax
  - id: mask
    type: ['null', File]
    doc: "only perform computation within the specified binary brain mask image."
    inputBinding:
      prefix: -mask
  - id: filter
    type: ['null', File]
    doc: "the linear frequency filtering parameters used for the initial linear spherical deconvolution step (default = [ 1 1 1 0 0 ]). These should be supplied as a text file containing the filtering coefficients for each even harmonic order."
    inputBinding:
      prefix: -filter
  - id: neg_lambda
    type: ['null', float]
    doc: "the regularisation parameter lambda that controls the strength of the non-negativity constraint (default = 1)."
    inputBinding:
      prefix: -neg_lambda
  - id: norm_lambda
    type: ['null', float]
    doc: "the regularisation parameter lambda that controls the strength of the constraint on the norm of the solution (default = 1)."
    inputBinding:
      prefix: -norm_lambda
  - id: threshold
    type: ['null', float]
    doc: "the threshold below which the amplitude of the FOD is assumed to be zero, expressed as an absolute amplitude (default = 0)."
    inputBinding:
      prefix: -threshold
  - id: niter
    type: ['null', int]
    doc: "the maximum number of iterations to perform for each voxel (default = 50). Use '-niter 0' for a linear unconstrained spherical deconvolution."
    inputBinding:
      prefix: -niter
  - id: predicted_signal
    type: ['null', string]
    doc: "output the predicted dwi image."
    inputBinding:
      prefix: -predicted_signal
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
  - id: response_odf
    type:
      type: array
      items: ResponseOdf
    doc: Pairs of input tissue response file and output ODF image name (one pair for csd, one per tissue for msmt_csd).
    inputBinding:
      position: 12
outputs:
  - id: predicted_signal_file
    type: ['null', File]
    doc: "output the predicted dwi image."
    outputBinding:
      glob: $(inputs.predicted_signal)
  - id: odf_files
    type: File[]
    doc: The output ODF images.
    outputBinding:
      glob: ${ return inputs.response_odf.map(function(p) { return p.odf; }); }
