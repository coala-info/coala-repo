cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckglobal
label: mrtrix3_tckglobal
doc: "Multi-Shell Multi-Tissue Global Tractography\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: source
    type: File
    doc: "the image containing the raw DWI data."
    inputBinding:
      position: 1
  - id: response
    type: File
    doc: "the response of a track segment on the DWI signal."
    inputBinding:
      position: 2
  - id: tracks
    type: string
    doc: "the output file containing the tracks generated."
    inputBinding:
      position: 3
  - id: grad
    type: ['null', File]
    doc: "specify the diffusion encoding scheme (required if not supplied in the header)."
    inputBinding:
      position: 10
      prefix: -grad
  - id: mask
    type: ['null', File]
    doc: "only reconstruct the tractogram within the specified brain mask image."
    inputBinding:
      position: 10
      prefix: -mask
  - id: riso
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -riso
    doc: "set one or more isotropic response functions. (multiple allowed)"
    inputBinding:
      position: 10
  - id: lmax
    type: ['null', int]
    doc: "set the maximum harmonic order for the output series. (default = 8)"
    inputBinding:
      position: 10
      prefix: -lmax
  - id: length
    type: ['null', float]
    doc: "set the length of the particles (fibre segments). (default = 1mm)"
    inputBinding:
      position: 10
      prefix: -length
  - id: weight
    type: ['null', float]
    doc: "set the weight by which particles contribute to the model. (default = 0.1)"
    inputBinding:
      position: 10
      prefix: -weight
  - id: ppot
    type: ['null', float]
    doc: "set the particle potential, i.e., the cost of adding one segment, relative to the particle weight. (default = 0.05)"
    inputBinding:
      position: 10
      prefix: -ppot
  - id: cpot
    type: ['null', float]
    doc: "set the connection potential, i.e., the energy term that drives two segments together. (default = 0.5)"
    inputBinding:
      position: 10
      prefix: -cpot
  - id: t0
    type: ['null', float]
    doc: "set the initial temperature of the metropolis hastings optimizer. (default = 0.1)"
    inputBinding:
      position: 10
      prefix: -t0
  - id: t1
    type: ['null', float]
    doc: "set the final temperature of the metropolis hastings optimizer. (default = 0.001)"
    inputBinding:
      position: 10
      prefix: -t1
  - id: niter
    type: ['null', int]
    doc: "set the number of iterations of the metropolis hastings optimizer. (default = 10M)"
    inputBinding:
      position: 10
      prefix: -niter
  - id: fod
    type: ['null', string]
    doc: "Predicted fibre orientation distribution function (fODF). This fODF is estimated as part of the global track optimization, and therefore incorporates the spatial regularization that it imposes. Internally, the fODF is represented as a discrete sum of apodized point spread functions (aPSF) oriented along the directions of all particles in the voxel, used to predict the DWI signal from the particle configuration."
    inputBinding:
      position: 10
      prefix: -fod
  - id: noapo
    type: ['null', boolean]
    doc: "disable spherical convolution of fODF with apodized PSF, to output a sum of delta functions rather than a sum of aPSFs."
    inputBinding:
      position: 10
      prefix: -noapo
  - id: fiso
    type: ['null', string]
    doc: "Predicted isotropic fractions of the tissues for which response functions were provided with -riso. Typically, these are CSF and GM."
    inputBinding:
      position: 10
      prefix: -fiso
  - id: eext
    type: ['null', string]
    doc: "Residual external energy in every voxel."
    inputBinding:
      position: 10
      prefix: -eext
  - id: etrend
    type: ['null', string]
    doc: "internal and external energy trend and cooling statistics."
    inputBinding:
      position: 10
      prefix: -etrend
  - id: balance
    type: ['null', float]
    doc: "balance internal and external energy. (default = 0) Negative values give more weight to the internal energy, positive to the external energy."
    inputBinding:
      position: 10
      prefix: -balance
  - id: density
    type: ['null', float]
    doc: "set the desired density of the free Poisson process. (default = 1)"
    inputBinding:
      position: 10
      prefix: -density
  - id: prob
    type: ['null', string]
    doc: "set the probabilities of generating birth, death, randshift, optshift and connect proposals respectively. (default = 0.25,0.05,0.25,0.1,0.35)"
    inputBinding:
      position: 10
      prefix: -prob
  - id: beta
    type: ['null', float]
    doc: "set the width of the Hanning interpolation window. (in [0, 1], default = 0) If used, a mask is required, and this mask must keep at least one voxel distance to the image bounding box."
    inputBinding:
      position: 10
      prefix: -beta
  - id: lambda
    type: ['null', float]
    doc: "set the weight of the internal energy directly. (default = 1) If provided, any value of -balance will be ignored."
    inputBinding:
      position: 10
      prefix: -lambda
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
  - id: tracks_file
    type: File
    doc: Output file given by tracks.
    outputBinding:
      glob: $(inputs.tracks)
  - id: fod_file
    type: ['null', File]
    doc: Output file given by -fod.
    outputBinding:
      glob: $(inputs.fod)
  - id: fiso_file
    type: ['null', File]
    doc: Output file given by -fiso.
    outputBinding:
      glob: $(inputs.fiso)
  - id: eext_file
    type: ['null', File]
    doc: Output file given by -eext.
    outputBinding:
      glob: $(inputs.eext)
  - id: etrend_file
    type: ['null', File]
    doc: Output file given by -etrend.
    outputBinding:
      glob: $(inputs.etrend)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
