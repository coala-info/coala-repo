cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fod2fixel]
label: mrtrix3_fod2fixel
doc: |-
  Perform segmentation of continuous Fibre Orientation Distributions (FODs) to produce discrete fixels

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fod
    type: File
    doc: the input fod image.
    inputBinding:
      position: 1
  - id: fixel_directory
    type: string
    doc: the output fixel directory
    inputBinding:
      position: 2
  - id: afd
    type: ['null', string]
    doc: output the total Apparent Fibre Density per fixel (integral of FOD lobe)
    inputBinding:
      prefix: -afd
  - id: peak_amp
    type: ['null', string]
    doc: output the amplitude of the FOD at the maximal peak per fixel
    inputBinding:
      prefix: -peak_amp
  - id: disp
    type: ['null', string]
    doc: output a measure of dispersion per fixel as the ratio between FOD lobe integral and maximal peak
      amplitude
    inputBinding:
      prefix: -disp
  - id: fmls_integral
    type: ['null', float]
    doc: 'threshold absolute numerical integral of positive FOD lobes. Any lobe for which the integral
      is smaller than this threshold will be discarded. Default: 0.'
    inputBinding:
      prefix: -fmls_integral
  - id: fmls_peak_value
    type: ['null', float]
    doc: 'threshold peak amplitude of positive FOD lobes. Any lobe for which the maximal peak amplitude
      is smaller than this threshold will be discarded. Default: 0.1.'
    inputBinding:
      prefix: -fmls_peak_value
  - id: fmls_no_thresholds
    type: ['null', boolean]
    doc: disable all FOD lobe thresholding; every lobe where the FOD is positive will be retained.
    inputBinding:
      prefix: -fmls_no_thresholds
  - id: fmls_lobe_merge_ratio
    type: ['null', float]
    doc: 'Specify the ratio between a given FOD amplitude sample between two lobes, and the smallest peak
      amplitude of the adjacent lobes, above which those lobes will be merged. This is the amplitude of
      the FOD at the ''bridge'' point between the two lobes, divided by the peak amplitude of the smaller
      of the two adjoining lobes. A value of 1.0 will never merge two lobes into one; a value of 0.0 will
      always merge lobes unless they are bisected by a zero-valued crossing. Default: 1.'
    inputBinding:
      prefix: -fmls_lobe_merge_ratio
  - id: mask
    type: ['null', File]
    doc: only perform computation within the specified binary brain mask image.
    inputBinding:
      prefix: -mask
  - id: maxnum
    type: ['null', int]
    doc: 'maximum number of fixels to output for any particular voxel (default: no limit)'
    inputBinding:
      prefix: -maxnum
  - id: nii
    type: ['null', boolean]
    doc: output the directions and index file in nii format (instead of the default mif)
    inputBinding:
      prefix: -nii
  - id: dirpeak
    type: ['null', boolean]
    doc: define the fixel direction as that of the lobe's maximal peak as opposed to its weighted mean
      direction (the default)
    inputBinding:
      prefix: -dirpeak
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
  - id: fixel_directory_out
    type: Directory
    doc: 'Output: the output fixel directory'
    outputBinding:
      glob: $(inputs.fixel_directory)
  - id: afd_out
    type: ['null', File]
    doc: 'Output file for -afd: output the total Apparent Fibre Density per fixel (integral of FOD lobe)
      (written inside the fixel directory)'
    outputBinding:
      glob: '$(inputs.afd ? inputs.fixel_directory + ''/'' + inputs.afd : null)'
  - id: peak_amp_out
    type: ['null', File]
    doc: 'Output file for -peak_amp: output the amplitude of the FOD at the maximal peak per fixel (written
      inside the fixel directory)'
    outputBinding:
      glob: '$(inputs.peak_amp ? inputs.fixel_directory + ''/'' + inputs.peak_amp : null)'
  - id: disp_out
    type: ['null', File]
    doc: 'Output file for -disp: output a measure of dispersion per fixel as the ratio between FOD lobe
      integral and maximal peak amplitude (written inside the fixel directory)'
    outputBinding:
      glob: '$(inputs.disp ? inputs.fixel_directory + ''/'' + inputs.disp : null)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
