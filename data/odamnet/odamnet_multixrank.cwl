cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - odamnet
  - multixrank
label: odamnet_multixrank
doc: "Performs a Random Walk with Restart analysis using multiXrank with genes and
  diseases multilayers.\n\nTool homepage: https://pypi.org/project/ODAMNet/1.1.0/"
inputs:
  - id: chemicals_file
    type:
      - 'null'
      - File
    doc: Chemicals file name
    inputBinding:
      position: 101
      prefix: --chemicalsFile
  - id: config_path
    type: Directory
    doc: Configurations file path name
    inputBinding:
      position: 101
      prefix: --configPath
  - id: ctd_file
    type:
      - 'null'
      - File
    doc: CTD file name
    inputBinding:
      position: 101
      prefix: --CTD_file
  - id: direct_association
    type:
      - 'null'
      - boolean
    doc: "True: Extract target genes from chemicals\n                            \
      \      False: Extract target genes from chemicals +\n                      \
      \            its child chemicals"
    default: true
    inputBinding:
      position: 101
      prefix: --directAssociation
  - id: nb_pub
    type:
      - 'null'
      - int
    doc: "Minimum number of publications to keep an\n                            \
      \      interaction"
    default: 2
    inputBinding:
      position: 101
      prefix: --nbPub
  - id: networks_path
    type: Directory
    doc: Network directory path
    inputBinding:
      position: 101
      prefix: --networksPath
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output folder name to save results
    default: OutputResults
    inputBinding:
      position: 101
      prefix: --outputPath
  - id: seeds_file
    type: File
    doc: Seeds file path name
    inputBinding:
      position: 101
      prefix: --seedsFile
  - id: sif_file_name
    type: string
    doc: Name of the output file network SIF
    inputBinding:
      position: 101
      prefix: --sifFileName
  - id: target_genes_file
    type:
      - 'null'
      - File
    doc: Target genes file name
    inputBinding:
      position: 101
      prefix: --targetGenesFile
  - id: top
    type:
      - 'null'
      - int
    doc: "Top number of results to write into output\n                           \
      \       file"
    default: 10
    inputBinding:
      position: 101
      prefix: --top
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
stdout: odamnet_multixrank.out
