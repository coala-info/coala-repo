cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - stats
label: seqfu_stats
doc: "Statistics on sequence lengths\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA/FASTQ files
    inputBinding:
      position: 1
  - id: abs_path
    type:
      - 'null'
      - boolean
    doc: Print absolute paths
    inputBinding:
      position: 102
      prefix: --abs-path
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Print only filenames
    inputBinding:
      position: 102
      prefix: --basename
  - id: nice
    type:
      - 'null'
      - boolean
    doc: Print nice terminal table
    inputBinding:
      position: 102
      prefix: --nice
  - id: json
    type:
      - 'null'
      - boolean
    doc: Print json (EXPERIMENTAL)
    inputBinding:
      position: 102
      prefix: --json
  - id: sort_by
    type:
      - 'null'
      - string
    doc: 'Sort by KEY from: filename, counts, n50, tot, avg, min, max [default: none]'
    inputBinding:
      position: 102
      prefix: --sort-by
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse sort order
    inputBinding:
      position: 102
      prefix: --reverse
  - id: thousands
    type:
      - 'null'
      - boolean
    doc: Add thousands separator (only tabbed/nice output)
    inputBinding:
      position: 102
      prefix: --thousands
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Separate output by commas instead of tabs
    inputBinding:
      position: 102
      prefix: --csv
  - id: gc
    type:
      - 'null'
      - boolean
    doc: Also print %GC
    inputBinding:
      position: 102
      prefix: --gc
  - id: index
    type:
      - 'null'
      - boolean
    doc: Also print contig index (L50, L90)
    inputBinding:
      position: 102
      prefix: --index
  - id: multiqc_path
    type:
      - 'null'
      - string
    doc: 'Saves a MultiQC report to FILE (suggested: name_mqc.txt)'
    inputBinding:
      position: 102
      prefix: --multiqc
  - id: precision
    type:
      - 'null'
      - int
    doc: 'Number of decimal places to round to [default: 2]'
    inputBinding:
      position: 102
      prefix: --precision
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: Do not print header
    inputBinding:
      position: 102
      prefix: --noheader
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: multiqc_report
    type:
      - 'null'
      - File
    doc: MultiQC report
    outputBinding:
      glob: $(inputs.multiqc_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_stats.out
