cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_amp2response
doc: "Estimate response function coefficients based on the DWI signal in single-fibre voxels\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [amp2response]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: amps
    type: File
    doc: "the amplitudes image"
    inputBinding:
      position: 10
  - id: mask
    type: File
    doc: "the mask containing the voxels from which to estimate the response function"
    inputBinding:
      position: 11
  - id: directions
    type: File
    doc: "a 4D image containing the estimated fibre directions"
    inputBinding:
      position: 12
  - id: response
    type: string
    doc: "the output zonal spherical harmonic coefficients"
    inputBinding:
      position: 13
  - id: isotropic
    type: ['null', boolean]
    doc: "estimate an isotropic response function (lmax=0 for all shells)"
    inputBinding:
      prefix: -isotropic
  - id: noconstraint
    type: ['null', boolean]
    doc: "disable the non-negativity and monotonicity constraints"
    inputBinding:
      prefix: -noconstraint
  - id: directions_file
    type: ['null', File]
    doc: "provide an external text file containing the directions along which the amplitudes are sampled"
    inputBinding:
      prefix: -directions
  - id: shells
    type: ['null', string]
    doc: "specify one or more b-values to use during processing, as a comma-separated list of the desired approximate b-values (b-values are clustered to allow for small deviations). Note that some commands are incompatible with multiple b-values, and will report an error if more than one b-value is provided. WARNING: note that, even though the b=0 volumes are never referred to as shells in the literature, they still have to be explicitly included in the list of b-values as provided to the -shell option! Several algorithms which include the b=0 volumes in their computations may otherwise return an undesired result."
    inputBinding:
      prefix: -shells
  - id: lmax
    type: ['null', string]
    doc: "specify the maximum harmonic degree of the response function to estimate (can be a comma-separated list for multi-shell data)"
    inputBinding:
      prefix: -lmax
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
  - id: response_file
    type: File
    doc: "the output zonal spherical harmonic coefficients"
    outputBinding:
      glob: $(inputs.response)
