cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - compare
  - insertion_sites
label: quatradis_tradis_compare_insertion_sites
doc: "Run an insertion site comparison for a specific plot file direction (forward, reverse, combined, original) over all experiments to produce a file including edgeR output (logfc, p and q values).\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: emblfile
    type: File
    doc: "Annotation file in EMBL format."
    inputBinding:
      position: 1
  - id: analysis_type
    type: string
    doc: "Analysis type: forward, reverse, combined, original."
    inputBinding:
      position: 2
  - id: controls
    type:
      type: array
      items: File
    doc: "Control plot files (optionally gzipped). There must be an equal number of condition and control files."
    inputBinding:
      position: 100
      prefix: --controls
  - id: conditions
    type:
      type: array
      items: File
    doc: "Condition plot files (optionally gzipped). There must be an equal number of condition and control files."
    inputBinding:
      position: 101
      prefix: --conditions
  - id: span_gaps
    type:
      - 'null'
      - int
    doc: "Span a gap if it is this multiple of a window size (default: 1)."
    inputBinding:
      position: 102
      prefix: --span_gaps
  - id: minimum_block
    type:
      - 'null'
      - int
    doc: "Minimum number of reads which must be in 1 block in comparison (default: 100)."
    inputBinding:
      position: 103
      prefix: --minimum_block
  - id: minimum_logfc
    type:
      - 'null'
      - float
    doc: "Minimum log fold change +/- (default: 1)."
    inputBinding:
      position: 104
      prefix: --minimum_logfc
  - id: minimum_logcpm
    type:
      - 'null'
      - float
    doc: "Minimum log counts per million +/- (default: 8.0)."
    inputBinding:
      position: 105
      prefix: --minimum_logcpm
  - id: minimum_proportion_insertions
    type:
      - 'null'
      - float
    doc: "Do not call decreased insertions below this proportion compared to control (default: 0.1)."
    inputBinding:
      position: 106
      prefix: --minimum_proportion_insertions
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output directory prefix."
    inputBinding:
      position: 107
      prefix: --prefix
  - id: pvalue
    type:
      - 'null'
      - float
    doc: "Do not report anything above this p-value (default: 0.05)."
    inputBinding:
      position: 108
      prefix: --pvalue
  - id: qvalue
    type:
      - 'null'
      - float
    doc: "Do not report anything above this q-value (default: 0.05)."
    inputBinding:
      position: 109
      prefix: --qvalue
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Window size (default: 100)."
    inputBinding:
      position: 110
      prefix: --window_size
  - id: dont_report_decreased_insertions
    type:
      - 'null'
      - boolean
    doc: "Do not report decreased insertions."
    inputBinding:
      position: 111
      prefix: --dont_report_decreased_insertions
  - id: genome_length
    type: int
    doc: "The length of the genome or sequence being analysed."
    inputBinding:
      position: 112
      prefix: --genome_length
  - id: profile
    type:
      - 'null'
      - boolean
    doc: "Turn on profiling."
    inputBinding:
      position: 100
      prefix: --profile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print out extra information about the process while it runs."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_out
    type:
      - 'null'
      - Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.prefix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_compare_insertion_sites.out
