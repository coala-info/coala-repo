cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_fixelcorrespondence
doc: "Obtain fixel-fixel correpondence between a subject fixel image and a template fixel mask\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [fixelcorrespondence]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: subject_data_directory
    type: Directory
    doc: "Fixel directory containing the file named in subject_data."
  - id: subject_data
    type: string
    doc: "the input subject fixel data file. This should be a file inside the fixel directory Give the file name inside the fixel directory."
    inputBinding:
      position: 10
      valueFrom: $(inputs.subject_data_directory.path)/$(self)
  - id: template_directory
    type: Directory
    doc: "the input template fixel directory."
    inputBinding:
      position: 11
  - id: output_directory
    type: string
    doc: "the fixel directory where the output file will be written."
    inputBinding:
      position: 12
  - id: output_data
    type: string
    doc: "the name of the output fixel data file. This will be placed in the output fixel directory"
    inputBinding:
      position: 13
  - id: angle
    type: ['null', float]
    doc: "the max angle threshold for computing inter-subject fixel correspondence (Default: 45 degrees)"
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
  - id: output_directory_dir
    type: Directory
    doc: "the fixel directory where the output file will be written."
    outputBinding:
      glob: $(inputs.output_directory)
