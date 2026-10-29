cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwi2response_msmt_5tt
doc: "Derive MSMT-CSD tissue response functions based on a co-registered five- tissue-type (5TT) image\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwi2response, msmt_5tt]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "The input DWI"
    inputBinding:
      position: 10
  - id: in_5tt
    type: File
    doc: "Input co-registered 5TT image"
    inputBinding:
      position: 11
  - id: out_wm
    type: string
    doc: "Output WM response text file"
    inputBinding:
      position: 12
  - id: out_gm
    type: string
    doc: "Output GM response text file"
    inputBinding:
      position: 13
  - id: out_csf
    type: string
    doc: "Output CSF response text file"
    inputBinding:
      position: 14
  - id: dirs
    type: ['null', File]
    doc: "Manually provide the fibre direction in each voxel (a tensor fit will be used otherwise)"
    inputBinding:
      prefix: -dirs
  - id: fa
    type: ['null', float]
    doc: "Upper fractional anisotropy threshold for GM and CSF voxel selection (default: 0.2)"
    inputBinding:
      prefix: -fa
  - id: pvf
    type: ['null', float]
    doc: "Partial volume fraction threshold for tissue voxel selection (default: 0.95)"
    inputBinding:
      prefix: -pvf
  - id: wm_algo
    type: ['null', string]
    doc: "dwi2response algorithm to use for WM single-fibre voxel selection (options: fa, tax, tournier; default: tournier)"
    inputBinding:
      prefix: -wm_algo
  - id: sfwm_fa_threshold
    type: ['null', float]
    doc: "Sets -wm_algo to fa and allows to specify a hard FA threshold for single- fibre WM voxels, which is passed to the -threshold option of the fa algorithm (warning: overrides -wm_algo option)"
    inputBinding:
      prefix: -sfwm_fa_threshold
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
    doc: "Provide an initial mask for response voxel selection"
    inputBinding:
      prefix: -mask
  - id: voxels
    type: ['null', string]
    doc: "Output an image showing the final voxel selection(s)"
    inputBinding:
      prefix: -voxels
  - id: shells
    type: ['null', string]
    doc: "The b-value(s) to use in response function estimation (comma-separated list in case of multiple b-values, b=0 must be included explicitly)"
    inputBinding:
      prefix: -shells
  - id: lmax
    type: ['null', string]
    doc: "The maximum harmonic degree(s) for response function estimation (comma- separated list in case of multiple b-values)"
    inputBinding:
      prefix: -lmax
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
  - id: out_wm_file
    type: File
    doc: "Output WM response text file"
    outputBinding:
      glob: $(inputs.out_wm)
  - id: out_gm_file
    type: File
    doc: "Output GM response text file"
    outputBinding:
      glob: $(inputs.out_gm)
  - id: out_csf_file
    type: File
    doc: "Output CSF response text file"
    outputBinding:
      glob: $(inputs.out_csf)
  - id: voxels_file
    type: ['null', File]
    doc: "Output an image showing the final voxel selection(s)"
    outputBinding:
      glob: $(inputs.voxels)
