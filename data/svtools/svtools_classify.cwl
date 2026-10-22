cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - classify
label: svtools_classify
doc: 'Classify structural variants (reclassify DEL/DUP/MEI) in a VCF file.


  Tool homepage: https://github.com/hall-lab/svtools'
inputs:
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: VCF input
    inputBinding:
      position: 101
      prefix: --input
  - id: output_vcf
    type:
      - 'null'
      - string
    doc: VCF output [stdout]
    inputBinding:
      position: 101
      prefix: --output
  - id: gender_file
    type: File
    doc: 'Tab delimited file of sample genders (male=1, female=2) ex: SAMPLE_A 2'
    inputBinding:
      position: 101
      prefix: --gender
  - id: annotation
    type:
      - 'null'
      - File
    doc: BED file of annotated elements
    inputBinding:
      position: 101
      prefix: --annotation
  - id: fraction
    type:
      - 'null'
      - double
    doc: Fraction of reciprocal overlap to apply annotation to variant [0.9]
    inputBinding:
      position: 101
      prefix: --fraction
  - id: exclude
    type:
      - 'null'
      - File
    doc: List of samples to exclude from classification algorithms
    inputBinding:
      position: 101
      prefix: --exclude
  - id: slope_threshold
    type:
      - 'null'
      - double
    doc: Minimum slope absolute value of regression line to classify as DEL or DUP
      [1.0]
    inputBinding:
      position: 101
      prefix: --slope_threshold
  - id: rsquared_threshold
    type:
      - 'null'
      - double
    doc: Minimum R^2 correlation value of regression line to classify as DEL or DUP
      [0.2], for large sample reclassification
    inputBinding:
      position: 101
      prefix: --rsquared_threshold
  - id: training_set
    type:
      - 'null'
      - File
    doc: High quality deletions & duplications training dataset [vcf], required by
      naive Bayes reclassification
    inputBinding:
      position: 101
      prefix: --tSet
  - id: method
    type:
      - 'null'
      - string
    doc: Reclassification method, one of (large_sample, naive_bayes, hybrid)
    inputBinding:
      position: 101
      prefix: --method
  - id: diag_file
    type:
      - 'null'
      - string
    doc: Text file to output method comparisons
    inputBinding:
      position: 101
      prefix: --diag_file
  - id: sex_chrom
    type:
      - 'null'
      - string
    doc: Comma-separated list of sex chromosome names [chrX,chrY]
    inputBinding:
      position: 101
      prefix: --sex-chrom
  - id: tempdir
    type:
      - 'null'
      - string
    doc: Directory for temp file downloads
    inputBinding:
      position: 101
      prefix: --tempdir
outputs:
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: Reclassified VCF
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: out_diag_file
    type:
      - 'null'
      - File
    doc: Method comparison diagnostics
    outputBinding:
      glob: $(inputs.diag_file)
  - id: stdout
    type: stdout
    doc: Output when --output is not given
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_classify.out
