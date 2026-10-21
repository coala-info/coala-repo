cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - bndeval
label: rtg-tools_rtg_bndeval
doc: 'Evaluate called breakends for agreement with a baseline breakend set. Outputs a weighted ROC file which can be viewed with rtg rocplot and VCF files containing false positives (called breakends not matched in the baseline), false negatives (baseline breakends not matched in the call set), and true positives (breakends that match between the baseline and calls). Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: baseline
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'VCF file containing baseline variants'
    inputBinding:
      position: 101
      prefix: --baseline
  - id: bed_regions
    type:
      - 'null'
      - File
    doc: 'if set, only read VCF records that overlap the ranges contained in the specified BED file'
    inputBinding:
      position: 101
      prefix: --bed-regions
  - id: calls
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'VCF file containing called variants'
    inputBinding:
      position: 101
      prefix: --calls
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
  - id: all_records
    type:
      - 'null'
      - boolean
    doc: 'use all records regardless of FILTER status (Default is to only process records where FILTER is "." or "PASS")'
    inputBinding:
      position: 101
      prefix: --all-records
  - id: bidirectional
    type:
      - 'null'
      - boolean
    doc: 'if set, allow matches between flipped breakends'
    inputBinding:
      position: 101
      prefix: --bidirectional
  - id: tolerance
    type:
      - 'null'
      - int
    doc: 'positional tolerance for breakend matching (Default is 100)'
    inputBinding:
      position: 101
      prefix: --tolerance
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
  - id: no_roc
    type:
      - 'null'
      - boolean
    doc: 'do not produce ROCs'
    inputBinding:
      position: 101
      prefix: --no-roc
  - id: output_mode
    type:
      - 'null'
      - string
    doc: 'output reporting mode. Allowed values are [split, annotate] (Default is split)'
    inputBinding:
      position: 101
      prefix: --output-mode
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
    doc: 'the name of the VCF FORMAT field to use as the ROC score. Also valid are "QUAL", "INFO.<name>" or "FORMAT.<name>" to select the named VCF FORMAT or INFO field, or use "EXPR.<LABEL>=<EXPRESSION>" to define a JavaScript expression that dynamically computes a score (Default is INFO.DP)'
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: 'Output directory (summary.txt, tp.vcf.gz, fp.vcf.gz, fn.vcf.gz, ROC files)'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_bndeval.out
