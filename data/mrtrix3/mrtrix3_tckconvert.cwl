cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckconvert
label: mrtrix3_tckconvert
doc: "Convert between different track file formats\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: input
    type: File
    doc: "the input track file."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "the output track file."
    inputBinding:
      position: 2
  - id: scanner2voxel
    type: ['null', File]
    doc: "if specified, the properties of this image will be used to convert track point positions from real (scanner) coordinates into voxel coordinates."
    inputBinding:
      position: 10
      prefix: -scanner2voxel
  - id: scanner2image
    type: ['null', File]
    doc: "if specified, the properties of this image will be used to convert track point positions from real (scanner) coordinates into image coordinates (in mm)."
    inputBinding:
      position: 10
      prefix: -scanner2image
  - id: voxel2scanner
    type: ['null', File]
    doc: "if specified, the properties of this image will be used to convert track point positions from voxel coordinates into real (scanner) coordinates."
    inputBinding:
      position: 10
      prefix: -voxel2scanner
  - id: image2scanner
    type: ['null', File]
    doc: "if specified, the properties of this image will be used to convert track point positions from image coordinates (in mm) into real (scanner) coordinates."
    inputBinding:
      position: 10
      prefix: -image2scanner
  - id: sides
    type: ['null', int]
    doc: "number of sides for streamlines"
    inputBinding:
      position: 10
      prefix: -sides
  - id: increment
    type: ['null', int]
    doc: "generate streamline points at every (increment) points"
    inputBinding:
      position: 10
      prefix: -increment
  - id: dec
    type: ['null', boolean]
    doc: "add DEC as a primvar"
    inputBinding:
      position: 10
      prefix: -dec
  - id: radius
    type: ['null', float]
    doc: "radius of the streamlines"
    inputBinding:
      position: 10
      prefix: -radius
  - id: ascii
    type: ['null', boolean]
    doc: "write an ASCII VTK file (this is the default)"
    inputBinding:
      position: 10
      prefix: -ascii
  - id: binary
    type: ['null', boolean]
    doc: "write a binary VTK file"
    inputBinding:
      position: 10
      prefix: -binary
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
  - id: output_file
    type: File
    doc: Output file given by output.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
