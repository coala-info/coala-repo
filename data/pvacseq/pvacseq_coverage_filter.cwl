cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - coverage_filter
label: pvacseq_coverage_filter
doc: "Filter pVACseq final report based on coverage and expression values\n\nTool
  homepage: https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: input_file
    type: File
    doc: The final report .tsv file to filter
    inputBinding:
      position: 1
  - id: expn_val
    type:
      - 'null'
      - float
    doc: Gene and Transcript Expression cutoff. Sites above this cutoff will be 
      considered
    inputBinding:
      position: 102
      prefix: --expn-val
  - id: normal_cov
    type:
      - 'null'
      - int
    doc: Normal Coverage Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 102
      prefix: --normal-cov
  - id: normal_vaf
    type:
      - 'null'
      - float
    doc: Normal VAF Cutoff. Sites BELOW this cutoff in normal will be 
      considered.
    inputBinding:
      position: 102
      prefix: --normal-vaf
  - id: tdna_cov
    type:
      - 'null'
      - int
    doc: Tumor DNA Coverage Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 102
      prefix: --tdna-cov
  - id: tdna_vaf
    type:
      - 'null'
      - float
    doc: Tumor DNA VAF Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 102
      prefix: --tdna-vaf
  - id: trna_cov
    type:
      - 'null'
      - int
    doc: Tumor RNA Coverage Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 102
      prefix: --trna-cov
  - id: trna_vaf
    type:
      - 'null'
      - float
    doc: Tumor RNA VAF Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 102
      prefix: --trna-vaf
outputs:
  - id: output_file
    type: File
    doc: Output .tsv file containing list of filtered epitopes based on coverage
      and expression values
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
