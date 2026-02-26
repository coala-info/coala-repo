cwlVersion: v1.2
class: CommandLineTool
baseCommand: TE-Aid
label: te-aid_TE-Aid
doc: "TE+Aid is a tool to help the manual curation of transposable elements (TE).
  It requires a TE consensus sequence and a reference genome both in fasta format.\n\
  \nTool homepage: https://github.com/clemgoub/TE-Aid/tree/v{version}"
inputs:
  - id: all_tables
    type:
      - 'null'
      - boolean
    doc: 'same as -t plus write the genomic blastn table. Warning: can be very large
      if your TE is highly repetitive!'
    inputBinding:
      position: 101
      prefix: --all-Tables
  - id: alpha
    type:
      - 'null'
      - float
    doc: 'graphical: transparency value for blastn hit (0-1)'
    default: 0.3
    inputBinding:
      position: 101
      prefix: --alpha
  - id: auto_y
    type:
      - 'null'
      - string
    doc: 'graphical: manual override for y lims (default: TRUE; otherwise: -y NUM)'
    default: 'TRUE'
    inputBinding:
      position: 101
      prefix: --auto-y
  - id: e_value
    type:
      - 'null'
      - float
    doc: 'genome blastn: e-value threshold to keep hit'
    default: '10e-8'
    inputBinding:
      position: 101
      prefix: --e-value
  - id: emboss_dotmatcher
    type:
      - 'null'
      - boolean
    doc: Produce a dotplot with EMBOSS dotmatcher
    inputBinding:
      position: 101
      prefix: --emboss-dotmatcher
  - id: full_length_alpha
    type:
      - 'null'
      - float
    doc: 'graphical: transparency value for full-length blastn hits (0-1)'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --full-length-alpha
  - id: full_length_threshold
    type:
      - 'null'
      - float
    doc: 'genome blastn: min. proportion (hit_size)/(consensus_size) to be considered
      "full length" (0-1)'
    default: 0.9
    inputBinding:
      position: 101
      prefix: --full-length-threshold
  - id: genome
    type: File
    doc: Reference genome (fasta file)
    inputBinding:
      position: 101
      prefix: --genome
  - id: min_orf
    type:
      - 'null'
      - int
    doc: 'getorf: minimum ORF size (in bp)'
    inputBinding:
      position: 101
      prefix: --min-orf
  - id: no_reverse_orfs
    type:
      - 'null'
      - boolean
    doc: "getorf: don't use ORFs in ther reverse complement of your sequence"
    inputBinding:
      position: 101
      prefix: --no-reverse-orfs
  - id: output
    type:
      - 'null'
      - Directory
    doc: output folder
    default: ./
    inputBinding:
      position: 101
      prefix: --output
  - id: query
    type: File
    doc: TE consensus to blast (fasta file)
    inputBinding:
      position: 101
      prefix: --query
  - id: remove_redundant
    type:
      - 'null'
      - boolean
    doc: remove redundant hits from genomic blastn table and a title of the 
      first plot
    inputBinding:
      position: 101
      prefix: --remove-redundant
  - id: tables
    type:
      - 'null'
      - boolean
    doc: write features coordinates in tables (self dot-plot, ORFs and protein 
      hits coordinates)
    inputBinding:
      position: 101
      prefix: --tables
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/te-aid:1.0.0--hdfd78af_0
stdout: te-aid_TE-Aid.out
