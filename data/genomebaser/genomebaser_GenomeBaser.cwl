cwlVersion: v1.2
class: CommandLineTool
baseCommand: GenomeBaser
label: genomebaser_GenomeBaser
doc: "GenomeBaser is tool to manage complete (bacterial) genomes from the NCBI.\n\n\
  Tool homepage: https://github.com/mscook/GenomeBaser"
inputs:
  - id: genus
    type: string
    doc: Genus of the organism
    inputBinding:
      position: 1
  - id: species
    type: string
    doc: Species of the organism
    inputBinding:
      position: 2
  - id: out_database_location
    type: Directory
    doc: Location to store the output database
    inputBinding:
      position: 3
  - id: check_deps
    type:
      - 'null'
      - boolean
    doc: Check that non-python dependencies exist
    inputBinding:
      position: 104
      prefix: --check_deps
  - id: no_check_deps
    type:
      - 'null'
      - boolean
    doc: Do not check that non-python dependencies exist
    inputBinding:
      position: 104
      prefix: --no-check_deps
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomebaser:0.1.2--py27_1
stdout: genomebaser_GenomeBaser.out
