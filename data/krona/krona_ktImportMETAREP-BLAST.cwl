cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportMETAREP-BLAST
label: krona_ktImportMETAREP-BLAST
doc: "Creates a Krona chart by classifying reads based on BLAST results in METAREP
  data folders.\n\nTool homepage: https://github.com/marbl/Krona"
inputs:
  - id: metarep_folders
    type:
      type: array
      items: Directory
    doc: Unpacked METAREP data folder (with blast.tab or blast.tab.gz). By default,
      separate datasets will be created for each input (see combine_datasets).
    inputBinding:
      position: 1
  - id: random_best_hit
    type:
      - 'null'
      - boolean
    doc: Pick from the best hits randomly instead of finding the lowest common ancestor.
    inputBinding:
      position: 102
      prefix: -r
  - id: use_percent_identity
    type:
      - 'null'
      - boolean
    doc: Use percent identity for average scores instead of log[10] e-value.
    inputBinding:
      position: 102
      prefix: -p
  - id: use_bit_score
    type:
      - 'null'
      - boolean
    doc: Use bit score for average scores instead of log[10] e-value.
    inputBinding:
      position: 102
      prefix: -b
  - id: combine_datasets
    type:
      - 'null'
      - boolean
    doc: Combine data from each file, rather than creating separate datasets within the chart.
    inputBinding:
      position: 102
      prefix: -c
  - id: show_cellular_organisms
    type:
      - 'null'
      - boolean
    doc: Show the "cellular organisms" taxon (collapsed by default).
    inputBinding:
      position: 102
      prefix: -k
  - id: collapse_no_rank_taxa
    type:
      - 'null'
      - boolean
    doc: Collapse assignments to taxa with ranks labeled "no rank" by moving up to parent.
    inputBinding:
      position: 102
      prefix: -K
  - id: bad_score_hue
    type:
      - 'null'
      - int
    doc: Hue (0-360) for "bad" scores.
    inputBinding:
      position: 102
      prefix: -x
  - id: good_score_hue
    type:
      - 'null'
      - int
    doc: Hue (0-360) for "good" scores.
    inputBinding:
      position: 102
      prefix: -y
  - id: taxonomy_database_path
    type:
      - 'null'
      - Directory
    doc: Path to directory containing a taxonomy database to use.
    inputBinding:
      position: 102
      prefix: -tax
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose.
    inputBinding:
      position: 102
      prefix: -v
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
  - id: output_file_path
    type: string
    default: metarep-blast.krona.html
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
