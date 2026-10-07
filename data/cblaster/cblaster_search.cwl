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
    inputBinding:
      position: 101
      prefix: --gap
  - id: hitlist_size
    type:
      - 'null'
      - int
    doc: Maximum total hits to save from a local or remote BLAST search (def. 
      500). Setting this value too low may result in missed hits/clusters.
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
    inputBinding:
      position: 101
      prefix: --max_distance
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value for a BLAST hit to be saved (def. 0.01)
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
    inputBinding:
      position: 101
      prefix: --max_plot_clusters
  - id: maximum_clusters
    type:
      - 'null'
      - int
    doc: The maximum amount of clusters will get intermediate genes assigned. 
      Ordered on score (def. 100)
    inputBinding:
      position: 101
      prefix: --maximum_clusters
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum percent query coverage for a BLAST hit to be saved (def. 50)
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: min_hits
    type:
      - 'null'
      - int
    doc: Minimum number of hits in a cluster (def. 3)
    inputBinding:
      position: 101
      prefix: --min_hits
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum percent identity for a BLAST hit to be saved (def. 30)
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: mode
    type:
      - 'null'
      - string
    doc: cblaster search mode
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
    inputBinding:
      position: 101
      prefix: --unique
  - id: binary_path
    type:
      - 'null'
      - string
    doc: Generate a binary table.
    inputBinding:
      position: 102
      prefix: --binary
  - id: blast_file_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --blast_file
  - id: ipg_file_path
    type:
      - 'null'
      - string
    doc: Save IPG table to file (only if --mode remote)
    inputBinding:
      position: 104
      prefix: --ipg_file
  - id: output_path
    type:
      - 'null'
      - string
    doc: Write results to file
    inputBinding:
      position: 105
      prefix: --output
  - id: plot_path
    type:
      - 'null'
      - string
    doc: Generate a cblaster plot. If this argument is
    inputBinding:
      position: 106
      prefix: --plot
  - id: recompute_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 107
      prefix: --recompute
  - id: ncbi_email
    type:
      - 'null'
      - string
    doc: E-mail address for NCBI Entrez. cblaster refuses to start without an 
      e-mail or NCBI API key in its config file; this CWL writes that file 
      ($HOME/.config/cblaster/config.ini) from ncbi_email / ncbi_api_key.
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: NCBI API key written to the cblaster config file (alternative to 
      ncbi_email)
  - id: database_files
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - ^.sqlite3
    doc: Local databases for local/hmm/combi modes (DIAMOND .dmnd, or FASTA for
      hmm mode) with the cblaster <name>.sqlite3 beside each. They are staged 
      into the working directory and passed to --database by file name. Use 
      database for NCBI database names in remote mode.
    inputBinding:
      position: 101
      prefix: --database
      valueFrom: '$(self.map(function(f) { return f.basename; }))'
  - id: session_file_path
    type:
      - 'null'
      - string
    doc: Name of a new session JSON file to save the search results to (-s). 
      Use session_file instead to load existing sessions.
    inputBinding:
      position: 108
      prefix: --session_file
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write results to file
    outputBinding:
      glob: $(inputs.output_path)
  - id: binary
    type:
      - 'null'
      - File
    doc: Generate a binary table.
    outputBinding:
      glob: $(inputs.binary_path)
  - id: plot
    type:
      - 'null'
      - File
    doc: Generate a cblaster plot. If this argument is specified with no file 
      name, the plot will be served using Python's HTTP server. If a file name 
      is specified, a static HTML file will be generated at that path.
    outputBinding:
      glob: $(inputs.plot_path)
  - id: blast_file
    type:
      - 'null'
      - File
    doc: Save BLAST/DIAMOND hit table to file
    outputBinding:
      glob: $(inputs.blast_file_path)
  - id: ipg_file
    type:
      - 'null'
      - File
    doc: Save IPG table to file (only if --mode remote)
    outputBinding:
      glob: $(inputs.ipg_file_path)
  - id: recompute
    type:
      - 'null'
      - File
    doc: Recompute previous search session using new thresholds. The filtered 
      session will be written to the file specified by this argument. If this 
      argument is specified with no value, the session will be filtered but not 
      saved (e.g. for plotting purposes).
    outputBinding:
      glob: $(inputs.recompute_path)
  - id: session
    type:
      - 'null'
      - File
    doc: New session JSON file
    outputBinding:
      glob: $(inputs.session_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ var s = "[cblaster]\n"; if (inputs.ncbi_email) { s += "email = " + inputs.ncbi_email + "\n"; } if (inputs.ncbi_api_key) { s += "api_key = " + inputs.ncbi_api_key + "\n"; } return {"class": "Directory", "basename": ".config", "listing": [{"class": "Directory", "basename": "cblaster", "listing": [{"class": "File", "basename": "config.ini", "contents": s}]}]}; }
      - |-
        ${ var l = []; if (inputs.database_files) { inputs.database_files.forEach(function(f) { l.push(f); (f.secondaryFiles || []).forEach(function(x) { l.push(x); }); }); } return l; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
    dockerOutputDirectory: /cblaster
