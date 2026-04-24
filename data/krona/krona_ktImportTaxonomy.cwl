cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportTaxonomy
label: krona_ktImportTaxonomy
doc: "Creates a Krona chart based on taxonomy IDs and, optionally, magnitudes and
  scores. Taxonomy IDs corresponding to a rank of \"no rank\" in the database will
  be assigned to their parents to make the hierarchy less cluttered (e.g. \"Cellular
  organisms\" will be assigned to \"root\").\n\nTool homepage: https://github.com/marbl/Krona"
inputs:
  - id: input_files
    type:
      type: array
      items: string
    doc: Tab-delimited file with taxonomy IDs and (optionally) query IDs, 
      magnitudes and scores. Lines beginning with "#" will be ignored. By 
      default, separate datasets will be created for each input (see [-c]).
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
  - id: collapse_no_rank
    type:
      - 'null'
      - boolean
    doc: Collapse assignments to taxa with ranks labeled "no rank" by moving up 
      to parent.
    inputBinding:
      position: 102
      prefix: -K
  - id: combine_datasets
    type:
      - 'null'
      - boolean
    doc: Combine data from each file, rather than creating separate datasets 
      within the chart.
    inputBinding:
      position: 102
      prefix: -c
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
  - id: include_no_hits
    type:
      - 'null'
      - boolean
    doc: Include a wedge for queries with no hits.
    inputBinding:
      position: 102
      prefix: -i
  - id: krona_resources_url
    type:
      - 'null'
      - string
    doc: URL of Krona resources to use instead of bundling them with the chart 
      (e.g. "http://krona.sourceforge.net"). Reduces size of charts and allows 
      updates, though charts will not work without access to this URL.
    inputBinding:
      position: 102
      prefix: -u
  - id: magnitude_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as magnitude. If magnitude files are 
      specified, their magnitudes will override those in this column.
    inputBinding:
      position: 102
      prefix: -m
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of wedges to include in the chart.
    inputBinding:
      position: 102
      prefix: -d
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file name.
    inputBinding:
      position: 102
      prefix: -o
  - id: query_id_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as query ID. Required if magnitude files 
      are specified.
    inputBinding:
      position: 102
      prefix: -q
  - id: query_url_post
    type:
      - 'null'
      - string
    doc: Url to send query IDs to (instead of listing them) for each wedge. The 
      query IDs will be sent as a comma separated list in the POST variable 
      "queries", with the current dataset index (from 0) in the POST variable 
      "dataset". The url can include additional variables encoded via GET.
    inputBinding:
      position: 102
      prefix: -qp
  - id: score_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as score.
    inputBinding:
      position: 102
      prefix: -s
  - id: show_cellular_organisms
    type:
      - 'null'
      - boolean
    doc: Show the "cellular organisms" taxon (collapsed by default).
    inputBinding:
      position: 102
      prefix: -k
  - id: taxonomy_db_path
    type:
      - 'null'
      - Directory
    doc: Path to directory containing a taxonomy database to use.
    inputBinding:
      position: 102
      prefix: -tax
  - id: taxonomy_id_column
    type:
      - 'null'
      - int
    doc: Column of input files to use as taxonomy ID.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktImportTaxonomy.out
