cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_illumina
label: art_less
doc: "A simulation tool to generate synthetic Illumina reads\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: fold_coverage
    type: float
    doc: the fold of read coverage to be simulated
    inputBinding:
      position: 101
      prefix: --fcov
  - id: input_file
    type: File
    doc: the reference factors file (DNA sequence in FASTA format)
    inputBinding:
      position: 101
      prefix: --in
  - id: mean_fragment_size
    type:
      - 'null'
      - float
    doc: the mean size of DNA fragments for paired-end simulations
    inputBinding:
      position: 101
      prefix: --mflen
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: generate paired-end reads
    inputBinding:
      position: 101
      prefix: --paired
  - id: random_seed
    type:
      - 'null'
      - int
    doc: the seed for random number generator
    inputBinding:
      position: 101
      prefix: --rndSeed
  - id: read_length
    type: int
    doc: the length of reads to be simulated
    inputBinding:
      position: 101
      prefix: --len
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: generate SAM alignment file
    inputBinding:
      position: 101
      prefix: --samout
  - id: sequencing_system
    type:
      - 'null'
      - string
    doc: the name of Illumina sequencing system of the built-in profile (e.g. HS25,
      MSv3)
    inputBinding:
      position: 101
      prefix: -ss
  - id: std_fragment_size
    type:
      - 'null'
      - float
    doc: the standard deviation of DNA fragment size for paired-end simulations
    inputBinding:
      position: 101
      prefix: --std
outputs:
  - id: output_prefix
    type: File
    doc: the prefix of output read data file
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
