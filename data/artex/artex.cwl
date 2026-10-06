cwlVersion: v1.2
class: CommandLineTool
baseCommand: artex
label: artex
doc: "A tool for variant calling from sequencing data.\n\nTool homepage: https://github.com/JMencius/Artex"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for Clair3.
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: config
    type:
      - 'null'
      - string
    doc: Basecalling configuration with a bundled Clair3 model (R9G2, R9G4 or R9G6).
    inputBinding:
      position: 101
      prefix: --config
  - id: input
    type: Directory
    doc: ARTIC pipeline output directory (sorted.bam, pass.vcf.gz, fail.vcf).
    inputBinding:
      position: 101
      prefix: --input
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage required to call a variant in Clair3.
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: model
    type:
      - 'null'
      - Directory
    doc: Path to a Clair3 model directory (instead of --config).
    inputBinding:
      position: 101
      prefix: --model
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference FASTA (default is the bundled nCoV-2019 V3 reference).
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --ref
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run in test mode.
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: work
    type:
      - 'null'
      - string
    doc: Working directory for intermediate files (default is the output directory).
    inputBinding:
      position: 101
      prefix: --work
  - id: output_path
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory with Clair3 results, intersected and merged VCFs.
    outputBinding:
      glob: $(inputs.output_path)
  - id: artex_vcf
    type:
      - 'null'
      - File
    doc: Final Artex VCF (ARTIC PASS variants plus extra variants found by Artex).
    outputBinding:
      glob: $(inputs.output_path)/$(inputs.prefix || 'sample').artex.vcf.gz
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artex:0.2.0--py39h9ee0642_0
