cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcflurry-downloads
label: mhcflurry_mhcflurry-downloads_fetch
doc: "Download MHCflurry released datasets and trained models (mhcflurry-downloads fetch).\n\nTool homepage:\
  \ https://github.com/hammerlab/mhcflurry"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output less
    inputBinding:
      position: 1
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output more
    inputBinding:
      position: 2
      prefix: --verbose
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Don't delete archives after they are extracted
    inputBinding:
      position: 4
      prefix: --keep
  - id: release
    type:
      - 'null'
      - string
    doc: 'Release to download. Default: 2.2.0'
    inputBinding:
      position: 4
      prefix: --release
  - id: already_downloaded_dir
    type:
      - 'null'
      - Directory
    doc: Don't download files, get them from DIR
    inputBinding:
      position: 4
      prefix: --already-downloaded-dir
  - id: downloads
    type:
      - 'null'
      - type: array
        items: string
    doc: Items to download (for example models_class1_pan).
    inputBinding:
      position: 5
arguments:
  - position: 3
    valueFrom: fetch
outputs:
  - id: data_dir
    type: Directory
    doc: MHCflurry data directory (MHCFLURRY_DATA_DIR) holding the fetched downloads.
    outputBinding:
      glob: mhcflurry_data
  - id: log
    type: stdout
    doc: Fetch log (standard output).
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MHCFLURRY_DATA_DIR
        envValue: $(runtime.outdir)/mhcflurry_data
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
stdout: mhcflurry_mhcflurry-downloads_fetch.out
