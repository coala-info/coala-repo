cwlVersion: v1.2
class: CommandLineTool
baseCommand: analyze
label: mimsi_analyze
doc: "MiMSI Analysis\n\nTool homepage: https://github.com/mskcc/mimsi"
inputs:
  - id: case_id
    type:
      - 'null'
      - string
    doc: Unique identifier for the single sample/case submitted. This will be 
      the filename for any saved results
    inputBinding:
      position: 101
      prefix: --case-id
  - id: case_list
    type:
      - 'null'
      - File
    doc: Case List for generating sample vectors in bulk, if specified all other
      input file args will be ignored
    inputBinding:
      position: 101
      prefix: --case-list
  - id: confidence_interval
    type:
      - 'null'
      - float
    doc: Confidence interval for the estimated MSI Score reported in the tsv 
      output file
    inputBinding:
      position: 101
      prefix: --confidence-interval
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to utilize in parallel
    inputBinding:
      position: 101
      prefix: --cores
  - id: coverage
    type:
      - 'null'
      - int
    doc: Required coverage for both the tumor and the normal. Any coverage in 
      excess of this limit will be randomly downsampled
    inputBinding:
      position: 101
      prefix: --coverage
  - id: microsatellites_list
    type:
      - 'null'
      - File
    doc: The list of microsatellites to check in the tumor/normal pair
    inputBinding:
      position: 101
      prefix: --microsatellites-list
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
    doc: name of the run submitted using --case-list, this will be the filename 
      for any saved results in the tsv format
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
  - id: norm_case_id
    type:
      - 'null'
      - string
    doc: Normal case name
    inputBinding:
      position: 101
      prefix: --norm-case-id
  - id: normal_bam
    type:
      - 'null'
      - File
    doc: Matched normal bam file for conversion
    inputBinding:
      position: 101
      prefix: --normal-bam
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
    doc: 'The location on the filesystem to save the converted vectors and final results.
      WARNING: Exisitng files in this directory in the formats *_locations.npy and
      *_data.npy will be deleted!'
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
  - id: tumor_bam
    type:
      - 'null'
      - File
    doc: Tumor bam file for conversion
    inputBinding:
      position: 101
      prefix: --tumor-bam
  - id: use_attention
    type:
      - 'null'
      - boolean
    doc: Use attention pooling rather than average pooling to aggregate sample 
      embeddings
    inputBinding:
      position: 101
      prefix: --use-attention
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
stdout: mimsi_analyze.out
