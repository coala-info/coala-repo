cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtbls
  - public
  - describe
label: metabolights-utils_mtbls_public_describe
doc: "View summary of any public study content; run a jsonpath expression to filter the MetaboLights study model.\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        (inputs.local_studies || []).forEach(function (d) { l.push({entryname: (inputs.local_path || 'local_studies') + '/' + d.basename, entry: d, writable: true}); });
        return l;
      }
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
  - id: use_only_local
    type: 
      - 'null'
      - boolean
    doc: "Use only current local directory without connecting FTP server."
    inputBinding:
      position: 5
      prefix: --use_only_local
  - id: override_local_files
    type: 
      - 'null'
      - boolean
    doc: "Downloads files and override current local copies (not valid with use_only_local)."
    inputBinding:
      position: 6
      prefix: --override_local_files
  - id: load_folder_index
    type: 
      - 'null'
      - boolean
    doc: "Create a folder index to store file descriptors on FTP server (not valid with use_only_local)."
    inputBinding:
      position: 7
      prefix: --load_folder_index
  - id: use_study_model_cache
    type: 
      - 'null'
      - boolean
    doc: "Use cached study model."
    inputBinding:
      position: 8
      prefix: --use_study_model_cache
  - id: local_studies
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Local study folders (named MTBLSxxxx) staged under the local storage root path, for use with use_only_local"
  - id: study_id
    type: string
    doc: "MetaboLights study accession number (MTBLSxxxx)"
    inputBinding:
      position: 20
  - id: jsonpath
    type: 
      - 'null'
      - string
    doc: "jsonpath expression to filter the study model, e.g. $.investigation.studies[0].title (summary if not given)"
    inputBinding:
      position: 21
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: mtbls_public_describe.out
