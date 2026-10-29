cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwi2response_dhollander
doc: "Unsupervised estimation of WM, GM and CSF response functions that does not require a T1 image (or segmentation thereof)\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwi2response, dhollander]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "Input DWI dataset"
    inputBinding:
      position: 10
  - id: out_sfwm
    type: string
    doc: "Output single-fibre WM response function text file"
    inputBinding:
      position: 11
  - id: out_gm
    type: string
    doc: "Output GM response function text file"
    inputBinding:
      position: 12
  - id: out_csf
    type: string
    doc: "Output CSF response function text file"
    inputBinding:
      position: 13
  - id: erode
    type: ['null', int]
    doc: "Number of erosion passes to apply to initial (whole brain) mask. Set to 0 to not erode the brain mask. (default: 3)"
    inputBinding:
      prefix: -erode
  - id: fa
    type: ['null', float]
    doc: "FA threshold for crude WM versus GM-CSF separation. (default: 0.2)"
    inputBinding:
      prefix: -fa
  - id: sfwm
    type: ['null', float]
    doc: "Final number of single-fibre WM voxels to select, as a percentage of refined WM. (default: 0.5 per cent)"
    inputBinding:
      prefix: -sfwm
  - id: gm
    type: ['null', float]
    doc: "Final number of GM voxels to select, as a percentage of refined GM. (default: 2 per cent)"
    inputBinding:
      prefix: -gm
  - id: csf
    type: ['null', float]
    doc: "Final number of CSF voxels to select, as a percentage of refined CSF. (default: 10 per cent)"
    inputBinding:
      prefix: -csf
  - id: wm_algo
    type: ['null', string]
    doc: "Use external dwi2response algorithm for WM single-fibre voxel selection (options: fa, tax, tournier) (default: built-in Dhollander 2019)"
    inputBinding:
      prefix: -wm_algo
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
  - id: out_sfwm_file
    type: File
    doc: "Output single-fibre WM response function text file"
    outputBinding:
      glob: $(inputs.out_sfwm)
  - id: out_gm_file
    type: File
    doc: "Output GM response function text file"
    outputBinding:
      glob: $(inputs.out_gm)
  - id: out_csf_file
    type: File
    doc: "Output CSF response function text file"
    outputBinding:
      glob: $(inputs.out_csf)
  - id: voxels_file
    type: ['null', File]
    doc: "Output an image showing the final voxel selection(s)"
    outputBinding:
      glob: $(inputs.voxels)
