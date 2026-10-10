cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - preprocess_ukbb_v3
label: motifraptor_preprocess_ukbb_v3
doc: "Pre-process the summary statistics from UKBB version 3 TSV files\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: gwas_summary
    type:
      - 'null'
      - File
    doc: "GWAS summary statistic - UKBB v3 tsv filename"
    inputBinding:
      position: 1
      prefix: -gwas
  - id: score_pvalue_threshold
    type:
      - 'null'
      - float
    doc: "threshold for pvalue - default 5E-8"
    inputBinding:
      position: 1
      prefix: -th
outputs:
  - id: output_files
    type: File[]
    doc: "Pre-processed SNP lists written to the working directory"
    outputBinding:
      glob: ["*.txt", "*.vcf"]
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_preprocess_ukbb_v3.out
