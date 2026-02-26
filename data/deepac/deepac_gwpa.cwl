cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - gwpa
label: deepac_gwpa
doc: "DeePaC gwpa subcommands. See command --help for details.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: subcommand
    type: string
    doc: DeePaC gwpa subcommands. See command --help for details.
    inputBinding:
      position: 1
  - id: factiv
    type:
      - 'null'
      - type: array
        items: string
    doc: Get filter activations.
    inputBinding:
      position: 2
  - id: fenrichment
    type:
      - 'null'
      - type: array
        items: string
    doc: Run filter enrichment analysis.
    inputBinding:
      position: 3
  - id: fragment
    type:
      - 'null'
      - type: array
        items: string
    doc: Fragment genomes for analysis.
    inputBinding:
      position: 4
  - id: genomemap
    type:
      - 'null'
      - type: array
        items: string
    doc: Generate a genome-wide phenotype potential map.
    inputBinding:
      position: 5
  - id: gff2genome
    type:
      - 'null'
      - type: array
        items: string
    doc: Generate .genome files.
    inputBinding:
      position: 6
  - id: granking
    type:
      - 'null'
      - type: array
        items: string
    doc: Generate gene rankings.
    inputBinding:
      position: 7
  - id: ntcontribs
    type:
      - 'null'
      - type: array
        items: string
    doc: Generate a genome-wide nt contribution map.
    inputBinding:
      position: 8
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_gwpa.out
