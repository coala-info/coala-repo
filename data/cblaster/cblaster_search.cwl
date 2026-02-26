cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cblaster
  - search
label: cblaster_search
doc: "Remote/local cblaster searches.\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: binary_attr
    type:
      - 'null'
      - string
    doc: Hit attribute used when generating binary table cell values.
    default: identity
    inputBinding:
      position: 101
      prefix: --binary_attr
  - id: binary_decimals
    type:
      - 'null'
      - int
    doc: Total decimal places to use when printing score values
    inputBinding:
      position: 101
      prefix: --binary_decimals
  - id: binary_delimiter
    type:
      - 'null'
      - string
    doc: Delimiter used in binary table (def. none = human readable).
    inputBinding:
      position: 101
      prefix: --binary_delimiter
  - id: binary_hide_headers
    type:
      - 'null'
      - boolean
    doc: Hide headers in the binary table.
    inputBinding:
      position: 101
      prefix: --binary_hide_headers
  - id: binary_key
    type:
      - 'null'
      - string
    doc: Key function used when generating binary table cell values.
    default: len
    inputBinding:
      position: 101
      prefix: --binary_key
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use in local search. By default, all available cores 
      will be used.
    inputBinding:
      position: 101
      prefix: --cpus
  - id: database
    type:
      - 'null'
      - type: array
        items: string
    doc: "Database to be searched. Remote search mode: NCBI database name (def. 'nr');
      local search mode: path to DIAMOND database; HMM search mode: path to FASTA
      file. In local/hmm/combined modes, must have cblaster database in same location
      with same name and .sqlite3 extension."
    default: nr
    inputBinding:
      position: 101
      prefix: --database
  - id: database_pfam
    type:
      - 'null'
      - Directory
    doc: Path to folder containing Pfam database files (Pfam-A.hmm.gz and 
      Pfam-A.dat.gz). If not found, cblaster will download the latest Pfam 
      release to this folder. This option is required when running HMM or combi 
      search modes.
    inputBinding:
      position: 101
      prefix: --database_pfam
  - id: dmnd_sensitivity
    type:
      - 'null'
      - string
    doc: Level of sensitivity to use in local DIAMOND searches (def. 'fast')
    default: fast
    inputBinding:
      position: 101
      prefix: --dmnd_sensitivity
  - id: entrez_query
    type:
      - 'null'
      - string
    doc: An NCBI Entrez search term for pre-search filtering of an NCBI database
      when using command line BLASTp (i.e. only used if 'remote' is passed to 
      --mode); e.g. "Aspergillus"[organism]
    inputBinding:
      position: 101
      prefix: --entrez_query
  - id: gap
    type:
      - 'null'
      - int
    doc: Maximum allowed intergenic distance (bp) between conserved hits to be 
      considered in the same block (def. 20000)
    default: 20000
    inputBinding:
      position: 101
      prefix: --gap
  - id: hitlist_size
    type:
      - 'null'
      - int
    doc: Maximum total hits to save from a local or remote BLAST search (def. 
      500). Setting this value too low may result in missed hits/clusters.
    default: 500
    inputBinding:
      position: 101
      prefix: --hitlist_size
  - id: intermediate_genes
    type:
      - 'null'
      - boolean
    doc: Show genes that in or near clusters but not part of the cluster. This 
      takes some extra computation time.
    inputBinding:
      position: 101
      prefix: --intermediate_genes
  - id: max_distance
    type:
      - 'null'
      - int
    doc: The maximum distance between the start/end of a cluster and an 
      intermediate gene (def. 5000)
    default: 5000
    inputBinding:
      position: 101
      prefix: --max_distance
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value for a BLAST hit to be saved (def. 0.01)
    default: 0.01
    inputBinding:
      position: 101
      prefix: --max_evalue
  - id: max_plot_clusters
    type:
      - 'null'
      - int
    doc: The maximum amount of clusters included in the plot when sorting 
      clusters on score, meaning -osc has to be used for this argument to take 
      effect. (def 50)
    default: 50
    inputBinding:
      position: 101
      prefix: --max_plot_clusters
  - id: maximum_clusters
    type:
      - 'null'
      - int
    doc: The maximum amount of clusters will get intermediate genes assigned. 
      Ordered on score (def. 100)
    default: 100
    inputBinding:
      position: 101
      prefix: --maximum_clusters
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum percent query coverage for a BLAST hit to be saved (def. 50)
    default: 50
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: min_hits
    type:
      - 'null'
      - int
    doc: Minimum number of hits in a cluster (def. 3)
    default: 3
    inputBinding:
      position: 101
      prefix: --min_hits
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum percent identity for a BLAST hit to be saved (def. 30)
    default: 30
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: mode
    type:
      - 'null'
      - string
    doc: cblaster search mode
    default: local
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_decimals
    type:
      - 'null'
      - int
    doc: Total decimal places to use when printing score values
    inputBinding:
      position: 101
      prefix: --output_decimals
  - id: output_delimiter
    type:
      - 'null'
      - string
    doc: Delimiter character to use when printing result output.
    inputBinding:
      position: 101
      prefix: --output_delimiter
  - id: output_hide_headers
    type:
      - 'null'
      - boolean
    doc: Hide headers when printing result output.
    inputBinding:
      position: 101
      prefix: --output_hide_headers
  - id: percentage
    type:
      - 'null'
      - float
    doc: Percentage of query genes required to be present in cluster
    inputBinding:
      position: 101
      prefix: --percentage
  - id: query_file
    type:
      - 'null'
      - File
    doc: Path to FASTA file containing protein sequences to be searched
    inputBinding:
      position: 101
      prefix: --query_file
  - id: query_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: A collection of valid NCBI sequence identifiers to be searched
    inputBinding:
      position: 101
      prefix: --query_ids
  - id: query_profiles
    type:
      - 'null'
      - type: array
        items: string
    doc: A collection of valid Pfam profile identifiers to be searched
    inputBinding:
      position: 101
      prefix: --query_profiles
  - id: require
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of query sequences that must be represented in a hit cluster
    inputBinding:
      position: 101
      prefix: --require
  - id: rid
    type:
      - 'null'
      - string
    doc: Request Identifier (RID) for a web BLAST search. This is only used if 
      'remote' is passed to --mode. Useful if you have previously run a web 
      BLAST search and want to directly retrieve those results instead of 
      running a new search.
    inputBinding:
      position: 101
      prefix: --rid
  - id: session_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Load session from JSON. If the specified file does not exist, the 
      results of the new search will be saved to this file.
    inputBinding:
      position: 101
      prefix: --session_file
  - id: sort_clusters
    type:
      - 'null'
      - boolean
    doc: Sorts the clusters of the final output on score. This means that 
      clusters of the same organism are not neccesairily close together in the 
      output.
    inputBinding:
      position: 101
      prefix: --sort_clusters
  - id: unique
    type:
      - 'null'
      - int
    doc: Minimum number of unique query sequences that must be conserved in a 
      hit cluster (def. 3)
    default: 3
    inputBinding:
      position: 101
      prefix: --unique
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write results to file
    outputBinding:
      glob: $(inputs.output)
  - id: binary
    type:
      - 'null'
      - File
    doc: Generate a binary table.
    outputBinding:
      glob: $(inputs.binary)
  - id: plot
    type:
      - 'null'
      - File
    doc: Generate a cblaster plot. If this argument is specified with no file 
      name, the plot will be served using Python's HTTP server. If a file name 
      is specified, a static HTML file will be generated at that path.
    outputBinding:
      glob: $(inputs.plot)
  - id: blast_file
    type:
      - 'null'
      - File
    doc: Save BLAST/DIAMOND hit table to file
    outputBinding:
      glob: $(inputs.blast_file)
  - id: ipg_file
    type:
      - 'null'
      - File
    doc: Save IPG table to file (only if --mode remote)
    outputBinding:
      glob: $(inputs.ipg_file)
  - id: recompute
    type:
      - 'null'
      - File
    doc: Recompute previous search session using new thresholds. The filtered 
      session will be written to the file specified by this argument. If this 
      argument is specified with no value, the session will be filtered but not 
      saved (e.g. for plotting purposes).
    outputBinding:
      glob: $(inputs.recompute)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
