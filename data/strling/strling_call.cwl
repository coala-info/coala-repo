cwlVersion: v1.2
class: CommandLineTool
baseCommand: strling call
label: strling_call
doc: "Call STR alleles from BAM files.\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: bam
    type: File
    doc: path to bam file
    inputBinding:
      position: 1
  - id: bin
    type: File
    doc: bin file previously created by `strling extract`
    inputBinding:
      position: 2
  - id: bounds
    type:
      - 'null'
      - File
    doc: STRling -bounds.txt file (usually produced by strling merge) specifying
      additional STR loci to genotype.
    inputBinding:
      position: 103
      prefix: --bounds
  - id: fasta
    type:
      - 'null'
      - File
    doc: path to fasta file
    inputBinding:
      position: 103
      prefix: --fasta
  - id: loci
    type:
      - 'null'
      - File
    doc: 'Annoated bed file specifying additional STR loci to genotype. Format is:
      chr start stop repeatunit [name]'
    inputBinding:
      position: 103
      prefix: --loci
  - id: min_clip
    type:
      - 'null'
      - int
    doc: minimum number of supporting clipped reads for each side of a locus
    inputBinding:
      position: 103
      prefix: --min-clip
  - id: min_clip_total
    type:
      - 'null'
      - int
    doc: minimum total number of supporting clipped reads for a locus
    inputBinding:
      position: 103
      prefix: --min-clip-total
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (does not apply to STR reads)
    inputBinding:
      position: 103
      prefix: --min-mapq
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimum number of supporting reads for a locus to be reported
    inputBinding:
      position: 103
      prefix: --min-support
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix for output files
    inputBinding:
      position: 103
      prefix: --output-prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
stdout: strling_call.out
