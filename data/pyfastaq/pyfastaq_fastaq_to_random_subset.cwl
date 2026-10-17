cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - to_random_subset
label: pyfastaq_fastaq_to_random_subset
doc: "Takes a random subset of reads from a sequence file and optionally the corresponding read from a mates file.  Output is interleaved if mates file given\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: mate_file
    type:
      - 'null'
      - File
    doc: "Name of mates file"
    inputBinding:
      position: 1
      prefix: --mate_file
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator. If not given, python's default is used"
    inputBinding:
      position: 2
      prefix: --seed
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
  - id: percent
    type: float
    doc: "Per cent probability of keeping any given read (pair) in [0,100]"
    inputBinding:
      position: 22
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
