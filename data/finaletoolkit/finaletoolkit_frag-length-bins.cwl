cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-frag-length-bins
label: finaletoolkit_frag-length-bins
doc: "Retrieves fragment lengths grouped in bins given a BAM/CRAM/Fragment file.\n\
  \nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: input_file
    type: File
    doc: Path to a BAM/CRAM/Fragment file containing fragment data.
    inputBinding:
      position: 1
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Specify the size of the bins to group fragment lengths into.
    inputBinding:
      position: 102
      prefix: --bin-size
  - id: contig
    type:
      - 'null'
      - string
    doc: Specify the contig or chromosome to select fragments from. (Required if
      using --start or --stop.)
    inputBinding:
      position: 102
      prefix: --contig
  - id: histogram_path
    type:
      - 'null'
      - Directory
    doc: Path to store histogram if specified.
    inputBinding:
      position: 102
      prefix: --histogram-path
  - id: intersect_policy
    type:
      - 'null'
      - string
    doc: Specifies what policy is used to include fragments in the given 
      interval. See User Guide for more information.
    inputBinding:
      position: 102
      prefix: --intersect-policy
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length for a fragment to be included in fragment length.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length for a fragment to be included in fragment length.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Minimum mapping quality threshold.
    inputBinding:
      position: 102
      prefix: --quality-threshold
  - id: short_fraction
    type:
      - 'null'
      - float
    doc: When specified, a short fraction is included in summary statistics.
    inputBinding:
      position: 102
      prefix: --short-fraction
  - id: start
    type:
      - 'null'
      - int
    doc: Specify the 0-based left-most coordinate of the interval to select 
      fragments from. (Must also specify --contig.)
    inputBinding:
      position: 102
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: Specify the 1-based right-most coordinate of the interval to select 
      fragments from. (Must also specify --contig.)
    inputBinding:
      position: 102
      prefix: --stop
  - id: summary_stats
    type:
      - 'null'
      - boolean
    doc: 'Include summary statistics at the bottom of the output tsv as comment lines
      (e.g. #max: 100)'
    inputBinding:
      position: 102
      prefix: --summary-stats
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode to display detailed processing information.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: A .TSV file containing containing fragment lengths binned according to 
      the specified bin size.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
