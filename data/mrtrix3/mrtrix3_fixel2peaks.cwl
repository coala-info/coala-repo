cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_fixel2peaks
doc: "Convert data in the fixel directory format into a 4D image of 3-vectors\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [fixel2peaks]
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: out
    type: string
    doc: "The output peaks image."
    inputBinding:
      position: 11
  - id: number
    type: ['null', int]
    doc: "maximum number of fixels in each voxel (default: based on input data)"
    inputBinding:
      prefix: -number
  - id: nan
    type: ['null', boolean]
    doc: "fill excess peak data with NaNs rather than zeroes"
    inputBinding:
      prefix: -nan
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
  - id: in_directory
    type: Directory
    doc: The input fixel directory.
    inputBinding:
      position: 10
      valueFrom: "$(inputs.in_file ? self.path + '/' + inputs.in_file : self.path)"
  - id: in_file
    type: ['null', string]
    doc: Optional name of a file inside the fixel directory (index, directions or a fixel data file). Use a data file to write peaks scaled by its values. Without it the whole directory is read.
outputs:
  - id: out_file
    type: File
    doc: "The output peaks image."
    outputBinding:
      glob: $(inputs.out)
