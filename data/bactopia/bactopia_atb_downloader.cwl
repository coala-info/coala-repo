cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-atb-downloader
label: bactopia_atb_downloader
doc: "Download All-the-Bacteria assemblies based on input query\n\nTool homepage:\
  \ https://github.com/bactopia/bactopia"
inputs:
  - id: query
    type: string
    doc: The species name, taxid, accession to query and download
    inputBinding:
      position: 1
      prefix: --query
  - id: outdir
    type: string
    doc: Directory to download ATB assemblies to
    inputBinding:
      position: 1
      prefix: --outdir
    default: atb-assemblies
  - id: atb_file_list_url
    type:
      - 'null'
      - string
    doc: 'The URL to the ATB file list [default: https://osf.io/download/4yv85/]'
    inputBinding:
      position: 1
      prefix: --atb-file-list-url
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not download any files, just show what would be downloaded
    inputBinding:
      position: 1
      prefix: --dry-run
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show download progress bar
    inputBinding:
      position: 1
      prefix: --progress
  - id: cpus
    type:
      - 'null'
      - int
    doc: The total number of cpus to use for downloading and compressing
    inputBinding:
      position: 1
      prefix: --cpus
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Do not compress the downloaded files
    inputBinding:
      position: 1
      prefix: --uncompressed
  - id: remove_archives
    type:
      - 'null'
      - boolean
    doc: Remove the downloaded tar.xz archives after extracting samples
    inputBinding:
      position: 1
      prefix: --remove-archives
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: The API key to use for the NCBI API
    inputBinding:
      position: 1
      prefix: --ncbi-api-key
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: The size of the chunks to split the list into
    inputBinding:
      position: 1
      prefix: --chunk-size
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the ATB file list and the downloaded assemblies (one folder
      per species)
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
