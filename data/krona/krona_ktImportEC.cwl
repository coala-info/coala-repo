cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportEC
label: krona_ktImportEC
doc: 'Creates a Krona chart of abundances of EC (Enzyme Commission) numbers in tab-delimited
  files.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: ec_numbers
    type:
      type: array
      items: File
    doc: Tab-delimited files with EC numbers and (optionally) query IDs, magnitudes
      and scores. By default, query IDs, EC numbers and scores will be taken from
      columns 1, 2 and 3, respectively (see -q, -e, -s, and -m). By default, separate
      datasets will be created for each input (see [-c]).
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
  - id: ec_number_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as EC number.
    inputBinding:
      position: 102
      prefix: -e
  - id: good_score_hue
    type:
      - 'null'
      - int
    doc: Hue (0-360) for "good" scores.
    inputBinding:
      position: 102
      prefix: -y
  - id: include_no_hits
    type:
      - 'null'
      - boolean
    doc: Include a wedge for queries with no hits.
    inputBinding:
      position: 102
      prefix: -i
  - id: magnitude_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as magnitude. If magnitude files are specified,
      their magnitudes will override those in this column.
    inputBinding:
      position: 102
      prefix: -m
  - id: highest_level_name
    type:
      - 'null'
      - string
    doc: Name of the highest level.
    inputBinding:
      position: 102
      prefix: -n
  - id: query_id_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as query ID. Required if magnitude files are
      specified.
    inputBinding:
      position: 102
      prefix: -q
  - id: score_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as score.
    inputBinding:
      position: 102
      prefix: -s
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
  - id: query_url
    type:
      - 'null'
      - string
    doc: Url to send query IDs to (instead of listing them) for each wedge. The query
      IDs will be sent as a comma separated list in the POST variable "queries", with
      the current dataset index (from 0) in the POST variable "dataset". The url can
      include additional variables encoded via GET.
    inputBinding:
      position: 102
      prefix: -qp
  - id: output_file_path
    type: string
    default: ec.krona.html
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
