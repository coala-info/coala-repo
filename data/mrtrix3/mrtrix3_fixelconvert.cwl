cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_fixelconvert
doc: "Convert between the old format fixel image (.msf / .msh) and the new fixel directory format\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [fixelconvert]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: fixel_in
    type:
      - File
      - Directory
    doc: "the input fixel file / directory."
    inputBinding:
      position: 10
  - id: fixel_out
    type: string
    doc: "the output fixel file / directory."
    inputBinding:
      position: 11
  - id: name
    type: ['null', string]
    doc: "assign a different name to the value field output (Default: value). Do not include the file extension."
    inputBinding:
      prefix: -name
  - id: nii
    type: ['null', boolean]
    doc: "output the index, directions and data file in NIfTI format instead of .mif"
    inputBinding:
      prefix: -nii
  - id: out_size
    type: ['null', boolean]
    doc: "also output the 'size' field from the old format"
    inputBinding:
      prefix: -out_size
  - id: template
    type: ['null', Directory]
    doc: "specify an existing fixel directory (in the new format) to which the new output should conform"
    inputBinding:
      prefix: -template
  - id: value
    type: ['null', File]
    doc: "nominate the data file to import to the 'value' field in the old format"
    inputBinding:
      prefix: -value
  - id: in_size
    type: ['null', File]
    doc: "import data for the 'size' field in the old format"
    inputBinding:
      prefix: -in_size
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
  - id: fixel_out_result
    type:
      - File
      - Directory
    doc: The output fixel file (old format) or fixel directory (new format).
    outputBinding:
      glob: $(inputs.fixel_out)
