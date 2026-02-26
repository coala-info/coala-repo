cwlVersion: v1.2
class: CommandLineTool
baseCommand: aln2basecnt
label: smallgenomeutilities_aln2basecnt
doc: "Script to extract base counts and coverage information from a single alignment
  file\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: alignment_file
    type: File
    doc: alignment file
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: alphabet to use
    inputBinding:
      position: 102
      prefix: --alphabet
  - id: first_array_base
    type:
      - 'null'
      - string
    doc: "select whether the first position is named \"0\"\n                     \
      \   (standard for python tools such as pysam, older\n                      \
      \  versions of smallgenomeutilities, and the BED format)\n                 \
      \       or \"1\" (standard scientific notation used in most\n              \
      \          tools, and most text formats such as VCF and GFF)"
    inputBinding:
      position: 102
      prefix: --first
  - id: patient_sample
    type:
      - 'null'
      - string
    doc: "Patient/sample identifiers to use in coverage column\n                 \
      \       title instead of 'coverage'"
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: basecnt_tsv
    type:
      - 'null'
      - File
    doc: bases count table output file
    outputBinding:
      glob: $(inputs.basecnt_tsv)
  - id: coverage_tsv
    type:
      - 'null'
      - File
    doc: coverage table output file
    outputBinding:
      glob: $(inputs.coverage_tsv)
  - id: stats
    type:
      - 'null'
      - File
    doc: file to write stats to
    outputBinding:
      glob: $(inputs.stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
