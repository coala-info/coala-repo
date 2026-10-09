cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktUpdateTaxonomy.sh
label: krona_ktUpdateTaxonomy.sh
doc: "Update the Krona taxonomy database.\n\nTool homepage: https://github.com/marbl/Krona"
inputs:
  - id: custom_dir
    type:
      - 'null'
      - string
    doc: Taxonomy will be built in this directory instead of the directory 
      specified during installation. This custom directory can be referred to 
      with -tax in import scripts.
    inputBinding:
      position: 1
  - id: only_build
    type:
      - 'null'
      - boolean
    doc: Assume source files exist; do not fetch.
    inputBinding:
      position: 102
      prefix: --only-build
  - id: only_fetch
    type:
      - 'null'
      - boolean
    doc: Only download source files; do not build.
    inputBinding:
      position: 102
      prefix: --only-fetch
  - id: accessions
    type:
      - 'null'
      - boolean
    doc: Also build the accession-to-taxonomy ID mapping files.
    inputBinding:
      position: 102
      prefix: --accessions
  - id: preserve
    type:
      - 'null'
      - boolean
    doc: Do not remove source files after build.
    inputBinding:
      position: 102
      prefix: --preserve
outputs:
  - id: taxonomy_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the built taxonomy
    outputBinding:
      glob: $(inputs.custom_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktUpdateTaxonomy.sh.out
