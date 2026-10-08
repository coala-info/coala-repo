cwlVersion: v1.2
class: CommandLineTool
baseCommand: confindr_database_setup
label: confindr_database_setup
doc: "Download the ConFindr databases (cgMLST-derived databases for Escherichia, Salmonella
  and Listeria, and the RefSeq mash sketch; with an rMLST consumer secret file also the
  rMLST database, which needs an interactive browser authorization).\n\nTool homepage:
  https://github.com/lowandrew/ConFindr"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: output_folder
    type: string
    doc: Path to download databases to - if folder does not exist, will be created.
      If folder does exist, will be deleted and updated sequences downloaded.
    default: confindr_db
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: secret_file
    type:
      - 'null'
      - File
    doc: Path to consumer secret file for rMLST database (the rMLST download then asks
      for an oauth_verifier from a browser on stdin).
    inputBinding:
      position: 101
      prefix: --secret_file
  - id: index_databases
    type:
      - 'null'
      - boolean
    doc: Enable this option if you are installing the databases to a drive that will
      be read-only after the installation. The script will create and index all the
      necessary genus-specific database files. Note that this is very slow for the rMLST
      database.
    inputBinding:
      position: 101
      prefix: --index_databases
  - id: unverified
    type:
      - 'null'
      - boolean
    doc: Enable this option if you plan on running ConFindr behind a firewall and/or
      have a self- signed certificate. Adds 'verify=False' during session requests.
    inputBinding:
      position: 101
      prefix: --unverified
outputs:
  - id: database_directory
    type: Directory
    doc: folder with the downloaded ConFindr databases
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/confindr:0.8.2--pyhdfd78af_0
