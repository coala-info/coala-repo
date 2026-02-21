cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigToBigWig
label: perl-bio-bigfile_wigToBigWig
doc: "Convert a wig file to bigWig format.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::BigFile"
inputs:
  - id: input_wig
    type: File
    doc: Input wig file
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'Chromosome sizes file (two columns: <chromName> <size>)'
    inputBinding:
      position: 2
  - id: clip
    type:
      - 'null'
      - boolean
    doc: If set, clip items that are off the end of a chromosome
    inputBinding:
      position: 103
      prefix: -clip
  - id: fixed_summaries
    type:
      - 'null'
      - boolean
    doc: If set, use a fixed number of summary levels
    inputBinding:
      position: 103
      prefix: -fixedSummaries
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression
    inputBinding:
      position: 103
      prefix: -unc
outputs:
  - id: output_bw
    type: File
    doc: Output bigWig file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
