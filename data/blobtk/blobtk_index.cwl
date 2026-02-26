cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtk
  - index
label: blobtk_index
doc: "Index files for GenomeHubs. Called as `blobtk index`\n\nTool homepage: https://github.com/genomehubs/blobtk"
inputs:
  - id: accession
    type:
      - 'null'
      - string
    doc: Assembly accession to fetch sequence report from NCBI datasets
    inputBinding:
      position: 101
      prefix: --accession
  - id: blobdir
    type:
      - 'null'
      - Directory
    doc: Path to BlobDir directory containing files to index
    inputBinding:
      position: 101
      prefix: --blobdir
  - id: busco
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Path to BUSCO directory containing files to index Multiple BUSCO 
      directories can be provided
    inputBinding:
      position: 101
      prefix: --busco
  - id: schema
    type:
      - 'null'
      - boolean
    doc: Flag to generate JSON schema
    inputBinding:
      position: 101
      prefix: --schema
  - id: taxon_id
    type:
      - 'null'
      - string
    doc: Taxon ID for the assembly
    inputBinding:
      position: 101
      prefix: --taxon-id
  - id: window_size
    type:
      - 'null'
      - type: array
        items: float
    doc: Window sizes for feature extraction. Supported values depend on the 
      BlobDir (typically 0.01, 0.1, 1, 100000, 1000000)
    default: 1
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output schema file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
