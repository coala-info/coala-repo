cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - juicer
  - post
label: yahs_juicer_post
doc: "Generate assembly files after Juicebox curation\n\nTool homepage: https://github.com/c-zhou/yahs"
inputs:
  - id: output_prefix
    type: string
    doc: output file prefix (required for scaffolds FASTA output)
    inputBinding:
      position: 1
      prefix: -o
  - id: seq_ctype
    type:
      - 'null'
      - string
    doc: AGP output sequence component type [W]
    inputBinding:
      position: 2
      prefix: --seq-ctype
  - id: gap_ctype
    type:
      - 'null'
      - string
    doc: AGP output gap component type [U]
    inputBinding:
      position: 3
      prefix: --gap-ctype
  - id: gap_link
    type:
      - 'null'
      - string
    doc: AGP output gap linkage evidence [proximity_ligation]
    inputBinding:
      position: 4
      prefix: --gap-link
  - id: gap_size
    type:
      - 'null'
      - int
    doc: AGP output gap size between sequence component [100]
    inputBinding:
      position: 5
      prefix: --gap-size
  - id: review_assembly
    type: File
    doc: Juicebox review.assembly file
    inputBinding:
      position: 6
  - id: liftover_agp
    type: File
    doc: liftover AGP file (from juicer pre)
    inputBinding:
      position: 7
  - id: contigs_fa
    type: File
    doc: contigs FASTA file (with its .fai index)
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 8
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (.FINAL.agp and .FINAL.fa)
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yahs:1.2.2--he4a0461_0
