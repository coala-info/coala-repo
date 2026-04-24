cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfSampleCompare.pl
label: vcfsamplecompare_vcfSampleCompare.pl
doc: "This script answers the question \"What's different?\" between my samples. It
  does this by sorting and filtering the variant records of a VCF file (containing
  data for 2 or more samples) based on the differences in the variant data between
  samples. The end result is a file containing the variants that show the biggest
  difference at the top and variants with no or little difference at the bottom or
  filtered out. Think of it as the genetic variant analog of a differential gene expression
  analysis. It solves the problem of finding \"what's different\" (for example) between
  wildtype and mutant samples.\n\nTool homepage: https://github.com/hepcat72/vcfSampleCompare"
inputs:
  - id: input_vcf
    type: File
    doc: A VCF file is a plain text, tab-delimited file.
    inputBinding:
      position: 1
  - id: extended_help
    type:
      - 'null'
      - boolean
    doc: Display extended help information.
    inputBinding:
      position: 102
      prefix: --extended
  - id: filter_threshold
    type:
      - 'null'
      - float
    doc: Filter variants below this threshold for the BEST_GT_SCORE, 
      BEST_OR_SCORE, and BEST_DP_SCORE. Default is 0.0.
    inputBinding:
      position: 102
      prefix: -f
  - id: gap_measure
    type:
      - 'null'
      - string
    doc: Method to measure the gap between observation ratios. Can be 'mean' or 
      'edge'.
    inputBinding:
      position: 102
      prefix: -g
  - id: header
    type:
      - 'null'
      - boolean
    doc: Include the run info header in the output. This flag refers to the run 
      info header of this script, not the VCF file's header.
    inputBinding:
      position: 102
  - id: min_depth_score
    type:
      - 'null'
      - float
    doc: Minimum depth score to consider a variant. See the usage for -x and -l 
      to see how the score is calculated.
    inputBinding:
      position: 102
      prefix: -x
  - id: min_depth_threshold
    type:
      - 'null'
      - int
    doc: Minimum read depth threshold for calculating the depth score. See the 
      usage for -x and -l to see how the score is calculated.
    inputBinding:
      position: 102
      prefix: -l
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not include the run info header in the output. This flag refers to 
      the run info header of this script, not the VCF file's header.
    inputBinding:
      position: 102
  - id: sample_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: Pre-define sample groups. If not specified, the pair of sample groups 
      leading to the greatest difference is greedily generated.
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file is the same format as the input VCF files, except 
      sorted differently and possibly filtered.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfsamplecompare:2.013--pl526_0
