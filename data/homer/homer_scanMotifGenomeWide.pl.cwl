cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanMotifGenomeWide.pl
label: homer_scanMotifGenomeWide.pl
doc: "Scan a genome for instances of one or more motifs (output written to standard output)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: motif_file
    type: File
    doc: 'Motif file (may contain several motifs)'
    inputBinding:
      position: 1
  - id: genome
    type:
      - string
      - File
      - Directory
    doc: 'Genome name, or a custom genome FASTA file or directory of FASTA files'
    inputBinding:
      position: 2
  - id: five_prime
    type:
      - 'null'
      - boolean
    doc: 'report positions centered on the 5'' start of the motif'
    inputBinding:
      position: 103
      prefix: '-5p'
  - id: bed
    type:
      - 'null'
      - boolean
    doc: 'format the output as a BED file, i.e. for UCSC upload'
    inputBinding:
      position: 103
      prefix: '-bed'
  - id: int
    type:
      - 'null'
      - boolean
    doc: 'round motif scores to the nearest integer between 0 and 1000 (use if making a bigBed file)'
    inputBinding:
      position: 103
      prefix: '-int'
  - id: homer1
    type:
      - 'null'
      - boolean
    doc: 'use the original homer'
    inputBinding:
      position: 103
      prefix: '-homer1'
  - id: homer2
    type:
      - 'null'
      - boolean
    doc: 'use homer2 instead of the original homer (default)'
    inputBinding:
      position: 103
      prefix: '-homer2'
  - id: keepAll
    type:
      - 'null'
      - boolean
    doc: 'keep all sites, even ones that overlap (default is to keep one)'
    inputBinding:
      position: 103
      prefix: '-keepAll'
  - id: mask
    type:
      - 'null'
      - boolean
    doc: 'search for motifs in repeat masked sequence'
    inputBinding:
      position: 103
      prefix: '-mask'
  - id: p
    type:
      - 'null'
      - int
    doc: 'number of CPUs to use'
    inputBinding:
      position: 103
      prefix: '-p'
outputs:
  - id: sites
    type: stdout
    doc: 'Motif sites (tab separated, or BED with -bed)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_scanMotifGenomeWide.out
