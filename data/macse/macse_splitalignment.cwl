cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - splitAlignment
label: macse_splitalignment
doc: "splits one alignment, to extract a subset of sequences and/or sites.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: align
    type: File
    doc: "input FASTA file containing aligned nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -align
  - id: amino_alignment_ON
    type:
      - 'null'
      - boolean
    doc: "use this option if the alignment file contains amino acids and not nucleotides"
    inputBinding:
      position: 102
      prefix: -amino_alignment_ON
  - id: first_site
    type:
      - 'null'
      - int
    doc: "position of the first site to keep (default: 1)"
    inputBinding:
      position: 102
      prefix: -first_site
  - id: keep_FS_OFF
    type:
      - 'null'
      - boolean
    doc: "if this option is set, a site containing only gaps and frameshifts will be removed (as one containing only gaps). By default such sites are kept to preserve the reading frame."
    inputBinding:
      position: 102
      prefix: -keep_FS_OFF
  - id: last_site
    type:
      - 'null'
      - int
    doc: "position of the last site to keep (default: 2147483647)"
    inputBinding:
      position: 102
      prefix: -last_site
  - id: out_others
    type: string
    default: "macse_others.fasta"
    doc: "file that will contain the alignment with the subset of unselected sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_others
  - id: out_subset
    type: string
    default: "macse_subset.fasta"
    doc: "file that will contain the alignment with the subset of selected sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_subset
  - id: restrict
    type:
      - 'null'
      - File
    doc: "file containing names of the sequences chosen to define the borders of the alignment (one sequence name per line, with or without the starting \">\" character). All sites upstream (resp. downstream) the first (resp. last) non-gap codon of those sequences will be trimmed."
    inputBinding:
      position: 102
      prefix: -restrict
  - id: reverse_site_selection_ON
    type:
      - 'null'
      - boolean
    doc: "if this option is set, the sites normally kept will be those that will be removed"
    inputBinding:
      position: 102
      prefix: -reverse_site_selection_ON
  - id: site_intervals
    type:
      - 'null'
      - File
    doc: "file containing the list of site intervals that should be kept, one line per interval (start_position end_position); any of the following separators can be used: space, tabulation, comma, semicolon."
    inputBinding:
      position: 102
      prefix: -site_intervals
  - id: subset
    type:
      - 'null'
      - File
    doc: "file containing names of the sequences to keep in the restricted alignment (one sequence name per line, with or without the starting \">\" character)"
    inputBinding:
      position: 102
      prefix: -subset
outputs:
  - id: out_others_file
    type:
      - 'null'
      - File
    doc: "file that will contain the alignment with the subset of unselected sequences"
    outputBinding:
      glob: $(inputs.out_others)
  - id: out_subset_file
    type:
      - 'null'
      - File
    doc: "file that will contain the alignment with the subset of selected sequences"
    outputBinding:
      glob: $(inputs.out_subset)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
