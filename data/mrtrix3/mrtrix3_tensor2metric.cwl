cwlVersion: v1.2
class: CommandLineTool
baseCommand: tensor2metric
label: mrtrix3_tensor2metric
doc: "Generate maps of tensor-derived parameters\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tensor
    type: File
    doc: "the input tensor image."
    inputBinding:
      position: 1
  - id: adc
    type: ['null', string]
    doc: "compute the mean apparent diffusion coefficient (ADC) of the diffusion tensor. (sometimes also referred to as the mean diffusivity (MD))"
    inputBinding:
      position: 10
      prefix: -adc
  - id: fa
    type: ['null', string]
    doc: "compute the fractional anisotropy (FA) of the diffusion tensor."
    inputBinding:
      position: 10
      prefix: -fa
  - id: ad
    type: ['null', string]
    doc: "compute the axial diffusivity (AD) of the diffusion tensor. (equivalent to the principal eigenvalue)"
    inputBinding:
      position: 10
      prefix: -ad
  - id: rd
    type: ['null', string]
    doc: "compute the radial diffusivity (RD) of the diffusion tensor. (equivalent to the mean of the two non-principal eigenvalues)"
    inputBinding:
      position: 10
      prefix: -rd
  - id: cl
    type: ['null', string]
    doc: "compute the linearity metric of the diffusion tensor. (one of the three Westin shape metrics)"
    inputBinding:
      position: 10
      prefix: -cl
  - id: cp
    type: ['null', string]
    doc: "compute the planarity metric of the diffusion tensor. (one of the three Westin shape metrics)"
    inputBinding:
      position: 10
      prefix: -cp
  - id: cs
    type: ['null', string]
    doc: "compute the sphericity metric of the diffusion tensor. (one of the three Westin shape metrics)"
    inputBinding:
      position: 10
      prefix: -cs
  - id: value
    type: ['null', string]
    doc: "compute the selected eigenvalue(s) of the diffusion tensor."
    inputBinding:
      position: 10
      prefix: -value
  - id: vector
    type: ['null', string]
    doc: "compute the selected eigenvector(s) of the diffusion tensor."
    inputBinding:
      position: 10
      prefix: -vector
  - id: num
    type: ['null', string]
    doc: "specify the desired eigenvalue/eigenvector(s). Note that several eigenvalues can be specified as a number sequence. For example, '1,3' specifies the principal (1) and minor (3) eigenvalues/eigenvectors (default = 1)."
    inputBinding:
      position: 10
      prefix: -num
  - id: modulate
    type: ['null', string]
    doc: "specify how to modulate the magnitude of the eigenvectors. Valid choices are: none, FA, eigval (default = FA)."
    inputBinding:
      position: 10
      prefix: -modulate
  - id: mask
    type: ['null', File]
    doc: "only perform computation within the specified binary brain mask image."
    inputBinding:
      position: 10
      prefix: -mask
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
  - id: adc_file
    type: ['null', File]
    doc: Output file given by -adc.
    outputBinding:
      glob: $(inputs.adc)
  - id: fa_file
    type: ['null', File]
    doc: Output file given by -fa.
    outputBinding:
      glob: $(inputs.fa)
  - id: ad_file
    type: ['null', File]
    doc: Output file given by -ad.
    outputBinding:
      glob: $(inputs.ad)
  - id: rd_file
    type: ['null', File]
    doc: Output file given by -rd.
    outputBinding:
      glob: $(inputs.rd)
  - id: cl_file
    type: ['null', File]
    doc: Output file given by -cl.
    outputBinding:
      glob: $(inputs.cl)
  - id: cp_file
    type: ['null', File]
    doc: Output file given by -cp.
    outputBinding:
      glob: $(inputs.cp)
  - id: cs_file
    type: ['null', File]
    doc: Output file given by -cs.
    outputBinding:
      glob: $(inputs.cs)
  - id: value_file
    type: ['null', File]
    doc: Output file given by -value.
    outputBinding:
      glob: $(inputs.value)
  - id: vector_file
    type: ['null', File]
    doc: Output file given by -vector.
    outputBinding:
      glob: $(inputs.vector)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
