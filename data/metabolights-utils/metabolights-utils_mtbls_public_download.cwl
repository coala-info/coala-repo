cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtbls
  - public
  - download
label: metabolights-utils_mtbls_public_download
doc: "Download study data and metadata files from the MetaboLights FTP server.\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: local_path
    type: 
      - 'null'
      - string
    doc: "Local storage root path. Folder will be created if it does not exist."
    inputBinding:
      position: 1
      prefix: --local_path
  - id: ftp_server_url
    type: 
      - 'null'
      - string
    doc: "FTP server URL where MetaboLights repository is hosted."
    inputBinding:
      position: 2
      prefix: --ftp_server_url
  - id: ftp_root_directory
    type: 
      - 'null'
      - string
    doc: "MetaboLights study directory on FTP server URL."
    inputBinding:
      position: 3
      prefix: --ftp_root_directory
  - id: local_cache_path
    type: 
      - 'null'
      - string
    doc: "Path to store cache files of FTP file indices, study models, etc."
    inputBinding:
      position: 4
      prefix: --local_cache_path
  - id: override_local_files
    type: 
      - 'null'
      - boolean
    doc: "Downloads files and override current local copies."
    inputBinding:
      position: 5
      prefix: --override_local_files
  - id: study_id
    type: string
    doc: "MetaboLights study accession number (MTBLSxxxx)"
    inputBinding:
      position: 20
  - id: file
    type: 
      - 'null'
      - string
    doc: "Relative file path in study folder (all ISA metadata files are downloaded if not given)"
    inputBinding:
      position: 21
outputs:
  - id: local_study
    type: Directory
    doc: "Local storage root folder with the downloaded study"
    outputBinding:
      glob: $(inputs.local_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: mtbls_public_download.out
