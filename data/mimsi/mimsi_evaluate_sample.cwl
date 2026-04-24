cwlVersion: v1.2
class: CommandLineTool
baseCommand: evaluate_sample
label: mimsi_evaluate_sample
doc: "MiMSI Sample(s) Evalution Utility\n\nTool homepage: https://github.com/mskcc/mimsi"
inputs:
  - id: confidence_interval
    type:
      - 'null'
      - float
    doc: Confidence interval for the estimated MSI Score reported in the tsv 
      output file
    inputBinding:
      position: 101
      prefix: --confidence-interval
  - id: coverage
    type:
      - 'null'
      - int
    doc: Required coverage for both the tumor and the normal. Any coverage in 
      excess of this limit will be randomly downsampled
    inputBinding:
      position: 101
      prefix: --coverage
  - id: model
    type:
      - 'null'
      - string
    doc: name of the saved model weights to load
    inputBinding:
      position: 101
      prefix: --model
  - id: name
    type:
      - 'null'
      - string
    doc: name of the run, this will be the filename for any saved results in tsv
      format with more than one samples.
    inputBinding:
      position: 101
      prefix: --name
  - id: no_cuda
    type:
      - 'null'
      - boolean
    doc: Disables CUDA for use off GPU, if this is not specified the utility 
      will check availability of torch.cuda
    inputBinding:
      position: 101
      prefix: --no-cuda
  - id: save
    type:
      - 'null'
      - boolean
    doc: save the results of the evaluation to a numpy array or a tsv text file
    inputBinding:
      position: 101
      prefix: --save
  - id: save_format
    type:
      - 'null'
      - string
    doc: save the results of the evaluation to a numpy array or as summary in a 
      tsv text file or both
    inputBinding:
      position: 101
      prefix: --save-format
  - id: save_location
    type:
      - 'null'
      - Directory
    doc: The location on the filesystem to save the final results
    inputBinding:
      position: 101
      prefix: --save-location
  - id: seed
    type:
      - 'null'
      - int
    doc: Random Seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: use_attention
    type:
      - 'null'
      - boolean
    doc: Use attention pooling rather than average pooling to aggregate sample 
      embeddings
    inputBinding:
      position: 101
      prefix: --use-attention
  - id: vector_location
    type:
      - 'null'
      - Directory
    doc: directory containing the generated vectors to evaluate
    inputBinding:
      position: 101
      prefix: --vector-location
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
stdout: mimsi_evaluate_sample.out
