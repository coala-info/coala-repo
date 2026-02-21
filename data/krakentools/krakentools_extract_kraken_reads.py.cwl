cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_kraken_reads.py
label: krakentools_extract_kraken_reads.py
doc: "Extract reads from Kraken2 output based on taxonomic IDs. Supports both single-end
  and paired-end reads.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Extract reads NOT classified at the specified taxid
    inputBinding:
      position: 101
      prefix: --exclude
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: Print output in FASTQ format instead of FASTA
    inputBinding:
      position: 101
      prefix: --fastq-output
  - id: include_children
    type:
      - 'null'
      - boolean
    doc: Include reads classified at sub-levels of the specified taxid
    inputBinding:
      position: 101
      prefix: --include-children
  - id: kraken_file
    type: File
    doc: Kraken output file
    inputBinding:
      position: 101
      prefix: --kraken
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to extract
    inputBinding:
      position: 101
      prefix: --max
  - id: report_file
    type:
      - 'null'
      - File
    doc: Kraken report file (required if using --include-children)
    inputBinding:
      position: 101
      prefix: --report
  - id: seq_file1
    type: File
    doc: First sequence file (FASTA/FASTQ)
    inputBinding:
      position: 101
      prefix: -s1
  - id: seq_file2
    type:
      - 'null'
      - File
    doc: Second sequence file (FASTA/FASTQ) for paired-end reads
    inputBinding:
      position: 101
      prefix: -s2
  - id: taxid
    type:
      type: array
      items: string
    doc: Taxon ID(s) to extract (space-separated)
    inputBinding:
      position: 101
      prefix: --taxid
outputs:
  - id: output_file
    type: File
    doc: Output file for extracted reads
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_file2
    type:
      - 'null'
      - File
    doc: Output file for second set of paired-end reads
    outputBinding:
      glob: $(inputs.output_file2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
