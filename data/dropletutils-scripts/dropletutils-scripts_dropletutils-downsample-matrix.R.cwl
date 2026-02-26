cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropletutils-downsample-matrix.R
label: dropletutils-scripts_dropletutils-downsample-matrix.R
doc: "Downsamples a SingleCellExperiment object by a specified proportion.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs:
  - id: bycol
    type:
      - 'null'
      - boolean
    doc: A logical scalar indicating whether downsampling should be performed on
      a column-by-column basis.
    inputBinding:
      position: 101
      prefix: --bycol
  - id: input_object_file
    type: File
    doc: File name in which a serialized R SingleCellExperiment object can be 
      found
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: prop
    type: float
    doc: A numeric scalar or, if bycol=TRUE, a file with ncol(x) lines 
      specifying a value for each cell. All values should lie in [0, 1] 
      specifying the downsampling proportion for the matrix or for each cell.
    inputBinding:
      position: 101
      prefix: --prop
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized SingleCellExperiment object.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
