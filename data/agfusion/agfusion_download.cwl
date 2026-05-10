cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agfusion
  - download
label: agfusion_download
doc: "Download the AGFusion database for specific genomes, species, and releases.\n\
  \nTool homepage: https://github.com/murphycj/AGFusion"
inputs:
  - id: available
    type:
      - 'null'
      - boolean
    doc: List available species and ensembl releases.
    inputBinding:
      position: 101
      prefix: --available
  - id: genome
    type:
      - 'null'
      - string
    doc: Specify the genome shortcut (e.g. hg19). To see allavailable shortcuts 
      run 'agfusion download -a'. Either specify this or --species and 
      --release.
    inputBinding:
      position: 101
      prefix: --genome
  - id: release
    type:
      - 'null'
      - string
    doc: The ensembl release (e.g. 87).
    inputBinding:
      position: 101
      prefix: --release
  - id: species
    type:
      - 'null'
      - string
    doc: The species (e.g. homo_sapiens).
    inputBinding:
      position: 101
      prefix: --species
  - id: dir_path
    type: string
    doc: Output or path parameter `dir_path`
    inputBinding:
      position: 102
      prefix: --dir
outputs:
  - id: dir
    type:
      - 'null'
      - Directory
    doc: (Optional) Directory to the database will be downloaded to (defaults to
      current working directory).
    outputBinding:
      glob: $(inputs.dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agfusion:1.252--py_0
