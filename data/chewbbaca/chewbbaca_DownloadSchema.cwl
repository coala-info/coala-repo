cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - DownloadSchema
label: chewbbaca_DownloadSchema
doc: "Download a schema from Chewie-NS.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: species_id
    type: string
    doc: "The integer identifier or name of the species that the schema is associated to in Chewie-NS."
    inputBinding:
      position: 1
      prefix: --species-id
  - id: schema_id
    type: string
    doc: "The URI, integer identifier or name of the schema to download from Chewie-NS."
    inputBinding:
      position: 1
      prefix: --schema-id
  - id: download_folder
    type: string
    doc: "Output folder to which the schema will be saved."
    default: "downloaded_schema"
    inputBinding:
      position: 1
      prefix: --download-folder
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
  - id: blast_path
    type:
      - 'null'
      - Directory
    doc: "Path to the directory that contains the BLAST executables."
    inputBinding:
      position: 1
      prefix: --blast-path
  - id: date
    type:
      - 'null'
      - string
    doc: "Download schema with state from specified date, in the format \"Y-m-dTH:M:S\"."
    inputBinding:
      position: 1
      prefix: --date
  - id: latest
    type:
      - 'null'
      - boolean
    doc: "If the compressed version that is available is not the latest, downloads all loci FASTA files and constructs schema locally."
    inputBinding:
      position: 1
      prefix: --latest
outputs:
  - id: schema_dir
    type: Directory
    doc: "Downloaded schema folder."
    outputBinding:
      glob: $(inputs.download_folder)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
