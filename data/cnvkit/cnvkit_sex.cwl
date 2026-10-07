cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - sex
label: cnvkit_sex
doc: "Guess samples' sex from the relative coverage of chromosomes X and Y.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: "Copy number or copy ratio files (*.cnn, *.cnr)."
    inputBinding:
      position: 1
  - id: male_reference
    type:
      - 'null'
      - boolean
    doc: "Assume inputs were normalized to a male reference (i.e. female samples will have +1 log-coverage of chrX; otherwise male samples would have -1 chrX)."
    inputBinding:
      position: 101
      prefix: --male-reference
  - id: output
    type: string
    doc: "Output table file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output table file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
