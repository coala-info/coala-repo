cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwinormalise_individual
doc: "Intensity normalise a DWI series based on the b=0 signal within a supplied mask\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwinormalise, individual]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input_dwi
    type: File
    doc: "The input DWI series"
    inputBinding:
      position: 10
  - id: input_mask
    type: File
    doc: "The mask within which a reference b=0 intensity will be sampled"
    inputBinding:
      position: 11
  - id: output_dwi
    type: string
    doc: "The output intensity-normalised DWI series"
    inputBinding:
      position: 12
  - id: intensity
    type: ['null', float]
    doc: "Normalise the b=0 signal to a specified value (Default: 1000)"
    inputBinding:
      prefix: -intensity
  - id: percentile
    type: ['null', int]
    doc: "Define the percentile of the b=0 image intensties within the mask used for normalisation; if this option is not supplied then the median value (50th percentile) will be normalised to the desired intensity value"
    inputBinding:
      prefix: -percentile
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
  - id: output_dwi_file
    type: File
    doc: "The output intensity-normalised DWI series"
    outputBinding:
      glob: $(inputs.output_dwi)
