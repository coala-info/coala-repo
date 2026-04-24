cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchlib_append
label: sketchlib_append
doc: "Append new genomes to be sketched to an existing sketch database\n\nTool homepage:
  https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: db
    type: string
    doc: Sketching database basename (so without .skm or .skd)
    inputBinding:
      position: 1
  - id: seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of input FASTA files
    inputBinding:
      position: 2
  - id: concat_fasta
    type:
      - 'null'
      - boolean
    doc: Treat every sequence in an input file as a new sample (aa only)
    inputBinding:
      position: 103
  - id: file_list
    type:
      - 'null'
      - File
    doc: File listing input files (tab separated name, sequences)
    inputBinding:
      position: 103
      prefix: -f
  - id: level
    type:
      - 'null'
      - string
    doc: "aaHash 'level'\n\n          Possible values:\n          - level1: Level1:
      All amino acids are different\n          - level2: Level2: Groups T,S; D,E;
      Q,K,R; V,I,L,M; W,F,Y\n          - level3: Level3: Additionally groups A with
      T,S; N with D,E"
    inputBinding:
      position: 103
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum k-mer count (with reads)
    inputBinding:
      position: 103
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum k-mer quality (with reads)
    inputBinding:
      position: 103
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show any messages
    inputBinding:
      position: 103
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Ignore reverse complement (all contigs are oriented along same strand)
    inputBinding:
      position: 103
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 103
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output filename for the merged sketch
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
