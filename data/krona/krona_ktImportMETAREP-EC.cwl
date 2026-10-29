cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportMETAREP-EC
label: krona_ktImportMETAREP-EC
doc: "Creates a Krona chart of abundances of EC (Enzyme Commission) numbers in METAREP
  data folders. By default, queries with no EC number will be ignored (see include_no_hits).\n\nTool
  homepage: https://github.com/marbl/Krona"
inputs:
  - id: metarep_folders
    type:
      type: array
      items: Directory
    doc: Unpacked METAREP data folder (with annotation.tab or annotation.tab.gz).
      By default, separate datasets will be created for each input (see combine_datasets).
    inputBinding:
      position: 1
  - id: combine_datasets
    type:
      - 'null'
      - boolean
    doc: Combine data from each file, rather than creating separate datasets within the chart.
    inputBinding:
      position: 102
      prefix: -c
  - id: include_no_hits
    type:
      - 'null'
      - boolean
    doc: Include a wedge for queries with no hits.
    inputBinding:
      position: 102
      prefix: -i
  - id: highest_level_name
    type:
      - 'null'
      - string
    doc: Name of the highest level.
    inputBinding:
      position: 102
      prefix: -n
  - id: max_wedge_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of wedges to include in the chart.
    inputBinding:
      position: 102
      prefix: -d
  - id: krona_resources_url
    type:
      - 'null'
      - string
    doc: URL of Krona resources to use instead of bundling them with the chart (e.g. "http://krona.sourceforge.net"). Reduces size of charts and allows updates, though charts will not work without access to this URL.
    inputBinding:
      position: 102
      prefix: -u
  - id: query_url
    type:
      - 'null'
      - string
    doc: Url to send query IDs to (instead of listing them) for each wedge. The query IDs will be sent as a comma separated list in the POST variable "queries", with the current dataset index (from 0) in the POST variable "dataset". The url can include additional variables encoded via GET.
    inputBinding:
      position: 102
      prefix: -qp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose.
    inputBinding:
      position: 102
      prefix: -v
  - id: output_file_path
    type: string
    default: metarep-ec.krona.html
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
