cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/share/gapseq/src/transporter.sh
label: gapseq_find-transport
doc: "Finds transporter proteins in a FASTA file.\n\nTool homepage: https://github.com/jotech/gapseq"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: bit_score_cutoff
    type:
      - 'null'
      - int
    doc: bit score cutoff for local alignment
    default: 50
    inputBinding:
      position: 102
      prefix: -b
  - id: coverage_cutoff
    type:
      - 'null'
      - int
    doc: coverage cutoff for local alignment
    default: 75
    inputBinding:
      position: 102
      prefix: -c
  - id: disable_parallel
    type:
      - 'null'
      - boolean
    doc: do not use parallel
    inputBinding:
      position: 102
      prefix: -k
  - id: genome_mode
    type:
      - 'null'
      - string
    doc: Input genome mode. Either 'nucl' or 'prot'
    default: auto
    inputBinding:
      position: 102
      prefix: -M
  - id: identity_cutoff
    type:
      - 'null'
      - int
    doc: identity cutoff for local alignment
    default: 0
    inputBinding:
      position: 102
      prefix: -i
  - id: include_hits_in_logs
    type:
      - 'null'
      - boolean
    doc: Include sequences of hits in log files
    default: false
    inputBinding:
      position: 102
      prefix: -q
  - id: keyword_metabolite
    type:
      - 'null'
      - string
    doc: only check for this keyword/metabolite
    default: all
    inputBinding:
      position: 102
      prefix: -m
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Path to directory, where output files will be saved
    default: current directory
    inputBinding:
      position: 102
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for sequence alignments. If option is not provided, 
      number of available CPUs will be automatically determined.
    inputBinding:
      position: 102
      prefix: -K
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level, 0 for nothing, 1 for full
    default: 1
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
stdout: gapseq_find-transport.out
