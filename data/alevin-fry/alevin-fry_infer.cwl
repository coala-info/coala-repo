cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - infer
label: alevin-fry_infer
doc: "Perform inference on equivalence class count data\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: count_mat
    type: File
    doc: matrix of cells by equivalence class counts
    inputBinding:
      position: 101
      prefix: --count-mat
  - id: eq_labels
    type: File
    doc: file containing the gene labels of the equivalence classes
    inputBinding:
      position: 101
      prefix: --eq-labels
  - id: quant_subset
    type:
      - 'null'
      - File
    doc: file containing list of barcodes to quantify, those not in this list will
      be ignored
    inputBinding:
      position: 101
      prefix: --quant-subset
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for processing
    inputBinding:
      position: 101
      prefix: --threads
  - id: usa
    type:
      - 'null'
      - boolean
    doc: flag specifying that input equivalence classes were computed in USA mode
    inputBinding:
      position: 101
      prefix: --usa
  - id: use_eds
    type:
      - 'null'
      - boolean
    doc: flag for writing output matrix in EDS format
    inputBinding:
      position: 101
      prefix: --use-eds
  - id: use_mtx
    type:
      - 'null'
      - boolean
    doc: flag for writing output matrix in matrix market format (default)
    inputBinding:
      position: 101
      prefix: --use-mtx
outputs:
  - id: output_dir
    type: Directory
    doc: output directory where quantification results will be written
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
