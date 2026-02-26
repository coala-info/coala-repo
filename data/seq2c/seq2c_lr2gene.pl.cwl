cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq2c_lr2gene.pl
label: seq2c_lr2gene.pl
doc: "The lr2gene.pl program will convert a coverage file to copy number profile.
  The default parameters are designed for detecting such aberrations for high tumor
  purity samples, such as cancer cell lines.\n\nTool homepage: https://github.com/AstraZeneca-NGS/Seq2C"
inputs:
  - id: cov2lr_file
    type:
      type: array
      items: File
    doc: The coverage output file from cov2lr.pl script. Can also take from 
      standard in or more than one file.
    inputBinding:
      position: 1
  - id: cohort_count_threshold
    type:
      - 'null'
      - int
    doc: If a breakpoint has been detected more than 'int' samples, it is 
      considered false positives and removed.
    default: 5
    inputBinding:
      position: 102
      prefix: -N
  - id: cohort_fraction_threshold
    type:
      - 'null'
      - float
    doc: If a breakpoint has been detected more than 'float' fraction of 
      samples, it is considered false positive and removed.
    default: 0.03
    inputBinding:
      position: 102
      prefix: -R
  - id: control_normalization
    type:
      - 'null'
      - boolean
    doc: Indicate that control sample is used for normalization
    inputBinding:
      position: 102
      prefix: -c
  - id: debugging_mode
    type:
      - 'null'
      - boolean
    doc: Debugging mode
    inputBinding:
      position: 102
      prefix: -y
  - id: min_amplicons
    type:
      - 'null'
      - int
    doc: The minimum consecutive amplicons to look for deletions and 
      amplifications. Use with caution when it is less than 3.
    default: 1
    inputBinding:
      position: 102
      prefix: -s
  - id: min_exons_breakpoint
    type:
      - 'null'
      - float
    doc: When considering breakpoint in the middle of a gene, the minimum number
      of exons.
    default: 5.0
    inputBinding:
      position: 102
      prefix: -e
  - id: min_log2_amplified
    type:
      - 'null'
      - float
    doc: Minimum log2 ratio for a whole gene to be considered amplified.
    default: 1.5
    inputBinding:
      position: 102
      prefix: -A
  - id: min_log2_deleted
    type:
      - 'null'
      - float
    doc: Minimum log2 ratio for a whole gene to be considered deleted.
    default: -2.0
    inputBinding:
      position: 102
      prefix: -D
  - id: min_mad_value
    type:
      - 'null'
      - float
    doc: When considering partial deletions less than 3 exons/amplicons, the 
      minimum MAD value, in addition to -E, before considering it to be 
      amplified or deleted.
    default: 10.0
    inputBinding:
      position: 102
      prefix: -M
  - id: min_mean_log2_diff
    type:
      - 'null'
      - float
    doc: Minimum mean log2 ratio difference for <3 exon deletion/amplification 
      to be called.
    default: 1.25
    inputBinding:
      position: 102
      prefix: -E
  - id: min_segment_diff_breakpoint
    type:
      - 'null'
      - float
    doc: When considering breakpoint in the middle of a gene, the minimum 
      differences between the log2 of two segments.
    default: 0.4
    inputBinding:
      position: 102
      prefix: -t
  - id: min_segment_diff_ge3
    type:
      - 'null'
      - float
    doc: When considering >=3 exons deletion/amplification within a gene, the 
      minimum differences between the log2 of two segments.
    default: 0.5
    inputBinding:
      position: 102
      prefix: -d
  - id: p_value_breakpoint
    type:
      - 'null'
      - float
    doc: The p-value for t-test when the breakpoint is in the middle with min 
      exons/amplicons >= [-e].
    default: 1e-06
    inputBinding:
      position: 102
      prefix: -P
  - id: p_value_ge3
    type:
      - 'null'
      - float
    doc: The p-value for t-test when consecutive exons/amplicons are >= 3.
    default: 1e-05
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
stdout: seq2c_lr2gene.pl.out
