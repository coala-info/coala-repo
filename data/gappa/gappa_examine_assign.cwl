cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - examine
  - assign
label: gappa_examine_assign
doc: "Taxonomically assign placed query sequences and output tabulated summarization.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: jplace_path
    type:
      type: array
      items:
        - File
        - Directory
    doc: "List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed."
    inputBinding:
      position: 1
      prefix: --jplace-path
  - id: taxon_file
    type: File
    doc: "File containing a tab-separated list of reference taxon to taxonomic string assignments."
    inputBinding:
      position: 2
      prefix: --taxon-file
  - id: root_outgroup
    type: ['null', File]
    doc: "Root the tree by the outgroup taxa defined in the specified file."
    inputBinding:
      position: 3
      prefix: --root-outgroup
  - id: taxonomy
    type: ['null', File]
    doc: "EXPERIMENTAL: File containing a tab-separated list defining the taxonomy. If mapping is incomplete (for example if the output taxonomy shall be NCBI, but SILVA was used as the basis in the --taxon-file) a best-effort mapping is attempted."
    inputBinding:
      position: 4
      prefix: --taxonomy
  - id: ranks_string
    type: ['null', string]
    doc: "String specifying the rank names, in order, to which the taxonomy adheres. Required when using the CAMI output format. Assignments not adhereing to this constrained will be collapsed to the last valid mapping EXAMPLE: superkingdom|phylum|class|order|family|genus|species (Default: superkingdom|phylum|class|order|family|genus|species)"
    inputBinding:
      position: 5
      prefix: --ranks-string
  - id: sub_taxopath
    type: ['null', string]
    doc: "Taxopath (example: Eukaryota;Animalia;Chordata) by which the high level summary should be filtered. Doesn't affect intermediate results, and an unfiltered verison will be printed as well."
    inputBinding:
      position: 6
      prefix: --sub-taxopath
  - id: max_level
    type: ['null', int]
    doc: "Maximal level of the taxonomy to be printed. Default is 0, that is, the whole taxonomy is printed. If set to a value about 0, only this many levels are printed. That is, taxonomic levels below the specified one are omitted. (Default: 0)"
    inputBinding:
      position: 7
      prefix: --max-level
  - id: distribution_ratio
    type: ['null', float]
    doc: "Ratio by which LWR is split between annotations if an edge has two possible annotations. Specifies the amount going to the proximal annotation. If not set program will determine the ratio automatically from the 'distal length' specified per placement. (Default: -1; Range: [0 - 1])"
    inputBinding:
      position: 8
      prefix: --distribution-ratio
  - id: consensus_thresh
    type: ['null', float]
    doc: "For assignment of taxonomic labels to the reference tree, require this consensus threshold. Example: if set to 0.6, and 60% of an inner node's descendants share a taxonomic path, set that path at the inner node. (Default: 1; Range: [0 - 1])"
    inputBinding:
      position: 9
      prefix: --consensus-thresh
  - id: resolve_missing_paths
    type: ['null', boolean]
    doc: "Should the taxon file be incomplete and leave some taxa without taxopaths, fill in the missing node labels using the closest (in the tree) label. If not specified, those parts of the tree remain unlabelled, and their placements unassigned."
    inputBinding:
      position: 10
      prefix: --resolve-missing-paths
  - id: distant_label
    type: ['null', boolean]
    doc: "Take into account the pendant length of the placements, assigning the LWR to a new label called 'DISTANT' in proportion to the pendant length. Assigns no LWR to 'DISTANT' if the pednant length is below the insertion branch length, and assigns all LWR to 'DISTANT' is the pendant length exceeds the radius of the reference tree."
    inputBinding:
      position: 11
      prefix: --distant-label
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 12
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 13
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 14
      prefix: --file-suffix
  - id: cami
    type: ['null', boolean]
    doc: "EXPERIMENTAL: Print result in the CAMI Taxonomic Profiling Output Format. (Needs: --taxonomy)"
    inputBinding:
      position: 15
      prefix: --cami
  - id: sample_id
    type: ['null', string]
    doc: "Sample-ID string to be used in the CAMI output file (Needs: --cami)"
    inputBinding:
      position: 16
      prefix: --sample-id
  - id: krona
    type: ['null', boolean]
    doc: "Print result in the Krona text format."
    inputBinding:
      position: 17
      prefix: --krona
  - id: sativa
    type: ['null', boolean]
    doc: "Print result as SATIVA would."
    inputBinding:
      position: 18
      prefix: --sativa
  - id: per_query_results
    type: ['null', boolean]
    doc: "Print intermediate / per-query results (per_query.tsv)."
    inputBinding:
      position: 19
      prefix: --per-query-results
  - id: best_hit
    type: ['null', boolean]
    doc: "In the per-query results, only print the taxonomic path with the highest LWR."
    inputBinding:
      position: 20
      prefix: --best-hit
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 21
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 22
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 23
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 24
      prefix: --log-file
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory (--out-dir)."
    outputBinding:
      glob: "$(inputs.out_dir)"
  - id: log_file_out
    type: File?
    doc: "Log file written by --log-file."
    outputBinding:
      glob: "$(inputs.log_file)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
