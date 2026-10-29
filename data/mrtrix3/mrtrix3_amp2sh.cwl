cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_amp2sh
doc: "Convert a set of amplitudes (defined along a set of corresponding directions) to their spherical harmonic representation\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [amp2sh]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: amp
    type: File
    doc: "the input amplitude image."
    inputBinding:
      position: 10
  - id: sh
    type: string
    doc: "the output spherical harmonics coefficients image."
    inputBinding:
      position: 11
  - id: lmax
    type: ['null', int]
    doc: "set the maximum harmonic order for the output series. By default, the program will use the highest possible lmax given the number of diffusion-weighted images, up to a maximum of 8."
    inputBinding:
      prefix: -lmax
  - id: normalise
    type: ['null', boolean]
    doc: "normalise the DW signal to the b=0 image"
    inputBinding:
      prefix: -normalise
  - id: directions
    type: ['null', File]
    doc: "the directions corresponding to the input amplitude image used to sample AFD. By default this option is not required providing the direction set is supplied in the amplitude image. This should be supplied as a list of directions [az el], as generated using the dirgen command, or as a list of [ x y z ] Cartesian coordinates."
    inputBinding:
      prefix: -directions
  - id: rician
    type: ['null', File]
    doc: "correct for Rician noise induced bias, using noise map supplied"
    inputBinding:
      prefix: -rician
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
  - id: sh_file
    type: File
    doc: "the output spherical harmonics coefficients image."
    outputBinding:
      glob: $(inputs.sh)
