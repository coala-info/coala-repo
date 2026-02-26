cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msisensor-rna
  - genes
label: msisensor-rna_genes
doc: "Select informative genes for microsatellite instability detection.\n\nTool homepage:
  https://github.com/xjtu-omics/msisensor-rna"
inputs:
  - id: input_file
    type: File
    doc: The path of input file. e.g. xxx.csv
    inputBinding:
      position: 101
      prefix: --input
  - id: positive_num
    type:
      - 'null'
      - int
    doc: The minimum positive sample of MSI for training.
    default: 10
    inputBinding:
      position: 101
      prefix: --positive_num
  - id: threads
    type:
      - 'null'
      - int
    doc: The threads used to run this program.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: thresh_aucscore
    type:
      - 'null'
      - float
    doc: 'Threshold for AUC score: AUC score was calculating by the sklearn package.'
    default: 0.65
    inputBinding:
      position: 101
      prefix: --thresh_AUCscore
  - id: thresh_cov
    type:
      - 'null'
      - float
    doc: Threshold for coefficient of variation of gene expression value of all 
      samples (Mean/Std).
    default: 0.5
    inputBinding:
      position: 101
      prefix: --thresh_cov
  - id: thresh_p_ranksum
    type:
      - 'null'
      - float
    doc: Threshold for Pvalue of rank sum test between MSI-H and MSS samples.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --thresh_p_ranksum
outputs:
  - id: output_file
    type: File
    doc: The output file of gene information. e.g. xxx.csv
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
