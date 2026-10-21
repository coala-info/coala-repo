cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcf2rocplot
label: rtg-tools_rtg_vcf2rocplot
doc: 'Produce rocplot compatible ROC data files from vcfeval annotated VCFs. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bed_regions
    type:
      - 'null'
      - File
    doc: 'if set, only read VCF records that overlap the ranges contained in the specified BED file'
    inputBinding:
      position: 101
      prefix: --bed-regions
  - id: output
    type: string
    doc: 'directory for output'
    inputBinding:
      position: 101
      prefix: --output
  - id: region
    type:
      - 'null'
      - string
    doc: 'if set, only read VCF records within the specified range. The format is one of <sequence_name>, <sequence_name>:<start>-<end>, <sequence_name>:<pos>+<length> or <sequence_name>:<pos>~<padding>'
    inputBinding:
      position: 101
      prefix: --region
  - id: at_precision
    type:
      - 'null'
      - float
    doc: 'output summary statistics where precision >= supplied value (Default is to summarize at maximum F-measure)'
    inputBinding:
      position: 101
      prefix: --at-precision
  - id: at_score
    type:
      - 'null'
      - float
    doc: 'output summary statistics where score meets supplied value (Default is to summarize at maximum F-measure)'
    inputBinding:
      position: 101
      prefix: --at-score
  - id: at_sensitivity
    type:
      - 'null'
      - float
    doc: 'output summary statistics where sensitivity >= supplied value (Default is to summarize at maximum F-measure)'
    inputBinding:
      position: 101
      prefix: --at-sensitivity
  - id: roc_cross_join
    type:
      - 'null'
      - boolean
    doc: 'output ROC files for each intersection of --roc-subset, --roc-expr, and --roc-regions values provided'
    inputBinding:
      position: 101
      prefix: --roc-cross-join
  - id: roc_expr
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --roc-expr
    doc: 'output ROC file for variants matching custom JavaScript expression. Use the form <LABEL>=<EXPRESSION>. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: roc_regions
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --roc-regions
    doc: 'output ROC file for variants overlapping custom regions supplied in BED file. Use the form <LABEL>=<FILENAME>. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: roc_subset
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --roc-subset
    doc: 'output ROC file for preset variant subset. Allowed values are [hom, het, snp, non-snp, mnp, indel, dup, del]. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'the order in which to sort the ROC scores so that "good" scores come before "bad" scores. Allowed values are [ascending, descending] (Default is descending)'
    inputBinding:
      position: 101
      prefix: --sort-order
  - id: vcf_score_field
    type:
      - 'null'
      - string
    doc: 'the name of the VCF FORMAT field to use as the ROC score. Also valid are "QUAL", "INFO.<name>" or "FORMAT.<name>" to select the named VCF FORMAT or INFO field, or use "EXPR.<LABEL>=<EXPRESSION>" to define a JavaScript expression that dynamically computes a score (Default is QUAL)'
    inputBinding:
      position: 101
      prefix: --vcf-score-field
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (Default is the number of available cores)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: files
    type:
      type: array
      items: File
    doc: 'input VCF files containing vcfeval annotations. Must be specified 1 or more times'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: 'Directory with the ROC data files'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_vcf2rocplot.out
