cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwi2tensor
doc: "Diffusion (kurtosis) tensor estimation\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwi2tensor]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: dwi
    type: File
    doc: "the input dwi image."
    inputBinding:
      position: 10
  - id: dt
    type: string
    doc: "the output dt image."
    inputBinding:
      position: 11
  - id: ols
    type: ['null', boolean]
    doc: "perform initial fit using an ordinary least-squares (OLS) fit (see Description)."
    inputBinding:
      prefix: -ols
  - id: mask
    type: ['null', File]
    doc: "only perform computation within the specified binary brain mask image."
    inputBinding:
      prefix: -mask
  - id: b0
    type: ['null', string]
    doc: "the output b0 image."
    inputBinding:
      prefix: -b0
  - id: dkt
    type: ['null', string]
    doc: "the output dkt image."
    inputBinding:
      prefix: -dkt
  - id: iter
    type: ['null', int]
    doc: "number of iterative reweightings for IWLS algorithm (default: 2) (see Description)."
    inputBinding:
      prefix: -iter
  - id: predicted_signal
    type: ['null', string]
    doc: "the predicted dwi image."
    inputBinding:
      prefix: -predicted_signal
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
  - id: dt_file
    type: File
    doc: "the output dt image."
    outputBinding:
      glob: $(inputs.dt)
  - id: b0_file
    type: ['null', File]
    doc: "the output b0 image."
    outputBinding:
      glob: $(inputs.b0)
  - id: dkt_file
    type: ['null', File]
    doc: "the output dkt image."
    outputBinding:
      glob: $(inputs.dkt)
  - id: predicted_signal_file
    type: ['null', File]
    doc: "the predicted dwi image."
    outputBinding:
      glob: $(inputs.predicted_signal)
