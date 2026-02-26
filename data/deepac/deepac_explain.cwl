cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac_explain
label: deepac_explain
doc: "DeePaC explain subcommands. See command --help for details.\n\nTool homepage:
  https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: subcommand
    type: string
    doc: DeePaC explain subcommands. See command --help for details.
    inputBinding:
      position: 1
  - id: fa2transfac
    type:
      - 'null'
      - boolean
    doc: Calculate transfac from fasta files.
    inputBinding:
      position: 102
  - id: fcontribs
    type:
      - 'null'
      - boolean
    doc: Get DeepLIFT/SHAP filter contribution scores.
    inputBinding:
      position: 102
  - id: franking
    type:
      - 'null'
      - boolean
    doc: Generate filter rankings.
    inputBinding:
      position: 102
  - id: maxact
    type:
      - 'null'
      - boolean
    doc: Get DeepBind-like max-activation scores.
    inputBinding:
      position: 102
  - id: mcompare
    type:
      - 'null'
      - boolean
    doc: Compare motifs.
    inputBinding:
      position: 102
  - id: transfac2IC
    type:
      - 'null'
      - boolean
    doc: Calculate information content from transfac files.
    inputBinding:
      position: 102
  - id: weblogos
    type:
      - 'null'
      - boolean
    doc: Get sequence logos.
    inputBinding:
      position: 102
  - id: xlogos
    type:
      - 'null'
      - boolean
    doc: Get extended sequence logos.
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_explain.out
