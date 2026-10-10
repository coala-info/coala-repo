cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtbls
  - local-validate
label: metabolights-utils_mtbls_local-validate
doc: "Validate local ISA metadata files.\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: data_files_path
    type: 
      - 'null'
      - Directory
    doc: "The data files root path."
    inputBinding:
      position: 1
      prefix: --data_files_path
  - id: output_directory
    type: 
      - 'null'
      - string
    doc: "Output file directory."
    inputBinding:
      position: 2
      prefix: --output_directory
  - id: overridden_rules_file_path
    type: 
      - 'null'
      - File
    doc: "A txt file that contains a validation rule identifier in each row (e.g. rule_i_100_350_003_01); validation errors listed in this file are filtered from the result."
    inputBinding:
      position: 3
      prefix: --overridden_rules_file_path
  - id: mtbls_validation_bundle_path
    type: 
      - 'null'
      - string
    doc: "Location of MetaboLights validation bundle path."
    inputBinding:
      position: 4
      prefix: --mtbls_validation_bundle_path
  - id: refetch_mtbls_validation_bundle
    type: 
      - 'null'
      - boolean
    doc: "Enable remote validation of the study: download the latest validation bundle."
    inputBinding:
      position: 5
      prefix: --refetch_mtbls_validation_bundle
  - id: mtbls_validation_bundle_url
    type: 
      - 'null'
      - string
    doc: "URL to download validation bundle."
    inputBinding:
      position: 6
      prefix: --mtbls_validation_bundle_url
  - id: opa_executable_path
    type: 
      - 'null'
      - string
    doc: "OPA executable path."
    inputBinding:
      position: 7
      prefix: --opa_executable_path
  - id: study_id
    type: string
    doc: "MetaboLights provisional study id (MTBLSxxxx)"
    inputBinding:
      position: 20
  - id: metadata_files_path
    type: Directory
    doc: "Folder with the ISA metadata files (i_*.txt, s_*.txt, a_*.txt, m_*.tsv)"
    inputBinding:
      position: 21
outputs:
  - id: validation_output
    type: ['null', Directory]
    doc: "Validation report folder"
    outputBinding:
      glob: $(inputs.output_directory)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: mtbls_local-validate.out
