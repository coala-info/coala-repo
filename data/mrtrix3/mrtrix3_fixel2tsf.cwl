cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_fixel2tsf
doc: "Map fixel values to a track scalar file based on an input tractogram\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [fixel2tsf]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: fixel_in_directory
    type: Directory
    doc: "Fixel directory containing the file named in fixel_in."
  - id: fixel_in
    type: string
    doc: "the input fixel data file (within the fixel directory) Give the file name inside the fixel directory."
    inputBinding:
      position: 10
      valueFrom: $(inputs.fixel_in_directory.path)/$(self)
  - id: tracks
    type: File
    doc: "the input track file"
    inputBinding:
      position: 11
  - id: tsf
    type: string
    doc: "the output track scalar file"
    inputBinding:
      position: 12
  - id: angle
    type: ['null', float]
    doc: "the max anglular threshold for computing correspondence between a fixel direction and track tangent (default = 45 degrees)"
    inputBinding:
      prefix: -angle
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
  - id: tsf_file
    type: File
    doc: "the output track scalar file"
    outputBinding:
      glob: $(inputs.tsf)
