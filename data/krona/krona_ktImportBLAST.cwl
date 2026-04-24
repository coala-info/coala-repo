cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportBLAST
label: krona_ktImportBLAST
doc: "Creates a Krona chart of taxonomic classifications computed from tabular BLAST
  results.\n\nTool homepage: https://github.com/marbl/Krona"
inputs:
  - id: blast_outputs
    type:
      type: array
      items: string
    doc: File containing BLAST results in tabular format. Can optionally include
      magnitudes and a name for the dataset.
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
  - id: bit_score_difference_threshold
    type:
      - 'null'
      - string
    doc: Threshold for bit score differences when determining "best" hits. Hits 
      with scores that are within this distance of the highest score will be 
      included when computing the lowest common ancestor (or picking randomly if
      -r is specified).
    inputBinding:
      position: 102
      prefix: -t
  - id: collapse_no_rank_taxa
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
  - id: e_value_factor
    type:
      - 'null'
      - string
    doc: E-value factor for determining "best" hits. A bit score difference 
      threshold (-t) is recommended instead to avoid comparing e-values that 
      BLAST reports as 0 due to floating point underflow. However, an e-value 
      factor should be used if the input is a concatination of BLASTs against 
      different databases.
    inputBinding:
      position: 102
      prefix: -e
  - id: force_root_on_unknown_accessions
    type:
      - 'null'
      - boolean
    doc: If any best hits have unknown accessions, force classification to root 
      instead of ignoring them.
    inputBinding:
      position: 102
      prefix: -f
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
  - id: max_wedge_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of wedges to include in the chart.
    inputBinding:
      position: 102
      prefix: -d
  - id: query_url
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
  - id: random_best_hit_selection
    type:
      - 'null'
      - boolean
    doc: Pick from the best hits randomly instead of finding the lowest common 
      ancestor.
    inputBinding:
      position: 102
      prefix: -r
  - id: show_cellular_organisms
    type:
      - 'null'
      - boolean
    doc: Show the "cellular organisms" taxon (collapsed by default).
    inputBinding:
      position: 102
      prefix: -k
  - id: taxonomy_database_path
    type:
      - 'null'
      - Directory
    doc: Path to directory containing a taxonomy database to use.
    inputBinding:
      position: 102
      prefix: -tax
  - id: use_bit_score_for_average_scores
    type:
      - 'null'
      - boolean
    doc: Use bit score for average scores instead of log[10]-e-value.
    inputBinding:
      position: 102
      prefix: -b
  - id: use_percent_identity_for_average_scores
    type:
      - 'null'
      - boolean
    doc: Use percent identity for average scores instead of log[10]-e-value.
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
