cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - motif_disc
label: cressent_motif_disc
doc: "Discover de novo motifs using MEME.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: nmotifs
    type:
      - 'null'
      - int
    doc: "Number of motifs to find (Default = 1)"
    inputBinding:
      position: 101
      prefix: -nmotifs
  - id: minw
    type:
      - 'null'
      - int
    doc: "Minimum motif width (Default = 5)"
    inputBinding:
      position: 101
      prefix: -minw
  - id: maxw
    type:
      - 'null'
      - int
    doc: "Maximum motif width (Default = 10)"
    inputBinding:
      position: 101
      prefix: -maxw
  - id: meme_extra
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --meme_extra
    doc: "Additional MEME arguments (list format)"
    inputBinding:
      position: 101
  - id: scanprosite
    type:
      - 'null'
      - boolean
    doc: "Run ScanProsite (needs network access to the ExPASy ScanProsite service)"
    inputBinding:
      position: 101
      prefix: --scanprosite
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
