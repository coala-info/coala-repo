cwlVersion: v1.2
class: CommandLineTool
baseCommand: simuG.pl
label: simug
doc: "simuG: a general-purpose genome simulator for simulating various types of genomic
  variants.\n\nTool homepage: https://github.com/yjx1217/simuG"
inputs:
  - id: del_count
    type:
      - 'null'
      - int
    doc: Number of deletions to simulate
    inputBinding:
      position: 101
      prefix: -del_count
  - id: indel_count
    type:
      - 'null'
      - int
    doc: Number of indels to simulate
    inputBinding:
      position: 101
      prefix: -indel_count
  - id: ins_count
    type:
      - 'null'
      - int
    doc: Number of insertions to simulate
    inputBinding:
      position: 101
      prefix: -ins_count
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of output files
    inputBinding:
      position: 101
      prefix: -prefix
  - id: reference_genome
    type: File
    doc: Reference genome file (FASTA format)
    inputBinding:
      position: 101
      prefix: -ref
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for simulation reproducibility
    inputBinding:
      position: 101
      prefix: -seed
  - id: snp_count
    type:
      - 'null'
      - int
    doc: Number of SNPs to simulate
    inputBinding:
      position: 101
      prefix: -snp_count
  - id: titv_ratio
    type:
      - 'null'
      - float
    doc: Transition/Transversion ratio
    inputBinding:
      position: 101
      prefix: -titv_ratio
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simug:1.0.1--hdfd78af_0
