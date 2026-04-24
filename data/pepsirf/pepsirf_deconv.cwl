cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - deconv
label: pepsirf_deconv
doc: "The deconv module converts a list of enriched peptides into a parsimony-based
  list of likely taxa to which the assayed individual has likely been exposed. It
  supports both batch and singular modes.\n\nTool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: custom_id_name_map_info
    type:
      - 'null'
      - string
    doc: 'Optional file containing mappings from taxonomic IDs to taxon names. Format:
      filename,key_column,value_column.'
    inputBinding:
      position: 101
      prefix: --custom_id_name_map_info
  - id: enriched
    type: File
    doc: Name of a directory containing files, or a single file containing the names
      of enriched peptides, one per line.
    inputBinding:
      position: 101
      prefix: --enriched
  - id: enriched_file_ending
    type:
      - 'null'
      - string
    doc: Optional flag that specifies what string is expected at the end of each file
      containing enriched peptides.
    inputBinding:
      position: 101
      prefix: --enriched_file_ending
  - id: id_name_map
    type:
      - 'null'
      - File
    doc: Optional file containing mappings from taxonomic ID to taxon name (NCBI rankedlineage.dmp
      format).
    inputBinding:
      position: 101
      prefix: --id_name_map
  - id: linked
    type: File
    doc: Name of linkage map to be used for deconvolution. It should be in the format
      output by the 'link' module.
    inputBinding:
      position: 101
      prefix: --linked
  - id: mapfile_suffix
    type:
      - 'null'
      - string
    doc: Used for batch mode only. When specified, the name of each '--peptide_assignment_map'
      will have this suffix.
    inputBinding:
      position: 101
      prefix: --mapfile_suffix
  - id: outfile_suffix
    type:
      - 'null'
      - string
    doc: Used for batch mode only. When specified, the name of each file written to
      the output directory will have this suffix.
    inputBinding:
      position: 101
      prefix: --outfile_suffix
  - id: remove_file_types
    type:
      - 'null'
      - boolean
    doc: Use this flag to exclude input file ('--enrich') extensions from the names
      of output files. Not used in singular mode.
    inputBinding:
      position: 101
      prefix: --remove_file_types
  - id: score_filtering
    type:
      - 'null'
      - boolean
    doc: Include this option if you want filtering to be done by the score of each
      taxon, rather than the count of linked peptides.
    inputBinding:
      position: 101
      prefix: --score_filtering
  - id: score_overlap_threshold
    type:
      - 'null'
      - float
    doc: Threshold for evaluating ties. Values [1, inf) for integer evaluation, (0,1)
      for ratio evaluation.
    inputBinding:
      position: 101
      prefix: --score_overlap_threshold
  - id: score_tie_threshold
    type:
      - 'null'
      - float
    doc: Threshold for two species to be evaluated as a tie. Can be an integer or
      a ratio in (0,1).
    inputBinding:
      position: 101
      prefix: --score_tie_threshold
  - id: scoring_strategy
    type:
      - 'null'
      - string
    doc: Scoring strategies "summation", "integer", or "fraction" can be specified.
    inputBinding:
      position: 101
      prefix: --scoring_strategy
  - id: single_threaded
    type:
      - 'null'
      - boolean
    doc: By default this module uses two threads. Include this option with no arguments
      if you only want only one thread to be used.
    inputBinding:
      position: 101
      prefix: --single_threaded
  - id: thresholds
    type:
      - 'null'
      - File
    doc: Filepath to tab delimited file with a TaxID column and a score threshold
      for that TaxID.
    inputBinding:
      position: 101
      prefix: --thresholds
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name for the output directory or file. Output will be in the form of either
      one file or a directory containing files.
    outputBinding:
      glob: $(inputs.output)
  - id: scores_per_round
    type:
      - 'null'
      - Directory
    doc: Optional. Name of directory to write counts/scores to after every round.
    outputBinding:
      glob: $(inputs.scores_per_round)
  - id: peptide_assignment_map
    type:
      - 'null'
      - File
    doc: Optional output. If specified, a map detailing which peptides were assigned
      to which taxa will be written.
    outputBinding:
      glob: $(inputs.peptide_assignment_map)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
