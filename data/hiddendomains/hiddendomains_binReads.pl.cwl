cwlVersion: v1.2
class: CommandLineTool
baseCommand: binReads.pl
label: hiddendomains_binReads.pl
doc: "Binning reads.\n\nTool homepage: http://hiddendomains.sourceforge.net/"
inputs:
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: PROGRAM_ARG1 ...
    inputBinding:
      position: 1
  - id: bin_width
    type:
      - 'null'
      - int
    doc: 'binWidth: 1000 (change with -b option)'
    default: 1000
    inputBinding:
      position: 102
      prefix: -b
  - id: ignore_header
    type:
      - 'null'
      - boolean
    doc: 'Boolean (without arguments): -h -m -M -H -B'
    inputBinding:
      position: 102
      prefix: -H
  - id: min_qual_score
    type:
      - 'null'
      - int
    doc: 'minQualScore: 30 (change with -q option)'
    default: 30
    inputBinding:
      position: 102
      prefix: -q
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: 'Boolean (without arguments): -h -m -M -H -B'
    inputBinding:
      position: 102
      prefix: -B
  - id: use_custom_chromosomes
    type:
      - 'null'
      - boolean
    doc: 'Default: Using mouse chromosomes. Change this with -m, -h or -c'
    inputBinding:
      position: 102
      prefix: -c
  - id: use_human_chromosomes
    type:
      - 'null'
      - boolean
    doc: 'Default: Using mouse chromosomes. Change this with -m, -h or -c'
    inputBinding:
      position: 102
      prefix: -h
  - id: use_mouse_chromosomes
    type:
      - 'null'
      - boolean
    doc: 'Default: Using mouse chromosomes. Change this with -m, -h or -c'
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiddendomains:3.1--pl526r36_0
stdout: hiddendomains_binReads.pl.out
