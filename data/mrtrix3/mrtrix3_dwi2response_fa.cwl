cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwi2response_fa
doc: "Use the old FA-threshold heuristic for single-fibre voxel selection and response function estimation\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwi2response, fa]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "The input DWI"
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "The output response function text file"
    inputBinding:
      position: 11
  - id: erode
    type: ['null', int]
    doc: "Number of brain mask erosion steps to apply prior to threshold (not used if mask is provided manually)"
    inputBinding:
      prefix: -erode
  - id: number
    type: ['null', int]
    doc: "The number of highest-FA voxels to use"
    inputBinding:
      prefix: -number
  - id: threshold
    type: ['null', float]
    doc: "Apply a hard FA threshold, rather than selecting the top voxels"
    inputBinding:
      prefix: -threshold
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
  - id: output_file
    type: File
    doc: "The output response function text file"
    outputBinding:
      glob: $(inputs.output)
  - id: voxels_file
    type: ['null', File]
    doc: "Output an image showing the final voxel selection(s)"
    outputBinding:
      glob: $(inputs.voxels)
