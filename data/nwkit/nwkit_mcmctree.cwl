cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nwkit
  - mcmctree
label: nwkit_mcmctree
doc: "Calculate divergence times for a given newick tree.\n\nTool homepage: https://github.com/kfuku52/nwkit"
inputs:
  - id: add_header
    type:
      - 'null'
      - boolean
    doc: Add the header required for mcmctree.
    default: false
    inputBinding:
      position: 101
      prefix: --add_header
  - id: format
    type:
      - 'null'
      - int
    doc: ETE tree format. See here 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: higher_rank_search
    type:
      - 'null'
      - string
    doc: Attempt to obtain timetree data using the taxids for higher taxonomic 
      ranks if the species-level search failed.
    default: yes
    inputBinding:
      position: 101
      prefix: --higher_rank_search
  - id: infile
    type:
      - 'null'
      - File
    doc: Input newick file. Use "-" for STDIN.
    default: '-'
    inputBinding:
      position: 101
      prefix: --infile
  - id: left_species
    type:
      - 'null'
      - string
    doc: Any species in the left clade. If you want to set a bound on the node 
      splitting Homo_sapiens and Mus_musculus, specify one of them (e.g., 
      Homo_sapiens).
    default: None
    inputBinding:
      position: 101
      prefix: --left_species
  - id: lower_bound
    type:
      - 'null'
      - float
    doc: Lower bound of the calibration point.
    default: None
    inputBinding:
      position: 101
      prefix: --lower_bound
  - id: lower_offset
    type:
      - 'null'
      - float
    default: 0.1
    inputBinding:
      position: 101
      prefix: --lower_offset
  - id: lower_scale
    type:
      - 'null'
      - float
    default: 1
    inputBinding:
      position: 101
      prefix: --lower_scale
  - id: lower_tailProb
    type:
      - 'null'
      - float
    doc: Lower tail probability. Use 1e-300 for hard bound. Default=0.025
    default: 0.025
    inputBinding:
      position: 101
      prefix: --lower_tailProb
  - id: min_clade_prop
    type:
      - 'null'
      - float
    doc: Minimum proportion of the clade size to the total number of species. If
      the clade proportion is smaller than this value, time constraints are 
      removed.
    default: 0
    inputBinding:
      position: 101
      prefix: --min_clade_prop
  - id: outformat
    type:
      - 'null'
      - int
    doc: ETE tree format for --outfile. "auto" indicates the same format as 
      --format.
    inputBinding:
      position: 101
      prefix: --outformat
  - id: quoted_node_names
    type:
      - 'null'
      - string
    doc: Whether node names are quoted in the input file.
    default: yes
    inputBinding:
      position: 101
      prefix: --quoted_node_names
  - id: right_species
    type:
      - 'null'
      - string
    doc: Any species in the right clade deriving from the common ancestor. If 
      you want to set a bound on the node splitting Homo_sapiens and 
      Mus_musculus, specify the other one that is not used as the left species 
      (e.g., Mus_musculus).
    default: None
    inputBinding:
      position: 101
      prefix: --right_species
  - id: timetree
    type:
      - 'null'
      - string
    doc: 'Obtain the divergence time from timetree.org. Tip labels are expected to
      be GENUS_SPECIES. point: point estimate, ci: 95 percent confidence interval
      as upper and lower bounds. no: disable the function.'
    default: no
    inputBinding:
      position: 101
      prefix: --timetree
  - id: upper_bound
    type:
      - 'null'
      - float
    doc: Upper bound of the calibration point. A point estimate can be specified
      by setting the same age in both lower and upper bounds (e.g., 
      --lower_bound 5.2 --upper_bound 5.2)
    default: None
    inputBinding:
      position: 101
      prefix: --upper_bound
  - id: upper_tailProb
    type:
      - 'null'
      - float
    doc: Upper tail probability. Use 1e-300 for hard bound. Default=0.025
    default: 0.025
    inputBinding:
      position: 101
      prefix: --upper_tailProb
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output newick file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
