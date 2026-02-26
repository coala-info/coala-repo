cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - download_taxonomy
label: expam_download_taxonomy
doc: "Download taxonomic information for reference sequences.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Percentage requirement for classification subtrees (see Tutorials 1 & 
      2).
    inputBinding:
      position: 101
      prefix: --alpha
  - id: colour_list
    type:
      - 'null'
      - type: array
        items: string
    doc: List of colours to use when plotting groups in phylotree.
    inputBinding:
      position: 101
      prefix: --colour-list
  - id: cpm
    type:
      - 'null'
      - float
    doc: Counts/million cutoff for read-count to be non-negligible.
    inputBinding:
      position: 101
      prefix: --cpm
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name of database.
    inputBinding:
      position: 101
      prefix: --db_name
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set logging level to DEBUG (as opposed to INFO).
    inputBinding:
      position: 101
      prefix: --debug
  - id: directory
    type:
      - 'null'
      - Directory
    doc: File URL, context depending on command supplied.
    inputBinding:
      position: 101
      prefix: --directory
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Generate error in reads (error ~ reads with errors / reads).
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: first_n
    type:
      - 'null'
      - int
    doc: Add first n genomes in folder.
    inputBinding:
      position: 101
      prefix: --first
  - id: flat_colour
    type:
      - 'null'
      - boolean
    doc: Do not use abundance to make phylotree colours opaque.
    inputBinding:
      position: 101
      prefix: --flat-colour
  - id: group
    type:
      - 'null'
      - type: array
        items: File
    doc: Space-separated list of sample files to be treated as a single group in
      phylotree.
    inputBinding:
      position: 101
      prefix: --group
  - id: ignore_names
    type:
      - 'null'
      - boolean
    doc: Ignore names.
    inputBinding:
      position: 101
      prefix: --ignore-names
  - id: itol
    type:
      - 'null'
      - boolean
    doc: Output plotting data in ITOL format.
    inputBinding:
      position: 101
      prefix: --itol
  - id: keep_zeros
    type:
      - 'null'
      - boolean
    doc: Keep nodes of output where no reads have been assigned.
    inputBinding:
      position: 101
      prefix: --keep-zeros
  - id: kmer
    type:
      - 'null'
      - int
    doc: Length of mer used for analysis.
    inputBinding:
      position: 101
      prefix: --kmer
  - id: length
    type:
      - 'null'
      - int
    doc: Length of simulated reads.
    inputBinding:
      position: 101
      prefix: --length
  - id: log_scores
    type:
      - 'null'
      - boolean
    doc: Log transformation to opacity scores on phylotree (think uneven 
      distributions).
    inputBinding:
      position: 101
      prefix: --log-scores
  - id: n_processes
    type:
      - 'null'
      - int
    doc: Number of CPUs to use for processing.
    inputBinding:
      position: 101
      prefix: --n-processes
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Treat reads as paired-end.
    inputBinding:
      position: 101
      prefix: --paired
  - id: phylogeny
    type:
      - 'null'
      - File
    doc: URL of Newick file containing phylogeny.
    inputBinding:
      position: 101
      prefix: --phylogeny
  - id: pile
    type:
      - 'null'
      - string
    doc: Number of genomes to pile at a time (or inf).
    inputBinding:
      position: 101
      prefix: --pile
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Plot timing data of database build.
    inputBinding:
      position: 101
      prefix: --plot
  - id: quicktree
    type:
      - 'null'
      - boolean
    doc: Use QuickTree for Neighbour-Joining algorithm.
    inputBinding:
      position: 101
      prefix: --quicktree
  - id: rank
    type:
      - 'null'
      - string
    doc: Rank at which to sort results.
    inputBinding:
      position: 101
      prefix: --rank
  - id: rapidnj
    type:
      - 'null'
      - boolean
    doc: Use RapidNJ for Neighbour-Joining algorithm.
    inputBinding:
      position: 101
      prefix: --rapidnj
  - id: sketch
    type:
      - 'null'
      - int
    doc: Sketch size for mash.
    inputBinding:
      position: 101
      prefix: --sketch
  - id: sourmash
    type:
      - 'null'
      - boolean
    doc: Use sourmash for distance estimation.
    inputBinding:
      position: 101
      prefix: --sourmash
  - id: taxonomy
    type:
      - 'null'
      - boolean
    doc: Convert phylogenetic results to taxonomic results.
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: truth
    type:
      - 'null'
      - Directory
    doc: Location of truth dataset.
    inputBinding:
      position: 101
      prefix: --truth
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Where to save classification results.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
