cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agfusion
  - build
label: agfusion_build
doc: "Build the AGFusion database for a specific species and Ensembl release.\n\n\
  Tool homepage: https://github.com/murphycj/AGFusion"
inputs:
  - id: pfam
    type: File
    doc: File containing PFAM ID mappings.
    inputBinding:
      position: 101
      prefix: --pfam
  - id: release
    type: int
    doc: The ensembl release (e.g. 87).
    inputBinding:
      position: 101
      prefix: --release
  - id: server
    type:
      - 'null'
      - string
    doc: (optional) Ensembl server
    default: ensembldb.ensembl.org
    inputBinding:
      position: 101
      prefix: --server
  - id: species
    type: string
    doc: The species (e.g. homo_sapiens).
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: dir
    type: Directory
    doc: Directory to write database file to.
    outputBinding:
      glob: $(inputs.dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agfusion:1.252--py_0
