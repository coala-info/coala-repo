cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dirorder
doc: "Reorder a set of directions to ensure near-uniformity upon truncation\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dirorder]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "the input directions file"
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "the output directions file"
    inputBinding:
      position: 11
  - id: cartesian
    type: ['null', boolean]
    doc: "Output the directions in Cartesian coordinates [x y z] instead of [az el]."
    inputBinding:
      prefix: -cartesian
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
  - id: output_file
    type: File
    doc: "the output directions file"
    outputBinding:
      glob: $(inputs.output)
