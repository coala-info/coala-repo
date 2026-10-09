cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hostile
  - index
  - fetch
label: hostile_index_fetch
doc: "Download and cache indexes from object storage for use with hostile clean\n\n\
  Tool homepage: https://github.com/bede/hostile"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: name of index to download
    inputBinding:
      position: 101
      prefix: --name
  - id: minimap2
    type:
      - 'null'
      - boolean
    doc: fetch Minimap2 index
    inputBinding:
      position: 101
      prefix: --minimap2
  - id: bowtie2
    type:
      - 'null'
      - boolean
    doc: fetch Bowtie2 index
    inputBinding:
      position: 101
      prefix: --bowtie2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: cache
    type: Directory
    doc: Index cache directory holding the downloaded index files
    outputBinding:
      glob: hostile_cache
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: HOSTILE_CACHE_DIR
        envValue: $(runtime.outdir)/hostile_cache
  - class: InitialWorkDirRequirement
    listing:
      - entryname: hostile_cache
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
stdout: hostile_index_fetch.out
