cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - muat
  - predict
  - wgs
label: muat_predict_wgs
doc: "Predict the tumour type of samples from somatic mutations (whole genome), using a single model.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: hg19
    type: ['null', File]
    doc: "Path to GRCh37/hg19 (.fa or .fa.gz)"
    inputBinding:
      prefix: --hg19
  - id: hg38
    type: ['null', File]
    doc: "Path to GRCh38/hg38 (.fa or .fa.gz)"
    inputBinding:
      prefix: --hg38
  - id: no_preprocess
    type: ['null', boolean]
    doc: "Predict directly from preprocessed data (.muat.tsv)"
    inputBinding:
      prefix: --no-preprocess
  - id: mutation_type
    type: ['null', string]
    doc: "Mutation type; only {snv, snv+mnv, snv+mnv+indel, snv+mnv+indel+svmei, snv+mnv+indel+svmei+neg} can be applied."
    inputBinding:
      prefix: --mutation-type
  - id: ckpt_filepath
    type: ['null', File]
    doc: "Path to load the checkpoint (.pthx). The mutation type will be adjusted accordingly when loading from the checkpoint."
    inputBinding:
      prefix: --ckpt-filepath
  - id: input_filepath
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input file paths (.vcf or .vcf.gz) or .muat.tsv for no preprocess"
    inputBinding:
      prefix: --input-filepath
  - id: result_dir
    type: string
    doc: "Result directory where the output will be written (.tsv)."
    inputBinding:
      prefix: --result-dir
  - id: tmp_dir
    type: ['null', string]
    doc: "Directory for storing preprocessed files."
    inputBinding:
      prefix: --tmp-dir
outputs:
  - id: result_dir_out
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.result_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
