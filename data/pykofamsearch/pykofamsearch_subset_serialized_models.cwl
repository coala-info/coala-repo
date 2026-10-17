cwlVersion: v1.2
class: CommandLineTool
baseCommand: subset_serialized_models
label: pykofamsearch_subset_serialized_models
doc: "Subset a serialized KOfam database to the identifiers listed in a file.\n\nTool
  homepage: https://github.com/jolespin/pykofamsearch"
inputs:
  - id: identifiers
    type: File
    doc: path/to/identifiers.list where HMM identifiers are on a separate line
    inputBinding:
      position: 1
      prefix: --identifiers
  - id: serialized_database
    type: File
    doc: path/to/database.pkl[.gz] will be tuple where first item is threshold
      dictionary and second item is dictionary of HMM models
    inputBinding:
      position: 2
      prefix: --serialized_database
  - id: subset_serialized_database_path
    type: string
    doc: path/to/subset-database.pkl[.gz] will be tuple where first item is threshold
      dictionary and second item is dictionary of HMM models
    inputBinding:
      position: 3
      prefix: --subset_serialized_database
  - id: verbosity
    type: ['null', int]
    doc: Verbosity of missing KOfams
    inputBinding:
      position: 4
      prefix: --verbosity
outputs:
  - id: subset_serialized_database
    type: File
    doc: Pickled subset database
    outputBinding:
      glob: $(inputs.subset_serialized_database_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
