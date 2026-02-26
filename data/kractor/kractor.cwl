cwlVersion: v1.2
class: CommandLineTool
baseCommand: kractor
label: kractor
doc: "Extract reads from a FASTQ file based on taxonomic classification via Kraken2.\n\
  \nTool homepage: https://github.com/Sam-Sims/kractor"
inputs:
  - id: children
    type:
      - 'null'
      - boolean
    doc: Include all child taxon IDs in the output. Requires a Kraken2 report 
      file
    inputBinding:
      position: 101
      prefix: --children
  - id: compression_format
    type:
      - 'null'
      - string
    doc: Compression format for output files (gz, bz2). Overides the inferred 
      format
    inputBinding:
      position: 101
      prefix: --compression-format
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level (1-9)
    default: 2
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified taxon IDs from the output
    inputBinding:
      position: 101
      prefix: --exclude
  - id: input
    type:
      type: array
      items: File
    doc: Input file path(s). Accepts up to 2 files (for paired-end reads)
    inputBinding:
      position: 101
      prefix: --input
  - id: kraken
    type: File
    doc: Kraken2 stdout file path
    inputBinding:
      position: 101
      prefix: --kraken
  - id: no_header_detect
    type:
      - 'null'
      - boolean
    doc: Disable detection and skipping of any header lines in the Kraken2 
      report
    inputBinding:
      position: 101
      prefix: --no-header-detect
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Output results in FASTA format
    inputBinding:
      position: 101
      prefix: --output-fasta
  - id: parents
    type:
      - 'null'
      - boolean
    doc: Include all parent taxon IDs in the output. Requires a Kraken2 report 
      file
    inputBinding:
      position: 101
      prefix: --parents
  - id: report
    type:
      - 'null'
      - File
    doc: Kraken2 report file path
    inputBinding:
      position: 101
      prefix: --report
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Enable a JSON summary output written to stdout
    inputBinding:
      position: 101
      prefix: --summary
  - id: taxid
    type:
      type: array
      items: string
    doc: One or more taxon IDs to extract reads for
    inputBinding:
      position: 101
      prefix: --taxid
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output file path(s). Accepts up to 2 files (for paired-end reads)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kractor:4.0.0--h4349ce8_0
