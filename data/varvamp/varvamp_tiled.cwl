cwlVersion: v1.2
class: CommandLineTool
baseCommand: varvamp_tiled
label: varvamp_tiled
doc: "Performs primer design and amplicon tiling for variant calling.\n\nTool homepage:
  https://github.com/jonas-fuchs/varVAMP"
inputs:
  - id: alignment
    type: File
    doc: Input alignment file (e.g., BAM, SAM)
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Directory to save the output files
    inputBinding:
      position: 2
  - id: compatible_primers
    type:
      - 'null'
      - File
    doc: FASTA primer file with which new primers should not form dimers. 
      Sequences >40 nt are ignored. Can significantly increase runtime.
    default: None
    inputBinding:
      position: 103
      prefix: --compatible-primers
  - id: database
    type:
      - 'null'
      - string
    doc: location of the BLAST db
    default: None
    inputBinding:
      position: 103
      prefix: --database
  - id: max_length
    type:
      - 'null'
      - int
    doc: max length of the amplicons
    default: 1500
    inputBinding:
      position: 103
      prefix: --max-length
  - id: n_ambig
    type:
      - 'null'
      - int
    doc: max number of ambiguous characters in a primer
    default: 2
    inputBinding:
      position: 103
      prefix: --n-ambig
  - id: opt_length
    type:
      - 'null'
      - int
    doc: optimal length of the amplicons
    default: 1000
    inputBinding:
      position: 103
      prefix: --opt-length
  - id: overlap
    type:
      - 'null'
      - int
    doc: min overlap of the amplicon inserts
    default: 25
    inputBinding:
      position: 103
      prefix: --overlap
  - id: scheme_name
    type:
      - 'null'
      - string
    doc: name of the scheme
    default: varVAMP
    inputBinding:
      position: 103
      prefix: --name
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: consensus threshold (0-1) - if not set it will be estimated (higher 
      values result in higher specificity at the expense of found primers)
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varvamp:1.3--pyhdfd78af_0
stdout: varvamp_tiled.out
