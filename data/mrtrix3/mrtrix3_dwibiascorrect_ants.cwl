cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwibiascorrect_ants
doc: "Perform DWI bias field correction using the N4 algorithm as provided in ANTs\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwibiascorrect, ants]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "The input image series to be corrected"
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "The output corrected image series"
    inputBinding:
      position: 11
  - id: ants_b
    type: ['null', string]
    doc: "N4BiasFieldCorrection option -b. [initial mesh resolution in mm, spline order] This value is optimised for human adult data and needs to be adjusted for rodent data."
    inputBinding:
      prefix: -ants.b
  - id: ants_c
    type: ['null', string]
    doc: "N4BiasFieldCorrection option -c. [numberOfIterations,convergenceThreshold]"
    inputBinding:
      prefix: -ants.c
  - id: ants_s
    type: ['null', string]
    doc: "N4BiasFieldCorrection option -s. shrink-factor applied to spatial dimensions"
    inputBinding:
      prefix: -ants.s
  - id: grad
    type: ['null', File]
    doc: "Provide the diffusion gradient table in MRtrix format"
    inputBinding:
      prefix: -grad
  - id: fslgrad
    type:
      - 'null'
      - type: array
        items: File
    doc: "Provide the diffusion gradient table in FSL bvecs/bvals format"
    inputBinding:
      prefix: -fslgrad
  - id: mask
    type: ['null', File]
    doc: "Manually provide a mask image for bias field estimation"
    inputBinding:
      prefix: -mask
  - id: bias
    type: ['null', string]
    doc: "Output the estimated bias field"
    inputBinding:
      prefix: -bias
  - id: nocleanup
    type: ['null', boolean]
    doc: "do not delete intermediate files during script execution, and do not delete scratch directory at script completion."
    inputBinding:
      prefix: -nocleanup
  - id: scratch
    type: ['null', string]
    doc: "manually specify the path in which to generate the scratch directory."
    inputBinding:
      prefix: -scratch
  - id: continue
    type:
      - 'null'
      - type: array
        items: string
    doc: "continue the script from a previous execution; must provide the scratch directory path, and the name of the last successfully-generated file."
    inputBinding:
      prefix: -continue
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status. Alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non- empty string."
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files."
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
  - id: output_file
    type: File
    doc: "The output corrected image series"
    outputBinding:
      glob: $(inputs.output)
  - id: bias_file
    type: ['null', File]
    doc: "Output the estimated bias field"
    outputBinding:
      glob: $(inputs.bias)
