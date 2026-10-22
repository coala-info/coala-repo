cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr-outliers.py
label: superstr_superstr-outliers.py
doc: "Detect outlier samples for repeat motifs in a set of superSTR runs (bootstrapped percentile estimates on repeat metrics).\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs:
  - id: input_path
    type: Directory
    doc: Input path; should be a directory containing one or more superSTR runs (output of superstr-multiparse.py)
    inputBinding:
      position: 1
      prefix: -i
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output path for files. If not set, output to stdout.
    inputBinding:
      position: 2
      prefix: -o
  - id: manifest
    type:
      - 'null'
      - File
    doc: Path to manifest file (optional)
    inputBinding:
      position: 3
      prefix: -m
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose mode.
    inputBinding:
      position: 4
      prefix: --verbose
  - id: pathogenic
    type:
      - 'null'
      - boolean
    doc: Perform outlier detection in only known pathogenic motifs.
    inputBinding:
      position: 5
      prefix: --pathogenic
  - id: max_motif
    type:
      - 'null'
      - int
    doc: Set the maximum motif length to run outlier calculations to.
    inputBinding:
      position: 6
      prefix: --max_motif
  - id: motifs
    type:
      - 'null'
      - File
    doc: Path to a file containing motifs of interest; one line per motif.
    inputBinding:
      position: 7
      prefix: --motifs
  - id: bootstrap_ci
    type:
      - 'null'
      - boolean
    doc: Generate outlier calls against a specified the 95% CI estimate of a percentile using the ABC bootstrap
    inputBinding:
      position: 8
      prefix: --bootstrapCI
  - id: percentile
    type:
      - 'null'
      - float
    doc: Percentile for estimation; must be between 0.0 and 1.0
    inputBinding:
      position: 9
      prefix: -pc
  - id: lower_bound
    type:
      - 'null'
      - boolean
    doc: Use lower-bound of 95% CI estimate (default is to use upper)
    inputBinding:
      position: 10
      prefix: -lb
  - id: read_length
    type:
      - 'null'
      - int
    doc: Manually set read length.
    inputBinding:
      position: 11
      prefix: --rl
  - id: control_label
    type:
      - 'null'
      - string
    doc: Label for control data
    inputBinding:
      position: 12
      prefix: --controllab
  - id: failover
    type:
      - 'null'
      - boolean
    doc: Automatically fail over to the percentile bootstrap.
    inputBinding:
      position: 13
      prefix: --failover
  - id: info_score
    type:
      - 'null'
      - boolean
    doc: Test for outliers in size-weighted repeat score
    inputBinding:
      position: 14
      prefix: --info_score
  - id: max_length
    type:
      - 'null'
      - boolean
    doc: Test for outliers in max-length reads only
    inputBinding:
      position: 15
      prefix: --max_length
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length for information score calculation
    inputBinding:
      position: 16
      prefix: --min_len
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length for information score calculation
    inputBinding:
      position: 17
      prefix: --max_len
outputs:
  - id: stdout
    type: stdout
    doc: Outlier calls (when no output path is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Outlier calls written to the output path
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
stdout: superstr_superstr-outliers.py.out
