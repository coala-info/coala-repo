cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwinormalise_group
doc: "Performs a global DWI intensity normalisation on a group of subjects using the median b=0 white matter value as the reference\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwinormalise, group]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input_dir
    type: Directory
    doc: "The input directory containing all DWI images"
    inputBinding:
      position: 10
  - id: mask_dir
    type: Directory
    doc: "Input directory containing brain masks, corresponding to one per input image (with the same file name prefix)"
    inputBinding:
      position: 11
  - id: output_dir
    type: string
    doc: "The output directory containing all of the intensity normalised DWI images"
    inputBinding:
      position: 12
  - id: fa_template
    type: string
    doc: "The output population specific FA template, which is threshold to estimate a white matter mask"
    inputBinding:
      position: 13
  - id: wm_mask
    type: string
    doc: "The output white matter mask (in template space), used to estimate the median b=0 white matter value for normalisation"
    inputBinding:
      position: 14
  - id: fa_threshold
    type: ['null', float]
    doc: "The threshold applied to the Fractional Anisotropy group template used to derive an approximate white matter mask (default: 0.4)"
    inputBinding:
      prefix: -fa_threshold
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
  - id: output_dir_dir
    type: Directory
    doc: "The output directory containing all of the intensity normalised DWI images"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: fa_template_file
    type: File
    doc: "The output population specific FA template, which is threshold to estimate a white matter mask"
    outputBinding:
      glob: $(inputs.fa_template)
  - id: wm_mask_file
    type: File
    doc: "The output white matter mask (in template space), used to estimate the median b=0 white matter value for normalisation"
    outputBinding:
      glob: $(inputs.wm_mask)
