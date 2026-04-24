cwlVersion: v1.2
class: CommandLineTool
baseCommand: easypqp_targeted-file-converter
label: easypqp_targeted-file-converter
doc: "Convert different spectral libraries / transition files for targeted\nproteomics
  and metabolomics analysis.\n\nCan convert multiple formats to and from TraML (standardized
  transition\nformat). The following formats are supported: \n\n    - @ref OpenMS::TraMLFile
  \"TraML\"  \n\n    - @ref OpenMS::TransitionTSVFile \"OpenSWATH TSV transition lists\"\
  \  \n\n    - @ref OpenMS::TransitionPQPFile \"OpenSWATH PQP SQLite files\"  \n\n\
  \    - SpectraST MRM transition lists  \n\n    - Skyline transition lists  \n\n\
  \    - Spectronaut transition lists  \n\n    - Parquet transition lists  \n\nTool
  homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: in
    type: File
    doc: Transition list to convert.
    inputBinding:
      position: 101
      prefix: --in
  - id: in_type
    type:
      - 'null'
      - string
    doc: "Input file type. Default: None, will be\ndetermined from input file. Valid
      formats:\n[\"tsv\", \"mrm\" ,\"pqp\", \"TraML\", \"parquet\"]"
    inputBinding:
      position: 101
      prefix: --in_type
  - id: legacy_traml_id
    type:
      - 'null'
      - boolean
    doc: "PQP to TraML: Should legacy TraML IDs be\nused?"
    inputBinding:
      position: 101
      prefix: --legacy_traml_id
  - id: no_legacy_traml_id
    type:
      - 'null'
      - boolean
    doc: "PQP to TraML: Should legacy TraML IDs be\nused?"
    inputBinding:
      position: 101
      prefix: --no-legacy_traml_id
  - id: out_type
    type:
      - 'null'
      - string
    doc: "Output file type. Default: None, will be\ndetermined from output file. Valid
      formats:\n[\"tsv\", \"pqp\", \"TraML\"]"
    inputBinding:
      position: 101
      prefix: --out_type
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file to be converted to.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
