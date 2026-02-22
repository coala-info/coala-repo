cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_modern
label: art_modern
doc: "ART is a set of simulation tools to generate synthetic next-generation sequencing
  reads. (Note: The provided text is a system error log and does not contain help
  documentation; arguments below are based on the tool name hint and standard ART
  suite parameters).\n\nTool homepage: https://github.com/YU-Zhejian/art_modern"
inputs:
  - id: fold_coverage
    type: float
    doc: the fold of coverage of the simulation
    inputBinding:
      position: 101
      prefix: --fcov
  - id: fragment_std_dev
    type:
      - 'null'
      - float
    doc: the standard deviation of DNA fragment size for paired-end simulations
    inputBinding:
      position: 101
      prefix: --std
  - id: input_reference
    type: File
    doc: the name of the file containing the reference sequence
    inputBinding:
      position: 101
      prefix: --in
  - id: mean_fragment_length
    type:
      - 'null'
      - float
    doc: the mean size of DNA fragments for paired-end simulations
    inputBinding:
      position: 101
      prefix: --mflen
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: generate alignment file in SAM format
    inputBinding:
      position: 101
      prefix: --sam
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet mode (do not print messages)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_length
    type: int
    doc: the length of reads to be simulated
    inputBinding:
      position: 101
      prefix: --len
  - id: sequencing_system
    type:
      - 'null'
      - string
    doc: the name of the sequencing system (e.g., HS25, MSv3)
    inputBinding:
      position: 101
      prefix: --seqsys
outputs:
  - id: output_prefix
    type: File
    doc: the prefix of output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
