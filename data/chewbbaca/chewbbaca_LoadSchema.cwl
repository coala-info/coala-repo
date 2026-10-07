cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - LoadSchema
label: chewbbaca_LoadSchema
doc: "Upload a schema to Chewie-NS.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: schema_directory
    type: Directory
    doc: "Path to the directory of the schema to upload."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: species_id
    type: string
    doc: "The integer identifier or name of the species that the schema will be associated to in Chewie-NS."
    inputBinding:
      position: 1
      prefix: --species-id
  - id: schema_name
    type: string
    doc: "A brief and meaningful name that should help understand the type and content of the schema."
    inputBinding:
      position: 1
      prefix: --schema-name
  - id: loci_prefix
    type: string
    doc: "Prefix included in the name of each locus of the schema."
    inputBinding:
      position: 1
      prefix: --loci-prefix
  - id: description_file
    type:
      - 'null'
      - File
    doc: "Path to a text file with a description about the schema (Markdown supported)."
    inputBinding:
      position: 1
      prefix: --description-file
  - id: annotations
    type:
      - 'null'
      - File
    doc: "Path to a TSV file with loci annotations."
    inputBinding:
      position: 1
      prefix: --annotations
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: nomenclature_server
    type:
      - 'null'
      - string
    doc: "The base URL for the Chewie-NS instance (\"main\" = https://chewbbaca.online/, \"tutorial\" = https://tutorial.chewbbaca.online/, \"local\" = http://127.0.0.1:5000/NS/api/, or the IP address of another Chewie-NS instance). (default: main)"
    inputBinding:
      position: 1
      prefix: --nomenclature-server
  - id: continue_up
    type:
      - 'null'
      - boolean
    doc: "Check if the schema upload was interrupted and attempt to continue upload."
    inputBinding:
      position: 1
      prefix: --continue_up
outputs:
  - id: log
    type: stdout
    doc: "Upload log."
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
stdout: chewbbaca_LoadSchema.log
