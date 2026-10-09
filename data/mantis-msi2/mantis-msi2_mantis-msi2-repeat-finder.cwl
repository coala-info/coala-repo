cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis-msi2-repeat-finder
label: mantis-msi2_mantis-msi2-repeat-finder
doc: 'RepeatFinder: find microsatellite loci in a FASTA file and write them as a BED-like
  file for mantis-msi2.


  Tool homepage: https://github.com/nh13/MANTIS2/'
inputs:
  - id: min_span
    type:
      - 'null'
      - int
    doc: 'minimum number of bases a repeat region must span to be called a microsatellite.
      Default: 10'
    inputBinding:
      position: 1
      prefix: -m
  - id: max_span
    type:
      - 'null'
      - int
    doc: 'maximum number of bases a repeat region must span to be called a microsatellite.
      Default: 100'
    inputBinding:
      position: 1
      prefix: -M
  - id: min_repeats
    type:
      - 'null'
      - int
    doc: 'minimum number of repeats for a microsatellite to be called. Default: 3'
    inputBinding:
      position: 1
      prefix: -r
  - id: min_kmer_length
    type:
      - 'null'
      - int
    doc: 'minimum k-mer length. Default: 1'
    inputBinding:
      position: 1
      prefix: -l
  - id: max_kmer_length
    type:
      - 'null'
      - int
    doc: 'maximum k-mer length. Default: 5'
    inputBinding:
      position: 1
      prefix: -L
  - id: input_fasta
    type: File
    doc: input FASTA file
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: output microsatellites file
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: microsatellites
    type: File
    doc: Microsatellite loci
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis-msi2:2.0.0--h9948957_3
stdout: mantis-msi2_mantis-msi2-repeat-finder.out
