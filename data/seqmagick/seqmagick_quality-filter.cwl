cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmagick quality-filter
label: seqmagick_quality-filter
doc: "Filter reads based on quality scores\n\nTool homepage: http://github.com/fhcrc/seqmagick"
inputs:
  - id: sequence_file
    type: File
    doc: Input fastq file. A fasta-format file may also be provided if 
      --input-qual is also specified.
    inputBinding:
      position: 1
  - id: output_file
    type: File
    doc: Output file. Format determined from extension.
    inputBinding:
      position: 2
  - id: ambiguous_action
    type:
      - 'null'
      - string
    doc: Action to take on ambiguous base in sequence (N's).
    default: no action
    inputBinding:
      position: 103
      prefix: --ambiguous-action
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: CSV file containing sample_id,barcode[,primer] in the rows. A single 
      primer for all sequences may be specified with `--primer`, or 
      `--no-primer` may be used to indicate barcodes should be used without a 
      primer check.
    inputBinding:
      position: 103
      prefix: --barcode-file
  - id: barcode_header
    type:
      - 'null'
      - boolean
    doc: Barcodes have a header row
    default: false
    inputBinding:
      position: 103
      prefix: --barcode-header
  - id: input_qual
    type:
      - 'null'
      - File
    doc: The quality scores associated with the input file. Only used if input 
      file is fasta.
    inputBinding:
      position: 103
      prefix: --input-qual
  - id: max_ambiguous
    type:
      - 'null'
      - int
    doc: Maximum number of ambiguous bases in a sequence. Sequences exceeding 
      this count will be removed.
    inputBinding:
      position: 103
      prefix: --max-ambiguous
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length to keep before truncating. This operation occurs before 
      --max-ambiguous
    default: 1000
    inputBinding:
      position: 103
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length to keep sequence
    default: 200
    inputBinding:
      position: 103
      prefix: --min-length
  - id: min_mean_quality
    type:
      - 'null'
      - float
    doc: Minimum mean quality score for each read
    default: 25.0
    inputBinding:
      position: 103
      prefix: --min-mean-quality
  - id: no_details_comment
    type:
      - 'null'
      - boolean
    doc: Do not write comment lines with version and call to start --details-out
    inputBinding:
      position: 103
      prefix: --no-details-comment
  - id: no_primer
    type:
      - 'null'
      - boolean
    doc: Do not use a primer.
    inputBinding:
      position: 103
      prefix: --no-primer
  - id: pct_ambiguous
    type:
      - 'null'
      - float
    doc: Maximun percent of ambiguous bases in a sequence. Sequences exceeding 
      this percent will be removed.
    inputBinding:
      position: 103
      prefix: --pct-ambiguous
  - id: primer
    type:
      - 'null'
      - string
    doc: IUPAC ambiguous primer to require
    inputBinding:
      position: 103
      prefix: --primer
  - id: quality_window
    type:
      - 'null'
      - int
    doc: Window size for truncating sequences. When set to a non-zero value, 
      sequences are truncated where the mean mean quality within the window 
      drops below --min-mean-quality.
    default: 0
    inputBinding:
      position: 103
      prefix: --quality-window
  - id: quality_window_mean_qual
    type:
      - 'null'
      - float
    doc: Minimum quality score within the window defined by --quality-window.
    inputBinding:
      position: 103
      prefix: --quality-window-mean-qual
  - id: quality_window_prop
    type:
      - 'null'
      - float
    doc: Proportion of reads within quality window to that must pass filter.
    default: 1.0
    inputBinding:
      position: 103
      prefix: --quality-window-prop
  - id: quoting
    type:
      - 'null'
      - string
    doc: A string naming an attribute of the csv module defining the quoting 
      behavior for `SAMPLE_MAP`.
    default: QUOTE_MINIMAL
    inputBinding:
      position: 103
      prefix: --quoting
outputs:
  - id: report_out
    type:
      - 'null'
      - File
    doc: Output file for report
    outputBinding:
      glob: $(inputs.report_out)
  - id: details_out
    type:
      - 'null'
      - File
    doc: Output file to report fate of each sequence
    outputBinding:
      glob: $(inputs.details_out)
  - id: map_out
    type:
      - 'null'
      - File
    doc: Path to write sequence_id,sample_id pairs
    outputBinding:
      glob: $(inputs.map_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
