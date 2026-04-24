cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll
label: krakenhll
doc: "Classify sequences using KrakenHLL\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: Input filenames
    inputBinding:
      position: 1
  - id: bzip2_compressed
    type:
      - 'null'
      - boolean
    doc: Input is bzip2 compressed
    inputBinding:
      position: 102
      prefix: --bzip2-compressed
  - id: check_names
    type:
      - 'null'
      - boolean
    doc: Ensure each pair of reads have names that agree with each other; 
      ignored if --paired is not specified
    inputBinding:
      position: 102
      prefix: --check-names
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name for Kraken DB
    inputBinding:
      position: 102
      prefix: --db
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: Input is FASTA format
    inputBinding:
      position: 102
      prefix: --fasta-input
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: Input is FASTQ format
    inputBinding:
      position: 102
      prefix: --fastq-input
  - id: gzip_compressed
    type:
      - 'null'
      - boolean
    doc: Input is gzip compressed
    inputBinding:
      position: 102
      prefix: --gzip-compressed
  - id: min_hits
    type:
      - 'null'
      - int
    doc: In quick op., number of hits req'd for classification
    inputBinding:
      position: 102
      prefix: --min-hits
  - id: only_classified_output
    type:
      - 'null'
      - boolean
    doc: Print no Kraken output for unclassified sequences
    inputBinding:
      position: 102
      prefix: --only-classified-output
  - id: paired
    type:
      - 'null'
      - boolean
    doc: The two filenames provided are paired-end reads
    inputBinding:
      position: 102
      prefix: --paired
  - id: precision
    type:
      - 'null'
      - int
    doc: Precision for unique k-mer counting, between 10 and 18
    inputBinding:
      position: 102
      prefix: --precision
  - id: preload
    type:
      - 'null'
      - boolean
    doc: Loads DB into memory before classification
    inputBinding:
      position: 102
      prefix: --preload
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Quick operation (use first hit or hits)
    inputBinding:
      position: 102
      prefix: --quick
  - id: report_file
    type: File
    doc: Output file for the report
    inputBinding:
      position: 102
      prefix: --report-file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: uid_mapping
    type:
      - 'null'
      - boolean
    doc: Map using UID database
    inputBinding:
      position: 102
      prefix: --uid-mapping
outputs:
  - id: unclassified_out
    type:
      - 'null'
      - File
    doc: Print unclassified sequences to filename
    outputBinding:
      glob: $(inputs.unclassified_out)
  - id: classified_out
    type:
      - 'null'
      - File
    doc: Print classified sequences to filename
    outputBinding:
      glob: $(inputs.classified_out)
  - id: output
    type:
      - 'null'
      - File
    doc: 'Print output to filename (default: stdout); "off" will suppress normal output'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
