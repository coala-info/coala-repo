cwlVersion: v1.2
class: CommandLineTool
baseCommand: msamtools_coverage
label: msamtools_coverage
doc: "Produces per-position sequence coverage information for all reference sequences\n\
  in the BAM file. Output is similar to old-style quality files from the Sanger \n\
  sequencing era, with a fasta-style header followed by lines of space-delimited \n\
  numbers.\n\nTool homepage: https://github.com/arumugamlab/msamtools"
inputs:
  - id: input_bamfile
    type: File
    doc: input SAM/BAM file
    inputBinding:
      position: 1
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: 'compress output file using gzip (default: true)'
    inputBinding:
      position: 102
      prefix: --gzip
  - id: input_is_sam
    type:
      - 'null'
      - boolean
    doc: 'input is SAM (default: false)'
    inputBinding:
      position: 102
      prefix: -S
  - id: skip_uncovered
    type:
      - 'null'
      - boolean
    doc: 'do not report coverage for sequences without aligned reads (default: false)'
    inputBinding:
      position: 102
      prefix: --skipuncovered
  - id: summary
    type:
      - 'null'
      - boolean
    doc: 'do not report per-position coverage but report fraction of sequence covered
      (default: false)'
    inputBinding:
      position: 102
      prefix: --summary
  - id: wordsize
    type:
      - 'null'
      - int
    doc: 'number of words (coverage values) per line (default: 17)'
    inputBinding:
      position: 102
      prefix: --wordsize
outputs:
  - id: output_file
    type: File
    doc: name of output file (required)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
