cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dwigradcheck
doc: "Check the orientation of the diffusion gradient table\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dwigradcheck]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stderr: dwigradcheck.log
inputs:
  - id: input
    type: File
    doc: "The input DWI series to be checked"
    inputBinding:
      position: 10
  - id: mask
    type: ['null', File]
    doc: "Provide a brain mask image"
    inputBinding:
      prefix: -mask
  - id: number
    type: ['null', int]
    doc: "Set the number of tracks to generate for each test"
    inputBinding:
      prefix: -number
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
  - id: export_grad_mrtrix
    type: ['null', string]
    doc: "Export the final gradient table in MRtrix format"
    inputBinding:
      prefix: -export_grad_mrtrix
  - id: export_grad_fsl
    type:
      - 'null'
      - type: array
        items: string
    doc: "Export the final gradient table in FSL bvecs/bvals format"
    inputBinding:
      prefix: -export_grad_fsl
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
  - id: export_grad_mrtrix_file
    type: ['null', File]
    doc: "Export the final gradient table in MRtrix format"
    outputBinding:
      glob: $(inputs.export_grad_mrtrix)
  - id: export_grad_fsl_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Export the final gradient table in FSL bvecs/bvals format"
    outputBinding:
      glob: $(inputs.export_grad_fsl)
  - id: stderr_log
    type: stderr
    doc: Messages printed by the command on standard error.
