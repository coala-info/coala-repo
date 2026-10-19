cwlVersion: v1.2
class: CommandLineTool
baseCommand: enet_predict_pyseer
label: pyseer_enet_predict
doc: "Predict phenotypes using a fitted elastic net model.\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs:
  - id: model
    type: File
    doc: Name of fitted model pickle file (.pkl).
    inputBinding:
      position: 1
  - id: samples
    type: File
    doc: File with samples to predict.
    inputBinding:
      position: 2
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold to pick binary predictions.
    inputBinding:
      position: 3
      prefix: --threshold
  - id: lineage_clusters
    type:
      - 'null'
      - File
    doc: Custom clusters to use as lineages to report stratified accuracy.
    inputBinding:
      position: 3
      prefix: --lineage-clusters
  - id: true_values
    type:
      - 'null'
      - File
    doc: Pheno file with known phenotypes to calculate accuracy.
    inputBinding:
      position: 3
      prefix: --true-values
  - id: ignore_missing
    type:
      - 'null'
      - boolean
    doc: Treat missing values as REF/0 rather than using the mean AF.
    inputBinding:
      position: 3
      prefix: --ignore-missing
  - id: kmers
    type:
      - 'null'
      - File
    doc: Kmers file.
    inputBinding:
      position: 3
      prefix: --kmers
  - id: vcf
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: VCF file. Will filter any non 'PASS' sites.
    inputBinding:
      position: 3
      prefix: --vcf
  - id: pres
    type:
      - 'null'
      - File
    doc: Presence/absence .Rtab matrix as produced by roary and piggy.
    inputBinding:
      position: 3
      prefix: --pres
  - id: burden
    type:
      - 'null'
      - File
    doc: VCF regions to group variants by for burden testing (requires --vcf). Requires vcf to be indexed.
    inputBinding:
      position: 3
      prefix: --burden
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Uncompressed kmers file.
    inputBinding:
      position: 3
      prefix: --uncompressed
  - id: covariates
    type:
      - 'null'
      - File
    doc: User-defined covariates file (tab-delimited, no header, first column contains sample names).
    inputBinding:
      position: 3
      prefix: --covariates
  - id: use_covariates
    type:
      - 'null'
      - type: array
        items: string
    doc: Covariates to use. Format is "2 3q 4" (q for quantitative).
    inputBinding:
      position: 3
      prefix: --use-covariates
outputs:
  - id: predictions
    type: stdout
    doc: Predicted phenotypes
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer_enet_predict.out
