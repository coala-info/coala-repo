cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_to_random_subset
label: fastaq_to_random_subset
doc: "Takes a random subset of reads from a sequence file and optionally the corresponding
  read from a mates file. Output is interleaved if mates file given\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: percent
    type: float
    doc: Per cent probability of keeping any given read (pair) in [0,100]
    inputBinding:
      position: 2
  - id: mate_file
    type:
      - 'null'
      - File
    doc: Name of mates file
    inputBinding:
      position: 103
      prefix: --mate_file
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator. If not given, python's default is 
      used
    inputBinding:
      position: 103
      prefix: --seed
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
