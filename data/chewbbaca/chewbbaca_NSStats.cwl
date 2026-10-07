cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - NSStats
label: chewbbaca_NSStats
doc: "Retrieve basic information about the species and schemas in Chewie-NS.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: mode
    type: string
    doc: "The process can retrieve the list of species (\"species\" option) in Chewie-NS or the list of schemas for a species (\"schemas\" option)."
    inputBinding:
      position: 1
      prefix: --mode
  - id: species_id
    type:
      - 'null'
      - string
    doc: "The integer identifier of a species in Chewie-NS."
    inputBinding:
      position: 1
      prefix: --species-id
  - id: schema_id
    type:
      - 'null'
      - string
    doc: "The integer identifier of a schema in Chewie-NS."
    inputBinding:
      position: 1
      prefix: --schema-id
  - id: nomenclature_server
    type:
      - 'null'
      - string
    doc: "The base URL for the Chewie-NS instance (\"main\" = https://chewbbaca.online/, \"tutorial\" = https://tutorial.chewbbaca.online/, \"local\" = http://127.0.0.1:5000/NS/api/, or the IP address of another Chewie-NS instance). (default: main)"
    inputBinding:
      position: 1
      prefix: --nomenclature-server
outputs:
  - id: stats
    type: stdout
    doc: "Species or schema statistics."
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
stdout: chewbbaca_NSStats.txt
