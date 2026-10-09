cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken2-inspect
label: kraken2_inspect
doc: "Inspect a Kraken 2 database: print the taxa and minimizer counts it holds.\n\nTool homepage: https://github.com/DerrickWood/kraken2"
inputs:
  - id: db
    type: Directory
    doc: Kraken 2 DB folder
    inputBinding:
      position: 1
      prefix: --db
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 2
      prefix: --threads
  - id: skip_counts
    type:
      - 'null'
      - boolean
    doc: Only print database summary statistics
    inputBinding:
      position: 3
      prefix: --skip-counts
  - id: use_mpa_style
    type:
      - 'null'
      - boolean
    doc: Format output like Kraken 1's kraken-mpa-report
    inputBinding:
      position: 4
      prefix: --use-mpa-style
  - id: report_zero_counts
    type:
      - 'null'
      - boolean
    doc: Report counts for ALL taxa, even if counts are zero
    inputBinding:
      position: 5
      prefix: --report-zero-counts
outputs:
  - id: stdout
    type: stdout
    doc: Database inspection report
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kraken2:2.17.1--pl5321h077b44d_0
stdout: kraken2_inspect.txt
