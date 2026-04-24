cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken
label: kraken
doc: "Need to specify input filenames!\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: Input filename(s)
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
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: Output in FASTQ format
    inputBinding:
      position: 102
      prefix: --fastq-output
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
  - id: out_fmt
    type:
      - 'null'
      - string
    doc: 'Format for [un]classified sequence output. supported options are: {legacy,
      paired, interleaved}'
    inputBinding:
      position: 102
      prefix: --out-fmt
  - id: paired
    type:
      - 'null'
      - boolean
    doc: The two filenames provided are paired-end reads
    inputBinding:
      position: 102
      prefix: --paired
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
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
    doc: 'Print output to filename (default: stdout); "-" will suppress normal output'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
