cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-reformatter
label: vcf-reformatter
doc: "A Rust command-line tool for parsing and reformatting VCF (Variant Call Format)
  files, with support for VEP (Variant Effect Predictor) and SnpEff annotations. This
  tool flattens complex VCF files into tab-separated values (TSV) or Mutation Annotation
  Format (MAF) for easier downstream analysis.\n\nTool homepage: https://github.com/flalom/vcf-reformatter"
inputs:
  - id: input_file
    type: File
    doc: Input VCF file (supports .vcf.gz compressed files)
    inputBinding:
      position: 1
  - id: annotation_type
    type:
      - 'null'
      - string
    doc: "Annotation type to parse. Possible values:\n          - vep:    VEP annotations
      (CSQ field)\n          - snpeff: SnpEff annotations (ANN field)\n          -
      auto:   Auto-detect from header"
    default: auto
    inputBinding:
      position: 102
      prefix: --annotation-type
  - id: center
    type:
      - 'null'
      - string
    doc: Center name for MAF output (auto-detected from header if not provided)
    inputBinding:
      position: 102
      prefix: --center
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output files with gzip
    inputBinding:
      position: 102
      prefix: --compress
  - id: ncbi_build
    type:
      - 'null'
      - string
    doc: NCBI build for MAF output (auto-detected from header, defaults to 
      GRCh38)
    default: GRCh38
    inputBinding:
      position: 102
      prefix: --ncbi-build
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory (default: current directory)'
    default: current directory
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format: tsv or maf. Possible values:\n          - tsv: Tab-separated
      values (default)\n          - maf: Mutation Annotation Format"
    default: tsv
    inputBinding:
      position: 102
      prefix: --output-format
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for output files (default: input filename)'
    default: input filename
    inputBinding:
      position: 102
      prefix: --prefix
  - id: sample_barcode
    type:
      - 'null'
      - string
    doc: Sample barcode for MAF output (auto-detected from header if not 
      provided)
    inputBinding:
      position: 102
      prefix: --sample-barcode
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing (0 = auto-detect)
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: transcript_handling
    type:
      - 'null'
      - string
    doc: "Transcript handling mode. Possible values:\n          - most-severe: Extract
      only the most severe consequence for each variant\n          - first:      \
      \ Keep first transcript only (fastest)\n          - split:       Split every
      transcript into separate rows"
    default: first
    inputBinding:
      position: 102
      prefix: --transcript-handling
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-reformatter:0.3.0--h4349ce8_0
stdout: vcf-reformatter.out
