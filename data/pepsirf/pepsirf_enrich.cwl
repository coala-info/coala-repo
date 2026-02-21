cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - enrich
label: pepsirf_enrich
doc: "The enrich module determines which peptides are enriched in samples that have
  been assayed in n-replicate, as determined by user-specified thresholds.\n\nTool
  homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: join_on
    type:
      - 'null'
      - string
    doc: A character or string to use to join replicate sample names in order to create
      output file names.
    default: '~'
    inputBinding:
      position: 101
      prefix: --join_on
  - id: low_raw_reads
    type:
      - 'null'
      - boolean
    doc: By default samples with any replicates below the raw read threshold will
      be dropped; when this flag is included, replicates with reads above the threshold
      will be kept.
    inputBinding:
      position: 101
      prefix: --low_raw_reads
  - id: outfile_suffix
    type:
      - 'null'
      - string
    doc: Suffix to add to all output files (e.g., '_enriched.txt').
    inputBinding:
      position: 101
      prefix: --outfile_suffix
  - id: output_filename_truncate
    type:
      - 'null'
      - boolean
    doc: If more than two replicates are evaluated, stop filenames from including
      more than 3 samplenames (e.g., 'A~B~C~1more').
    inputBinding:
      position: 101
      prefix: --output_filename_truncate
  - id: raw_score_constraint
    type:
      - 'null'
      - int
    doc: The minimum total raw count across all peptides for a sample to be included
      in the analysis.
    inputBinding:
      position: 101
      prefix: --raw_score_constraint
  - id: raw_scores
    type:
      - 'null'
      - File
    doc: Optionally, a tab-delimited matrix containing raw counts can be provided.
      If included, '--raw_score_constraint' must also be specified.
    inputBinding:
      position: 101
      prefix: --raw_scores
  - id: samples
    type:
      - 'null'
      - File
    doc: The name of the tab-delimited file containing sample information, denoting
      which samples, in the input matrices, are replicates.
    inputBinding:
      position: 101
      prefix: --samples
  - id: threshold_file
    type:
      - 'null'
      - File
    doc: The name of a tab-delimited file containing one tab-delimited matrix filename
      and threshold(s), one per line. If using more than one threshold for a given
      matrix, then separate by comma.
    inputBinding:
      position: 101
      prefix: --threshhold_file
outputs:
  - id: enrichment_failure_reason
    type:
      - 'null'
      - File
    doc: File containing reasons why specific sample sets did not result in enriched
      peptide files. Output to the same directory as enriched peptide files.
    outputBinding:
      glob: $(inputs.enrichment_failure_reason)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory name to which output files will be written.
    outputBinding:
      glob: $(inputs.output_directory)
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
