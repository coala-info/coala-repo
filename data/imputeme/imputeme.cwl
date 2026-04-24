cwlVersion: v1.2
class: CommandLineTool
baseCommand: imputeme
label: imputeme
doc: "Impute missing genotype data using various methods.\n\nTool homepage: https://github.com/hshepard8/imputeme"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file with missing genotype data.
    inputBinding:
      position: 1
  - id: k
    type:
      - 'null'
      - int
    doc: Number of neighbors to consider for KNN imputation.
    inputBinding:
      position: 102
      prefix: --k
  - id: method
    type:
      - 'null'
      - string
    doc: Imputation method to use (e.g., 'knn', 'mean', 'median').
    inputBinding:
      position: 102
      prefix: --method
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file with imputed genotypes.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/imputeme:vv1.0.7_cv1
