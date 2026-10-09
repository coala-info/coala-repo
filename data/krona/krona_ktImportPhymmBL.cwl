cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportPhymmBL
label: krona_ktImportPhymmBL
doc: 'Creates a Krona chart of Phymm or PhymmBL results. Note: Since confidence scores
  are not given for species/subspecies classifications, they inheret confidence scores
  from genus classifications.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: phymmbl_results
    type:
      type: array
      items: File
    doc: PhymmBL results files (results.03.*). Results can also be from Phymm alone
      (results.01.*), but [-p] must be specified. By default, separate datasets will
      be created for each input (see [-c]).
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
  - id: minimum_confidence
    type:
      - 'null'
      - float
    doc: Minimum confidence. Each query sequence will only be added to taxa that were
      predicted with a confidence score of at least this value.
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
  - id: phymm_only
    type:
      - 'null'
      - boolean
    doc: Input is phymm only (no confidence scores).
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
    default: phymm(bl).krona.html
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
