cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwidenoise
doc: "dMRI noise level estimation and denoising using Marchenko-Pastur PCA\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwidenoise]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: dwi
    type: File
    doc: "the input diffusion-weighted image."
    inputBinding:
      position: 10
  - id: out
    type: string
    doc: "the output denoised DWI image."
    inputBinding:
      position: 11
  - id: mask
    type: ['null', File]
    doc: "Only process voxels within the specified binary brain mask image."
    inputBinding:
      prefix: -mask
  - id: extent
    type: ['null', string]
    doc: "Set the patch size of the denoising filter. By default, the command will select the smallest isotropic patch size that exceeds the number of DW images in the input data, e.g., 5x5x5 for data with <= 125 DWI volumes, 7x7x7 for data with <= 343 DWI volumes, etc."
    inputBinding:
      prefix: -extent
  - id: noise
    type: ['null', string]
    doc: "The output noise map, i.e., the estimated noise level 'sigma' in the data. Note that on complex input data, this will be the total noise level across real and imaginary channels, so a scale factor sqrt(2) applies."
    inputBinding:
      prefix: -noise
  - id: datatype
    type: ['null', string]
    doc: "Datatype for the eigenvalue decomposition (single or double precision). For complex input data, this will select complex float32 or complex float64 datatypes."
    inputBinding:
      prefix: -datatype
  - id: estimator
    type: ['null', string]
    doc: "Select the noise level estimator (default = Exp2), either: * Exp1: the original estimator used in Veraart et al. (2016), or * Exp2: the improved estimator introduced in Cordero-Grande et al. (2019)."
    inputBinding:
      prefix: -estimator
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
  - id: out_file
    type: File
    doc: "the output denoised DWI image."
    outputBinding:
      glob: $(inputs.out)
  - id: noise_file
    type: ['null', File]
    doc: "The output noise map, i.e., the estimated noise level 'sigma' in the data. Note that on complex input data, this will be the total noise level across real and imaginary channels, so a scale factor sqrt(2) applies."
    outputBinding:
      glob: $(inputs.noise)
