cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsfinfo
label: mrtrix3_tsfinfo
doc: "Print out information about a track scalar file\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks
    type:
      type: array
      items: File
    doc: "the input track scalar file."
    inputBinding:
      position: 1
  - id: count
    type: ['null', boolean]
    doc: "count number of tracks in file explicitly, ignoring the header"
    inputBinding:
      position: 10
      prefix: -count
  - id: ascii
    type: ['null', string]
    doc: "save values of each track scalar file in individual ascii files, with the specified prefix."
    inputBinding:
      position: 10
      prefix: -ascii
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: ascii_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given by -ascii.
    outputBinding:
      glob: $(inputs.ascii + "*")
  - id: tsf_info
    type: File
    doc: Text printed by the command.
    outputBinding:
      glob: tsfinfo.txt
stdout: tsfinfo.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
