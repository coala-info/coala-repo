cwlVersion: v1.2
class: CommandLineTool
baseCommand: serialize_hmm_models
label: pyhmmsearch_serialize_hmm_models
doc: "Serialize HMM models into a pickled dictionary {name: hmm} that pyhmmsearch can load
  with --serialized_database.\n\nTool homepage: https://github.com/jolespin/pyhmmsearch"
inputs:
  - id: hmm_database
    type: ['null', File]
    doc: path/to/hmm_database. A single multi-HMM file. Cannot be used with --hmm_list.
    inputBinding:
      position: 1
      prefix: --hmm_database
  - id: hmm_list
    type: ['null', File]
    doc: List of filepaths to HMM files. Cannot be used with --hmm_database.
    inputBinding:
      position: 2
      prefix: --hmm_list
  - id: hmm_files
    type:
      - 'null'
      - type: array
        items: File
    doc: HMM files named in hmm_list, staged in the working directory so that the names resolve.
  - id: serialized_database_path
    type: string
    doc: path/to/database.pkl[.gz] is dictionary of HMM models
    inputBinding:
      position: 3
      prefix: --serialized_database
  - id: hmm_marker_field
    type: ['null', string]
    doc: HMM reference type (accession, name)
    inputBinding:
      position: 4
      prefix: --hmm_marker_field
outputs:
  - id: serialized_database
    type: File
    doc: Pickled dictionary of HMM models
    outputBinding:
      glob: $(inputs.serialized_database_path)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.hmm_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
