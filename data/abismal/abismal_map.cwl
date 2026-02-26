cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - abismal
  - map
label: abismal_map
doc: "map bisulfite converted reads (v3.3.0)\n\nTool homepage: https://github.com/smithlabcode/abismal"
inputs:
  - id: reads_fq1
    type: File
    doc: First read file (FastQ)
    inputBinding:
      position: 1
  - id: reads_fq2
    type:
      - 'null'
      - File
    doc: Second read file (FastQ) for paired-end mode
    inputBinding:
      position: 2
  - id: a_rich
    type:
      - 'null'
      - boolean
    doc: indicates reads are a-rich (se mode)
    inputBinding:
      position: 103
      prefix: -a-rich
  - id: ambig
    type:
      - 'null'
      - boolean
    doc: report a posn for ambiguous mappers
    inputBinding:
      position: 103
      prefix: -ambig
  - id: bam
    type:
      - 'null'
      - boolean
    doc: output BAM format
    inputBinding:
      position: 103
      prefix: -bam
  - id: genome
    type:
      - 'null'
      - File
    doc: genome file (FASTA)
    inputBinding:
      position: 103
      prefix: -genome
  - id: index
    type:
      - 'null'
      - File
    doc: index file
    inputBinding:
      position: 103
      prefix: -index
  - id: max_candidates
    type:
      - 'null'
      - int
    doc: max candidates per seed (0 = use index estimate)
    default: 0
    inputBinding:
      position: 103
      prefix: -max-candidates
  - id: max_distance
    type:
      - 'null'
      - float
    doc: max fractional edit distance
    default: 0.1
    inputBinding:
      position: 103
      prefix: -max-distance
  - id: max_frag
    type:
      - 'null'
      - int
    doc: max fragment size (pe mode)
    default: 3000
    inputBinding:
      position: 103
      prefix: -max-frag
  - id: min_frag
    type:
      - 'null'
      - int
    doc: min fragment size (pe mode)
    default: 32
    inputBinding:
      position: 103
      prefix: -min-frag
  - id: pbat
    type:
      - 'null'
      - boolean
    doc: input follows the PBAT protocol
    inputBinding:
      position: 103
      prefix: -pbat
  - id: random_pbat
    type:
      - 'null'
      - boolean
    doc: input follows random PBAT protocol
    inputBinding:
      position: 103
      prefix: -random-pbat
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 103
      prefix: -verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile)
  - id: stats
    type:
      - 'null'
      - File
    doc: map statistics file (YAML)
    outputBinding:
      glob: $(inputs.stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abismal:3.3.0--h077b44d_0
