cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapseq
  - find-transport
label: gapseq_find-transport
doc: "Search for transporters based on homology.

Tool homepage: https://github.com/jotech/gapseq"
inputs:
  - id: bit_score_cutoff
    type:
      - 'null'
      - int
    doc: "Bit score cutoff for local alignment (default: 50)"
    inputBinding:
      position: 101
      prefix: -b
  - id: identity_cutoff
    type:
      - 'null'
      - int
    doc: "Identity cutoff for local alignment (default: 0)"
    inputBinding:
      position: 101
      prefix: -i
  - id: coverage_cutoff
    type:
      - 'null'
      - int
    doc: "Coverage cutoff for local alignment (default: 75)"
    inputBinding:
      position: 101
      prefix: -c
  - id: include_sequences_in_logs
    type:
      - 'null'
      - boolean
    doc: "Include sequences of hits in log files"
    inputBinding:
      position: 101
      prefix: -q
  - id: disable_parallel
    type:
      - 'null'
      - boolean
    doc: "Do not use parallel"
    inputBinding:
      position: 101
      prefix: -k
  - id: keyword_metabolite
    type:
      - 'null'
      - string
    doc: "Only check for this keyword/metabolite (default: all)"
    inputBinding:
      position: 101
      prefix: -m
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Path to directory, where output files will be saved (default: current directory)"
    inputBinding:
      position: 101
      prefix: -f
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: "Verbose level, 0 for nothing, 1 for full (default: 1)"
    inputBinding:
      position: 101
      prefix: -v
  - id: genome_mode
    type:
      - 'null'
      - string
    doc: "Input genome mode. Either nucl or prot (default: auto)"
    inputBinding:
      position: 101
      prefix: -M
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads for sequence alignments (default: number of available CPUs)"
    inputBinding:
      position: 101
      prefix: -K
  - id: genome
    type: File
    doc: "Genome sequence in FASTA format (nucleotide or protein, optionally gzipped)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: transporter_table
    type:
      type: array
      items: File
    doc: "Transporter table written by gapseq find-transport"
    outputBinding:
      glob: "*-Transporter.tbl"
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory when output_dir is given"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ if (inputs.output_dir) { return [{class: "Directory", basename: inputs.output_dir, listing: [], writable: true}]; } else { return []; } }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
stdout: gapseq_find-transport.out
