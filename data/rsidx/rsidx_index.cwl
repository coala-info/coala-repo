cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rsidx
  - index
label: rsidx_index
doc: "Index a sorted VCF file by rsID (SQLite index).\n\nTool homepage: https://github.com/bioforensics/rsidx/"
inputs:
  - id: vcf
    type: File
    doc: sorted VCF file to index
    inputBinding:
      position: 1
  - id: idx
    type: string
    doc: index file to create
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwrite of index file if it already exists
    inputBinding:
      position: 101
      prefix: --force
  - id: cache_size
    type:
      - 'null'
      - int
    doc: modify default sqlite3 cache size (in KiB)
    inputBinding:
      position: 101
      prefix: --cache-size
  - id: mmap_size
    type:
      - 'null'
      - int
    doc: activate sqlite3 memory map mode and specify mmap_size (in bytes)
    inputBinding:
      position: 101
      prefix: --mmap-size
outputs:
  - id: idx_file
    type: File
    doc: The rsidx index file
    outputBinding:
      glob: $(inputs.idx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsidx:0.3.1--pyhdfd78af_0
