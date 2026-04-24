cwlVersion: v1.2
class: CommandLineTool
baseCommand: goblin
label: goblin
doc: "Generate trusted prOteins to supplement BacteriaL annotatIoN\n\nTool homepage:
  https://github.com/rpetit3/goblin"
inputs:
  - id: assembly_level
    type:
      - 'null'
      - string
    doc: Assembly levels of genomes to download
    inputBinding:
      position: 101
      prefix: --assembly_level
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check dependencies are installed, then exit
    inputBinding:
      position: 101
      prefix: --check
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress final clustered proteins and log file
    inputBinding:
      position: 101
      prefix: --compress
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print additional debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: fast_cluster
    type:
      - 'null'
      - boolean
    doc: Use CD-HIT (-g 0) fast clustering algorithm
    inputBinding:
      position: 101
      prefix: --fast_cluster
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    inputBinding:
      position: 101
      prefix: --force
  - id: identity
    type:
      - 'null'
      - float
    doc: CD-HIT (-c) sequence identity threshold
    inputBinding:
      position: 101
      prefix: --identity
  - id: is_taxid
    type:
      - 'null'
      - boolean
    doc: Given taxid should be treated as a taxid (not a species taxid)
    inputBinding:
      position: 101
      prefix: --is_taxid
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: Keep all downloaded and intermediate files
    inputBinding:
      position: 101
      prefix: --keep_files
  - id: limit
    type:
      - 'null'
      - int
    doc: Maximum number of genomes to download
    inputBinding:
      position: 101
      prefix: --limit
  - id: max_memory
    type:
      - 'null'
      - int
    doc: CD-HIT (-M) memory limit (in MB) (0 removes memory limits)
    inputBinding:
      position: 101
      prefix: --max_memory
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to save output files
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overlap
    type:
      - 'null'
      - float
    doc: CD-HIT (-s) length difference cutoff
    inputBinding:
      position: 101
      prefix: --overlap
  - id: prefix
    type: string
    doc: Prefix to use to save outputs
    inputBinding:
      position: 101
      prefix: --prefix
  - id: query
    type: string
    doc: Download genomes for a given query (organism, taxid, file of 
      accessions)
    inputBinding:
      position: 101
      prefix: --query
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goblin:1.0.0--hdfd78af_0
stdout: goblin.out
