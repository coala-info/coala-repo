cwlVersion: v1.2
class: CommandLineTool
baseCommand: art_illumina
label: art_modern-openmpi
doc: "A simulation tool to generate synthetic Illumina next-generation sequencing
  reads.\n\nTool homepage: https://github.com/YU-Zhejian/art_modern"
inputs:
  - id: fold_coverage
    type:
      - 'null'
      - float
    doc: The fold of read coverage to be simulated
    inputBinding:
      position: 101
      prefix: --fcov
  - id: input_file
    type: File
    doc: The name of the input DNA reference (fasta format)
    inputBinding:
      position: 101
      prefix: --in
  - id: mean_frag_len
    type:
      - 'null'
      - float
    doc: The mean size of DNA fragments for paired-end simulations
    inputBinding:
      position: 101
      prefix: --mflen
  - id: no_aln
    type:
      - 'null'
      - boolean
    doc: Do not output ALN alignment file
    inputBinding:
      position: 101
      prefix: --noALN
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Generate paired-end reads
    inputBinding:
      position: 101
      prefix: --paired
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not report the simulation progress
    inputBinding:
      position: 101
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - int
    doc: The seed for random number generator
    inputBinding:
      position: 101
      prefix: --rndSeed
  - id: read_count
    type:
      - 'null'
      - int
    doc: Number of reads to be simulated (alternative to fold coverage)
    inputBinding:
      position: 101
      prefix: --rcount
  - id: read_length
    type: int
    doc: The length of reads to be simulated
    inputBinding:
      position: 101
      prefix: --len
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: Generate SAM alignment file
    inputBinding:
      position: 101
      prefix: --samout
  - id: sequencing_system
    type: string
    doc: The name of Illumina sequencing system of the built-in profile used for
      simulation (e.g., HS20, HS25, HSXn, FS10)
    inputBinding:
      position: 101
      prefix: --seqSys
  - id: std_dev
    type:
      - 'null'
      - float
    doc: The standard deviation of DNA fragment size for paired-end simulations
    inputBinding:
      position: 101
      prefix: --sdev
outputs:
  - id: output_prefix
    type: File
    doc: The prefix of output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
