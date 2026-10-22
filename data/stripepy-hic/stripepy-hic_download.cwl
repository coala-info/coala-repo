cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stripepy
  - download
label: stripepy-hic_download
doc: "Helper command to simplify downloading datasets that can be used to test StripePy (needs network access).\n\nTool homepage: https://github.com/paulsengroup/StripePy"
inputs:
  - id: assembly
    type:
      - 'null'
      - string
    doc: Restrict downloads to the given reference genome assembly (hg38 or mm10)
    inputBinding:
      position: 1
      prefix: --assembly
  - id: name
    type:
      - 'null'
      - string
    doc: Name of the dataset to be downloaded
    inputBinding:
      position: 1
      prefix: --name
  - id: list_only
    type:
      - 'null'
      - boolean
    doc: Print the list of available datasets and return
    inputBinding:
      position: 1
      prefix: --list-only
  - id: include_private
    type:
      - 'null'
      - boolean
    doc: Include datasets used for internal testing
    inputBinding:
      position: 1
      prefix: --include-private
  - id: max_size
    type:
      - 'null'
      - float
    doc: Upper bound for the size of the files to be considered when --name is not provided (default 512.0)
    inputBinding:
      position: 1
      prefix: --max-size
  - id: output_path
    type:
      - 'null'
      - string
    doc: Path where to store the downloaded file
    inputBinding:
      position: 1
      prefix: --output
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing file(s)
    inputBinding:
      position: 1
      prefix: --force
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set verbosity of output to the console (debug, info, warning, error, critical; default info)
    inputBinding:
      position: 1
      prefix: --verbosity
outputs:
  - id: dataset
    type:
      - 'null'
      - File
    doc: Downloaded contact map
    outputBinding:
      glob: $(inputs.output_path)
  - id: listing
    type: stdout
    doc: Standard output (dataset list with --list-only)
stdout: stripepy-hic_download.out
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stripepy-hic:1.3.0--pyh2a3209d_1
