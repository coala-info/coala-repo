cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fod2dec]
label: mrtrix3_fod2dec
doc: |-
  Generate FOD-based DEC maps, with optional panchromatic sharpening and/or luminance/perception correction

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: The input FOD image (spherical harmonic coefficients).
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: The output DEC image (weighted RGB triplets).
    inputBinding:
      position: 2
  - id: mask
    type: ['null', File]
    doc: Only perform DEC computation within the specified mask image.
    inputBinding:
      prefix: -mask
  - id: contrast
    type: ['null', File]
    doc: 'Weight the computed DEC map by the provided image contrast. If the contrast has a different
      image grid, the DEC map is first resliced and renormalised. To achieve panchromatic sharpening,
      provide an image with a higher spatial resolution than the input FOD image; e.g., a T1 anatomical
      volume. Only the DEC is subject to the mask, so as to allow for partial colouring of the contrast
      image. Default when this option is *not* provided: integral of input FOD, subject to the same mask/threshold
      as used for DEC computation.'
    inputBinding:
      prefix: -contrast
  - id: lum
    type: ['null', boolean]
    doc: Correct for luminance/perception, using default values Cr,Cg,Cb = 0.3,0.5,0.2 and gamma = 2.2
      (*not* correcting is the theoretical equivalent of Cr,Cg,Cb = 1,1,1 and gamma = 2).
    inputBinding:
      prefix: -lum
  - id: lum_coefs
    type: ['null', string]
    doc: 'The coefficients Cr,Cg,Cb to correct for luminance/perception. Note: this implicitly switches
      on luminance/perception correction, using a default gamma = 2.2 unless specified otherwise.'
    inputBinding:
      prefix: -lum_coefs
  - id: lum_gamma
    type: ['null', float]
    doc: 'The gamma value to correct for luminance/perception. Note: this implicitly switches on luminance/perception
      correction, using a default Cr,Cg,Cb = 0.3,0.5,0.2 unless specified otherwise.'
    inputBinding:
      prefix: -lum_gamma
  - id: threshold
    type: ['null', float]
    doc: FOD amplitudes below the threshold value are considered zero.
    inputBinding:
      prefix: -threshold
  - id: no_weight
    type: ['null', boolean]
    doc: Do not weight the DEC map; just output the unweighted colours. Reslicing and renormalising of
      colours will still happen when providing the -contrast option as a template.
    inputBinding:
      prefix: -no_weight
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
    doc: 'Output: The output DEC image (weighted RGB triplets).'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
