cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mtnormalise]
label: mrtrix3_mtnormalise
doc: |-
  Multi-tissue informed log-domain intensity normalisation

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: mtnormalise_pair
        type: record
        fields:
          - name: input
            type: File
            doc: input tissue compartment image
            inputBinding:
              position: 1
          - name: output
            type: string
            doc: output file name of the normalised compartment
            inputBinding:
              position: 2
inputs:
  - id: images
    type:
      type: array
      items: mtnormalise_pair
    doc: 'list of all input and output tissue compartment files: each pair is an input image followed
      by its output image.'
    inputBinding:
      position: 1
  - id: mask
    type: File
    doc: the mask defines the data used to compute the intensity normalisation. This option is mandatory.
    inputBinding:
      prefix: -mask
  - id: order
    type: ['null', string]
    doc: 'the maximum order of the polynomial basis used to fit the normalisation field in the log-domain.
      An order of 0 is equivalent to not allowing spatial variance of the intensity normalisation factor.
      (default: 3) (choices: 0 1 2 3)'
    inputBinding:
      prefix: -order
  - id: niter
    type: ['null', string]
    doc: 'set the number of iterations. The first (and potentially only) entry applies to the main loop.
      If supplied as a comma-separated list of integers, the second entry applies to the inner loop to
      update the balance factors (default: 15,7).'
    inputBinding:
      prefix: -niter
  - id: reference
    type: ['null', float]
    doc: 'specify the (positive) reference value to which the summed tissue compartments will be normalised.
      (default: 0.282095, SH DC term for unit angular integral)'
    inputBinding:
      prefix: -reference
  - id: balanced
    type: ['null', boolean]
    doc: 'incorporate the per-tissue balancing factors into scaling of the output images (NOTE: use of
      this option has critical consequences for AFD intensity normalisation; should not be used unless
      these consequences are fully understood)'
    inputBinding:
      prefix: -balanced
  - id: check_norm
    type: ['null', string]
    doc: output the final estimated spatially varying intensity level that is used for normalisation.
    inputBinding:
      prefix: -check_norm
  - id: check_mask
    type: ['null', string]
    doc: output the final mask used to compute the normalisation. This mask excludes regions identified
      as outliers by the optimisation process.
    inputBinding:
      prefix: -check_mask
  - id: check_factors
    type: ['null', string]
    doc: output the tissue balance factors computed during normalisation.
    inputBinding:
      prefix: -check_factors
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
  - id: normalised
    type:
      type: array
      items: File
    doc: Normalised tissue compartment images.
    outputBinding:
      glob: $(inputs.images.map(function(p) { return p.output; }))
  - id: check_norm_out
    type: ['null', File]
    doc: 'Output file for -check_norm: output the final estimated spatially varying intensity level that
      is used for normalisation.'
    outputBinding:
      glob: $(inputs.check_norm)
  - id: check_mask_out
    type: ['null', File]
    doc: 'Output file for -check_mask: output the final mask used to compute the normalisation. This mask
      excludes regions identified as outliers by the optimisation process.'
    outputBinding:
      glob: $(inputs.check_mask)
  - id: check_factors_out
    type: ['null', File]
    doc: 'Output file for -check_factors: output the tissue balance factors computed during normalisation.'
    outputBinding:
      glob: $(inputs.check_factors)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
