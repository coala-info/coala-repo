cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropletutils-barcoderanks.R
label: dropletutils-scripts_dropletutils-barcoderanks.R
doc: "R script for barcode ranking in droplet-based single-cell experiments.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs:
  - id: fit_bounds
    type: string
    doc: A string, '<lower>,<upper>', specifying the lower and upper bouunds on 
      the total UMI count for spline fitting.
    inputBinding:
      position: 101
      prefix: --fit-bounds
  - id: input_object_file
    type: File
    doc: File name in which a serialized R SingleCellExperiment object can be 
      found
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: lower
    type: float
    doc: A numeric scalar specifying the lower bound on the total UMI count, at 
      or below which all barcodes are assumed to correspond to empty droplets.
    inputBinding:
      position: 101
      prefix: --lower
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized SingleCellExperiment object.
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_png_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized SingleCellExperiment object.
    outputBinding:
      glob: $(inputs.output_png_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
