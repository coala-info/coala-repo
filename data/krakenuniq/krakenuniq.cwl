cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq
label: krakenuniq
doc: "KrakenUniq is a metagenomics classifier that assigns taxonomic labels to short
  DNA reads and uses unique k-mer counts to reduce false positives.\n\nTool homepage:
  https://github.com/fbreitwieser/krakenuniq"
inputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: Input sequence files (fasta or fastq, optionally gzip or bzip2 compressed; the format is detected automatically)
    inputBinding:
      position: 200
  - id: db
    type: Directory
    doc: Name of KrakenUniq database
    inputBinding:
      position: 102
      prefix: --db
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (default 1)
    inputBinding:
      position: 102
      prefix: --threads
  - id: hll_precision
    type:
      - 'null'
      - int
    doc: Precision for HyperLogLog k-mer cardinality estimation, between 10 and 18 (default 12)
    inputBinding:
      position: 102
      prefix: --hll-precision
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Compute exact cardinality instead of estimate (slower, requires memory proportional to cardinality)
    inputBinding:
      position: 102
      prefix: --exact
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Quick operation (use first hit or hits)
    inputBinding:
      position: 102
      prefix: --quick
  - id: min_hits
    type:
      - 'null'
      - int
    doc: In quick operation, number of hits required for classification; ignored if --quick is not specified
    inputBinding:
      position: 102
      prefix: --min-hits
  - id: unclassified_out
    type:
      - 'null'
      - string
    doc: Print unclassified sequences to this file name
    inputBinding:
      position: 102
      prefix: --unclassified-out
  - id: classified_out
    type:
      - 'null'
      - string
    doc: Print classified sequences to this file name
    inputBinding:
      position: 102
      prefix: --classified-out
  - id: only_classified_output
    type:
      - 'null'
      - boolean
    doc: Print no Kraken output for unclassified sequences
    inputBinding:
      position: 102
      prefix: --only-classified-output
  - id: preload
    type:
      - 'null'
      - boolean
    doc: Loads the entire DB into memory before classification
    inputBinding:
      position: 102
      prefix: --preload
  - id: preload_size
    type:
      - 'null'
      - string
    doc: Loads DB into memory in chunks of this size, e.g. 500M or 7G (if RAM is small); overrides --preload
    inputBinding:
      position: 102
      prefix: --preload-size
  - id: paired
    type:
      - 'null'
      - boolean
    doc: The two filenames provided are paired-end reads
    inputBinding:
      position: 102
      prefix: --paired
  - id: check_names
    type:
      - 'null'
      - boolean
    doc: Ensure each pair of reads have names that agree with each other; ignored if --paired is not specified
    inputBinding:
      position: 102
      prefix: --check-names
  - id: uid_mapping
    type:
      - 'null'
      - boolean
    doc: Map using UID database (experimental)
    inputBinding:
      position: 102
      prefix: --uid-mapping
  - id: output_path
    type:
      - 'null'
      - string
    doc: Print output to this file name (default stdout; "off" suppresses normal output)
    inputBinding:
      position: 103
      prefix: --output
  - id: report_file_path
    type: string
    doc: Print a report with aggregate counts per clade to this file name
    inputBinding:
      position: 104
      prefix: --report-file
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Per-read classification output
    outputBinding:
      glob: $(inputs.output_path)
  - id: report_file
    type: File
    doc: Report with aggregate counts per clade
    outputBinding:
      glob: $(inputs.report_file_path)
  - id: classified
    type:
      - 'null'
      - File
    doc: Classified sequences
    outputBinding:
      glob: $(inputs.classified_out)
  - id: unclassified
    type:
      - 'null'
      - File
    doc: Unclassified sequences
    outputBinding:
      glob: $(inputs.unclassified_out)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
