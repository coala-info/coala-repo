cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur_distance
label: augur_distance
doc: "Calculate the distance between sequences across entire genes or at a\npredefined
  subset of sites. Distance calculations require selection of a\ncomparison method
  (to determine which sequences to compare) and a distance map\n(to determine the
  weight of a mismatch between any two sequences).\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: alignment
    type:
      type: array
      items: File
    doc: sequence(s) to be used, supplied as FASTA files
    inputBinding:
      position: 101
      prefix: --alignment
  - id: attribute_name
    type:
      type: array
      items: string
    doc: name to store distances associated with the given distance map; 
      multiple attribute names are linked to corresponding positional comparison
      method and distance map arguments
    inputBinding:
      position: 101
      prefix: --attribute-name
  - id: compare_to
    type:
      type: array
      items: string
    doc: type of comparison between samples in the given tree including 
      comparison of all nodes to the root (root), all tips to their last 
      ancestor from a previous season (ancestor), or all tips from the current 
      season to all tips in previous seasons (pairwise)
    inputBinding:
      position: 101
      prefix: --compare-to
  - id: date_annotations
    type:
      - 'null'
      - File
    doc: JSON of branch lengths and date annotations from augur refine for 
      samples in the given tree; required for comparisons to earliest or latest 
      date
    inputBinding:
      position: 101
      prefix: --date-annotations
  - id: earliest_date
    type:
      - 'null'
      - string
    doc: earliest date at which samples are considered to be from previous 
      seasons (e.g., 2019-01-01). This date is only used in pairwise 
      comparisons. If omitted, all samples prior to the latest date will be 
      considered.
    inputBinding:
      position: 101
      prefix: --earliest-date
  - id: gene_names
    type:
      type: array
      items: string
    doc: names of the sequences in the alignment, same order assumed
    inputBinding:
      position: 101
      prefix: --gene-names
  - id: latest_date
    type:
      - 'null'
      - string
    doc: latest date at which samples are considered to be from previous seasons
      (e.g., 2019-01-01); samples from any date after this are considered part 
      of the current season
    inputBinding:
      position: 101
      prefix: --latest-date
  - id: map
    type:
      type: array
      items: File
    doc: JSON providing the distance map between sites and, optionally, 
      sequences present at those sites; the distance map JSON minimally requires
      a 'default' field defining a default numeric distance and a 'map' field 
      defining a dictionary of genes and one-based coordinates
    inputBinding:
      position: 101
      prefix: --map
  - id: tree
    type: File
    doc: Newick tree
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: output
    type: File
    doc: JSON file with calculated distances stored by node name and attribute 
      name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
