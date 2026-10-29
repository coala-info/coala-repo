cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_5ttcheck
doc: "Thoroughly check that one or more images conform to the expected ACT five-tissue-type (5TT) format\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [5ttcheck]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stderr: 5ttcheck.log
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "the 5TT image(s) to be tested"
    inputBinding:
      position: 10
  - id: voxels
    type: ['null', string]
    doc: "output mask images highlighting voxels where the input does not conform to 5TT requirements"
    inputBinding:
      prefix: -voxels
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
  - id: voxels_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "output mask images highlighting voxels where the input does not conform to 5TT requirements"
    outputBinding:
      glob: $(inputs.voxels)*
  - id: stderr_log
    type: stderr
    doc: Messages printed by the command on standard error.
