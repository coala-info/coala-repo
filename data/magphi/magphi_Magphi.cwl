cwlVersion: v1.2
class: CommandLineTool
baseCommand: Magphi
label: magphi_Magphi
doc: "Welcome to Magphi! This program will extract sequences and possible\nannotations
  within a set of seed sequences given as input.\n\nTool homepage: https://github.com/milnus/Magphi"
inputs:
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check dependencies for Magphi and exit
    inputBinding:
      position: 101
      prefix: --check
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'Give max number of CPUs [default: 1]'
    inputBinding:
      position: 101
      prefix: --cpu
  - id: include_seeds
    type:
      - 'null'
      - boolean
    doc: "Argument to include the seeds in the\nsequence/annotations extracted [default:
      seeds are\nremoved]"
    inputBinding:
      position: 101
      prefix: --include_seeds
  - id: input_genomes
    type:
      type: array
      items: File
    doc: "Give the fasta or gff3 files. (gff3 files should\ncontain the genome fasta
      sequence)"
    inputBinding:
      position: 101
      prefix: --input_genomes
  - id: input_seeds
    type: File
    doc: "Give the multi fasta containing the seed sequences to\nbe used for extracting
      sequnces"
    inputBinding:
      position: 101
      prefix: --input_seeds
  - id: log
    type:
      - 'null'
      - boolean
    doc: Record program progress in for debugging purpose
    inputBinding:
      position: 101
      prefix: --log
  - id: max_seed_distance
    type:
      - 'null'
      - int
    doc: "The maximum distance with which seeds will be merged.\nThis can often be
      set a bit higher than an expected\nsize of a region If no maximum distance is
      wanted then\nset to 0 [default: 50,000bp]"
    inputBinding:
      position: 101
      prefix: --max_seed_distance
  - id: no_sequences
    type:
      - 'null'
      - boolean
    doc: "Argument to not print outputs related to annotations\nor sequences found
      between seeds [default: sequences\nare printed]"
    inputBinding:
      position: 101
      prefix: --no_sequences
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'Give path to output folder [default: current folder]'
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: print_breaks
    type:
      - 'null'
      - boolean
    doc: "Argument to print outputs when seeds are next to\ncontig breaks [default:
      sequences are not printed]"
    inputBinding:
      position: 101
      prefix: --print_breaks
  - id: protein_seed
    type:
      - 'null'
      - boolean
    doc: "to use tblastn instead of blastn when protein seeds\nare supplied - useful
      for hits across diverse genomes"
    inputBinding:
      position: 101
      prefix: --protein_seed
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only print warnings
    inputBinding:
      position: 101
      prefix: --quiet
  - id: stop_orientation
    type:
      - 'null'
      - boolean
    doc: "Argument to NOT reorient output sequences and\nannotations by first seed
      in pair (Only for connected\nseed not contig breaks) [default: sequences and\n\
      annotations are oriented]"
    inputBinding:
      position: 101
      prefix: --stop_orientation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magphi:2.0.2--pyhdfd78af_0
stdout: magphi_Magphi.out
