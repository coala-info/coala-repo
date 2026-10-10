cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtbls
  - public
  - remove
label: metabolights-utils_mtbls_public_remove
doc: "Delete local study data and metadata files.\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        (inputs.local_studies || []).forEach(function (d) { l.push({entryname: (inputs.local_path || 'local_studies') + '/' + d.basename, entry: d, writable: true}); });
        return l;
      }
inputs:
  - id: local_path
    type: 
      - 'null'
      - string
    doc: "Local storage root path."
    inputBinding:
      position: 1
      prefix: --local_path
  - id: local_cache_path
    type: 
      - 'null'
      - string
    doc: "Path to store cache files of FTP file indices, study models, etc."
    inputBinding:
      position: 2
      prefix: --local_cache_path
  - id: local_studies
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "Local study folders (named MTBLSxxxx) staged under the local storage root path"
  - id: study_id
    type: string
    doc: "MetaboLights study accession number (MTBLSxxxx)"
    inputBinding:
      position: 20
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: local_root
    type: ['null', Directory]
    doc: "Local storage root folder after the removal"
    outputBinding:
      glob: $(inputs.local_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: mtbls_public_remove.out
