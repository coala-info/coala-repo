cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_fixel2sh
doc: "Convert a fixel-based sparse-data image into an spherical harmonic image\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [fixel2sh]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: fixel_in_directory
    type: Directory
    doc: "Fixel directory containing the file named in fixel_in."
  - id: fixel_in
    type: string
    doc: "the input fixel data file. Give the file name inside the fixel directory."
    inputBinding:
      position: 10
      valueFrom: $(inputs.fixel_in_directory.path)/$(self)
  - id: sh_out
    type: string
    doc: "the output sh image."
    inputBinding:
      position: 11
  - id: lmax
    type: ['null', int]
    doc: "set the maximum harmonic order for the output series (Default: 8)"
    inputBinding:
      prefix: -lmax
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
  - id: sh_out_file
    type: File
    doc: "the output sh image."
    outputBinding:
      glob: $(inputs.sh_out)
