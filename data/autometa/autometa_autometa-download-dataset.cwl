cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-download-dataset
label: autometa_autometa-download-dataset
doc: "Download a simulated community file from google drive to a specified output directory\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: community_type
    type: string
    doc: "specify synthetic or simulated communities (currently only simulated is available)"
    inputBinding:
      position: 1
      prefix: --community-type
  - id: community_sizes
    type:
      type: array
      items: string
    doc: "community sizes to download (78Mbp, 156Mbp, 312Mbp, 625Mbp, 1250Mbp, 2500Mbp, 5000Mbp, 10000Mbp, all)"
    inputBinding:
      position: 1
      prefix: --community-sizes
  - id: file_names
    type:
      type: array
      items: string
    doc: "file names to download (e.g. README.md, reference_assignments.tsv.gz, metagenome.fna.gz, binning.tsv.gz, ..., all)"
    inputBinding:
      position: 1
      prefix: --file-names
  - id: dir_path
    type: string
    doc: "folder to start the download (several directories will be generated within this folder)"
    inputBinding:
      position: 1
      prefix: --dir-path
  - id: host
    type:
      - 'null'
      - string
    doc: "IP address to ping when checking internet connectivity (default: google.com)"
    inputBinding:
      position: 1
      prefix: --host
outputs:
  - id: download_dir
    type: Directory
    doc: "Downloaded community files"
    outputBinding:
      glob: "$(inputs.dir_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
