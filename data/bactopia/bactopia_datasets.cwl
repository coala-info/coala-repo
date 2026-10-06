cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-datasets
label: bactopia_datasets
doc: "Download optional datasets to supplement your analyses with Bactopia\n\nTool\
  \ homepage: https://github.com/bactopia/bactopia"
inputs:
  - id: bactopia_path
    type: Directory
    doc: Directory where Bactopia repository is stored (in this image /usr/local/share/bactopia-3.2.0)
    inputBinding:
      position: 1
      prefix: --bactopia-path
  - id: datasets_cache
    type: string
    doc: Base directory to download datasets to (a subfolder called datasets will
      be created)
    inputBinding:
      position: 1
      prefix: --datasets_cache
    default: bactopia-cache
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing pre-built environments.
    inputBinding:
      position: 1
      prefix: --force
  - id: max_retry
    type:
      - 'null'
      - int
    doc: 'Maximum times to attempt creating Conda environment. (Default: 3)'
    inputBinding:
      position: 1
      prefix: --max_retry
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
  - id: datasets
    type: Directory
    doc: Downloaded datasets (the datasets subfolder of the cache directory)
    outputBinding:
      glob: $(inputs.datasets_cache)/datasets
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
