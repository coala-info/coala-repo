cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-pubmlst-setup
label: bactopia_pubmlst_setup
doc: "One-time setup for interacting with the PubMLST API\n\nTool homepage: https://github.com/bactopia/bactopia"
inputs:
  - id: client_id
    type: string
    doc: The client ID for the site
    inputBinding:
      position: 1
      prefix: --client-id
  - id: client_secret
    type: string
    doc: The client secret for the site
    inputBinding:
      position: 1
      prefix: --client-secret
  - id: site
    type:
      - 'null'
      - string
    doc: 'The site to set up, pubmlst or pasteur [default: pubmlst]'
    inputBinding:
      position: 1
      prefix: --site
  - id: database
    type:
      - 'null'
      - string
    doc: 'The organism database to interact with for setup. Note: the default is available
      from both PubMLST and Pasteur [default: pubmlst_yersinia_seqdef]'
    inputBinding:
      position: 1
      prefix: --database
  - id: save_dir
    type: string
    doc: The directory to save the token
    inputBinding:
      position: 1
      prefix: --save-dir
    default: pubmlst-token
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing token files.
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug related text.
    inputBinding:
      position: 1
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed.
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: token_dir
    type: Directory
    doc: Directory with the saved PubMLST/Pasteur token files
    outputBinding:
      glob: $(inputs.save_dir)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
