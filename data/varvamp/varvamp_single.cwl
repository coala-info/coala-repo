cwlVersion: v1.2
class: CommandLineTool
baseCommand: varvamp_single
label: varvamp_single
doc: "Performs primer design and amplicon prediction for a single input alignment.\n\
  \nTool homepage: https://github.com/jonas-fuchs/varVAMP"
inputs:
  - id: alignment
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 2
  - id: compatible_primers
    type:
      - 'null'
      - File
    doc: FASTA primer file with which new primers should not form dimers. 
      Sequences >40 nt are ignored. Can significantly increase runtime.
    inputBinding:
      position: 103
      prefix: --compatible-primers
  - id: database
    type:
      - 'null'
      - string
    doc: location of the BLAST db
    inputBinding:
      position: 103
      prefix: --database
  - id: max_length
    type:
      - 'null'
      - int
    doc: max length of the amplicons
    inputBinding:
      position: 103
      prefix: --max-length
  - id: n_ambig
    type:
      - 'null'
      - int
    doc: max number of ambiguous characters in a primer
    inputBinding:
      position: 103
      prefix: --n-ambig
  - id: opt_length
    type:
      - 'null'
      - int
    doc: optimal length of the amplicons
    inputBinding:
      position: 103
      prefix: --opt-length
  - id: report_n
    type:
      - 'null'
      - int
    doc: report the top n best hits
    inputBinding:
      position: 103
      prefix: --report-n
  - id: scheme_name
    type:
      - 'null'
      - string
    doc: name of the scheme
    inputBinding:
      position: 103
      prefix: --name
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
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
stdout: varvamp_single.out
