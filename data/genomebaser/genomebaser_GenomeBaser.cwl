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
    type: string
    doc: Location to store the output database (a directory created in the 
      working directory)
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
  - id: out_database
    type: Directory
    doc: Database directory holding the downloaded genomes
    outputBinding:
      glob: $(inputs.out_database_location)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_database_location)
        entry: '${return {"class": "Directory", "basename": inputs.out_database_location, "listing": []};}'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomebaser:0.1.2--py27_1
stdout: genomebaser_GenomeBaser.out
