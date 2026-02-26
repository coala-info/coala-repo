cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/dropletutils-empty-drops.R
label: dropletutils-scripts_dropletutils-empty-drops.R
doc: "Identify empty droplets from UMI count data.\n\nTool homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs:
  - id: filter_empty
    type:
      - 'null'
      - boolean
    doc: Should barcodes estimated to have no cells be removed from the output 
      object?
    inputBinding:
      position: 101
      prefix: --filter-empty
  - id: filter_fdr
    type:
      - 'null'
      - float
    doc: FDR filter for removal of barcodes with no cells
    inputBinding:
      position: 101
      prefix: --filter-fdr
  - id: ignore
    type:
      - 'null'
      - float
    doc: A numeric scalar specifying the lower bound on the total UMI count, at 
      or below which barcodes will be ignored.
    inputBinding:
      position: 101
      prefix: --ignore
  - id: input_object_file
    type: File
    doc: File name in which a serialized R SingleCellExperiment object can be 
      found.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: lower
    type:
      - 'null'
      - float
    doc: A numeric scalar specifying the lower bound on the total UMI count, at 
      or below which all barcodes are assumed to correspond to empty droplets.
    inputBinding:
      position: 101
      prefix: --lower
  - id: niters
    type:
      - 'null'
      - int
    doc: An integer scalar specifying the number of iterations to use for the 
      Monte Carlo p-value calculations.
    inputBinding:
      position: 101
      prefix: --niters
  - id: retain
    type:
      - 'null'
      - float
    doc: A numeric scalar specifying the threshold for the total UMI count above
      which all barcodes are assumed to contain cells.
    inputBinding:
      position: 101
      prefix: --retain
  - id: test_ambient
    type:
      - 'null'
      - boolean
    doc: A logical scalar indicating whether results should be returned for 
      barcodes with totals less than or equal to lower.
    inputBinding:
      position: 101
      prefix: --test-ambient
outputs:
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: File name of text file in which to store output data frame.
    outputBinding:
      glob: $(inputs.output_text_file)
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized SingleCellExperiment object.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
