cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_predict
doc: "Predicts structural variations using a trained model.\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: column_label
    type:
      - 'null'
      - string
    doc: Column name for the prediction in the output.
    inputBinding:
      position: 101
      prefix: --column-label
  - id: gtf
    type:
      - 'null'
      - boolean
    doc: 'Set to True if you want overlapping annotations to be merged and written
      as GTF file. IMPORTANT: Requires genomic coordinates in input.'
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_file
    type: File
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
  - id: model_path
    type:
      - 'null'
      - File
    doc: If running a model test (--task test) or prediction (--task predict), 
      this is the path of the model to evaluate. The data set to use should be 
      handed over with -i, --input.
    inputBinding:
      position: 101
      prefix: --model-path
  - id: outfile
    type: Directory
    doc: Name for the output directory (Required).
    inputBinding:
      position: 101
      prefix: --outfile
  - id: probability
    type:
      - 'null'
      - boolean
    doc: 'Set to True if you want class probabilities assigned in final output. Warning:
      Requires model to be trained with probability flag.'
    inputBinding:
      position: 101
      prefix: --probability
  - id: structure
    type:
      - 'null'
      - string
    doc: Set to True if only features for conservation of secondary structure 
      should be used. Depends on type of model.
    default: NCRNA
    inputBinding:
      position: 101
      prefix: --structure
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
stdout: svhip_predict.out
