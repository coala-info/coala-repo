cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportMGRAST
label: krona_ktImportMGRAST
doc: 'Creates a Krona chart from MG-RAST organism or functional analyses.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: mgrast_tables
    type:
      type: array
      items: File
    doc: A table exported from MG-RAST. It can be from organism or functional analysis,
      but all tables being imported should be consistent. By default, separate datasets
      will be created for each input (see [-c]).
    inputBinding:
      position: 1
  - id: bad_score_hue
    type:
      - 'null'
      - int
    doc: Hue (0-360) for "bad" scores.
    inputBinding:
      position: 102
      prefix: -x
  - id: combine_datasets
    type:
      - 'null'
      - boolean
    doc: Combine data from each file, rather than creating separate datasets within
      the chart.
    inputBinding:
      position: 102
      prefix: -c
  - id: max_wedge_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of wedges to include in the chart.
    inputBinding:
      position: 102
      prefix: -d
  - id: good_score_hue
    type:
      - 'null'
      - int
    doc: Hue (0-360) for "good" scores.
    inputBinding:
      position: 102
      prefix: -y
  - id: highest_level_name
    type:
      - 'null'
      - string
    doc: Name of the highest level.
    inputBinding:
      position: 102
      prefix: -n
  - id: use_percent_identity_for_average_scores
    type:
      - 'null'
      - boolean
    doc: Use percent identity for average scores instead of log[10] e-value.
    inputBinding:
      position: 102
      prefix: -p
  - id: krona_resources_url
    type:
      - 'null'
      - string
    doc: URL of Krona resources to use instead of bundling them with the chart (e.g.
      "http://krona.sourceforge.net"). Reduces size of charts and allows updates,
      though charts will not work without access to this URL.
    inputBinding:
      position: 102
      prefix: -u
  - id: output_file_path
    type: string
    default: mg-rast.krona.html
    doc: Output file name
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
