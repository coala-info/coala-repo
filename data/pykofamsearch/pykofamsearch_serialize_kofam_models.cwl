cwlVersion: v1.2
class: CommandLineTool
baseCommand: serialize_kofam_models
label: pykofamsearch_serialize_kofam_models
doc: "Serialize the KOfam HMM profiles and the ko_list thresholds into one pickled
  database (offline mode) or download and serialize them (online mode).\n\nTool homepage:
  https://github.com/jolespin/pykofamsearch"
inputs:
  - id: profiles
    type: ['null', Directory]
    doc: path/to/kofam_profiles_database_directory/ (the extracted profiles.tar.gz)
    inputBinding:
      position: 1
      prefix: --profiles
  - id: ko_list
    type: ['null', File]
    doc: path/to/ko_list[.gz]
    inputBinding:
      position: 2
      prefix: --ko_list
  - id: serialized_database_path
    type: ['null', string]
    doc: path/to/database.pkl[.gz] will be tuple where first item is threshold
      dictionary and second item is dictionary of HMM models. Cannot be used with
      -o/--output_directory
    inputBinding:
      position: 3
      prefix: --serialized_database
  - id: output_directory_path
    type: ['null', string]
    doc: path/to/output_directory/ (online mode). Cannot be used with -b/--serialized_database
    inputBinding:
      position: 4
      prefix: --output_directory
  - id: ko_list_url
    type: ['null', string]
    doc: FTP URL for ko_list
    inputBinding:
      position: 5
      prefix: --ko_list_url
  - id: profiles_url
    type: ['null', string]
    doc: FTP URL for profiles.tar.gz
    inputBinding:
      position: 6
      prefix: --profiles_url
  - id: verbosity
    type: ['null', int]
    doc: Verbosity of missing KOfams
    inputBinding:
      position: 7
      prefix: --verbosity
outputs:
  - id: serialized_database
    type: ['null', File]
    doc: Pickled database of thresholds and HMM models
    outputBinding:
      glob: $(inputs.serialized_database_path)
  - id: output_directory
    type: ['null', Directory]
    doc: Downloaded database directory (online mode)
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
