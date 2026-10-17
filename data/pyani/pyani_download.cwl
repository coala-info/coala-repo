cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani
  - download
label: pyani_download
doc: "Download genomes from NCBI by taxon ID.\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs:
  - id: outdir
    type: string
    doc: "output directory"
    inputBinding:
      position: 1
      prefix: -o
  - id: taxon
    type: string
    doc: "NCBI taxonomy IDs (required, comma-separated list)"
    inputBinding:
      position: 1
      prefix: -t
  - id: email
    type: string
    doc: "Email associated with NCBI queries (required)"
    inputBinding:
      position: 1
      prefix: --email
  - id: logfile
    type:
      - 'null'
      - string
    doc: "logfile location"
    inputBinding:
      position: 10
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "report verbose progress to log"
    inputBinding:
      position: 10
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "report debug messages to log"
    inputBinding:
      position: 10
      prefix: --debug
  - id: disable_tqdm
    type:
      - 'null'
      - boolean
    doc: "Turn off tqdm progress bar"
    inputBinding:
      position: 10
      prefix: --disable_tqdm
  - id: api_key
    type:
      - 'null'
      - File
    doc: "Path to NCBI Entrez API key file (default: ~/.ncbi/api_key)"
    inputBinding:
      position: 10
      prefix: --api_key
  - id: retries
    type:
      - 'null'
      - int
    doc: "Number of Entrez retry attempts per request (default: 20)"
    inputBinding:
      position: 10
      prefix: --retries
  - id: batchsize
    type:
      - 'null'
      - int
    doc: "Entrez record return batch size (default: 10000)"
    inputBinding:
      position: 10
      prefix: --batchsize
  - id: timeout
    type:
      - 'null'
      - int
    doc: "Timeout for URL connection (s) (default: 10)"
    inputBinding:
      position: 10
      prefix: --timeout
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Allow download to existing directory"
    inputBinding:
      position: 10
      prefix: -f
  - id: noclobber
    type:
      - 'null'
      - boolean
    doc: "Don't replace existing files"
    inputBinding:
      position: 10
      prefix: --noclobber
  - id: labelfname
    type:
      - 'null'
      - string
    doc: "Filename for labels file (default: labels.txt)"
    inputBinding:
      position: 10
      prefix: --labels
  - id: classfname
    type:
      - 'null'
      - string
    doc: "Filename for classes file (default: classes.txt)"
    inputBinding:
      position: 10
      prefix: --classes
  - id: kraken
    type:
      - 'null'
      - boolean
    doc: "Modify downloaded sequence ID for Kraken"
    inputBinding:
      position: 10
      prefix: --kraken
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Dry run only, do not download or overwrite."
    inputBinding:
      position: 10
      prefix: --dry-run
outputs:
  - id: output_dir
    type: Directory
    doc: Downloaded genomes with labels and classes files
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
