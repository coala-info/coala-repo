cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogtfinder
label: ogtfinder
doc: "Optimal growth temperature prediction using proteome-derived features\n\nTool
  homepage: https://github.com/SC-Git1/OGTFinder"
inputs:
  - id: proteome_fasta
    type: File
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode: also keep intermediate results'
    inputBinding:
      position: 102
      prefix: --debug
  - id: domain
    type:
      - 'null'
      - string
    doc: Taxonomic domain name
    inputBinding:
      position: 102
      prefix: --domain
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory
    inputBinding:
      position: 102
      prefix: --force
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --outdir
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Output verbosity. Levels: 0 (silent), 1 (warnings), 2 (verbose)'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ogtfinder:0.0.2--pyhdfd78af_0
stdout: ogtfinder.out
