cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - combine-counts-fw
label: hatchet_combine_counts_fw
doc: "Combine tumor bin counts, normal bin counts, and tumor allele counts to obtain the read-depth ratio and the mean B-allele frequency (BAF) of each bin. The output (BB file) is written to standard output.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: normalbins
    type: File
    doc: "Normal bin counts in the format \"SAMPLE CHR START END COUNT\""
    inputBinding:
      position: 10
      prefix: -c
  - id: tumorbins
    type: File
    doc: "Tumor bin counts in the format \"SAMPLE CHR START END COUNT\""
    inputBinding:
      position: 10
      prefix: -C
  - id: tumorbafs
    type: File
    doc: "Tumor allele counts in the format \"SAMPLE CHR POS REF-COUNT ALT-COUNT\""
    inputBinding:
      position: 10
      prefix: -B
  - id: phase
    type:
      - 'null'
      - File
    doc: "Phasing of heterozygous germline SNPs in the format \"CHR POS <string containing 0|1 or 1|0>\""
    inputBinding:
      position: 10
      prefix: -p
  - id: diploidbaf
    type:
      - 'null'
      - float
    doc: "Maximum diploid-BAF shift used to select the bins whose BAF should be normalized by the normal when normalbafs is given (default: 0.1)"
    inputBinding:
      position: 10
      prefix: -d
  - id: blocklength
    type:
      - 'null'
      - string
    doc: "Size of the haplotype blocks, specified as a full number or using the notations either \"kb\" or \"Mb\" (default: 50kb)"
    inputBinding:
      position: 10
      prefix: -l
  - id: totalcounts
    type:
      - 'null'
      - File
    doc: "Total read counts in the format \"SAMPLE COUNT\" used to normalize by the different number of reads extracted from each sample (default: none)"
    inputBinding:
      position: 10
      prefix: -t
  - id: gamma
    type:
      - 'null'
      - float
    doc: "Confidence level used to determine if a bin is copy neutral with BAF of 0.5 in the BINOMIAL_TEST mode (default: 0.05)"
    inputBinding:
      position: 10
      prefix: -g
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed used for the normal distributions used in the clouds (default: 0)"
    inputBinding:
      position: 10
      prefix: -e
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose log messages
    inputBinding:
      position: 10
      prefix: -v
  - id: disablebar
    type:
      - 'null'
      - boolean
    doc: Disable progress bar
    inputBinding:
      position: 10
      prefix: -r
outputs:
  - id: bb_file
    type: File
    doc: BB file (standard output)
    outputBinding:
      glob: combined.bb
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: combined.bb
