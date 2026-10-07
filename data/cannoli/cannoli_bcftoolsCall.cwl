cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli-submit
  - bcftoolsCall
label: cannoli_bcftoolsCall
doc: "Call variant contexts with bcftools call via Cannoli/Spark.\n\nTool homepage:
  https://github.com/bigdatagenomics/cannoli"
inputs:
  - id: input
    type: File
    doc: Location to pipe variant contexts from (e.g. .vcf, .vcf.gz, .vcf.bgz).
      If extension is not detected, Parquet is assumed.
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Location to pipe variant contexts to (e.g. .vcf, .vcf.gz, .vcf.bgz). If
      extension is not detected, Parquet is assumed.
    inputBinding:
      position: 2
  - id: add_files
    type:
      - 'null'
      - boolean
    doc: If true, use the SparkFiles mechanism to distribute files to executors.
    inputBinding:
      position: 102
      prefix: -add_files
  - id: bcftools_args
    type:
      - 'null'
      - string
    doc: Additional arguments for Bcftools, e.g. "--gvcf 5,15"
    inputBinding:
      position: 102
      prefix: -bcftools_args
  - id: defer_merging
    type:
      - 'null'
      - boolean
    doc: Defers merging single file output.
    inputBinding:
      position: 102
      prefix: -defer_merging
  - id: disable_fast_concat
    type:
      - 'null'
      - boolean
    doc: Disables the parallel file concatenation engine.
    inputBinding:
      position: 102
      prefix: -disable_fast_concat
  - id: docker_image
    type:
      - 'null'
      - string
    doc: 'Container image to use. (default: quay.io/biocontainers/bcftools:1.19--h8b25389_0)'
    inputBinding:
      position: 102
      prefix: -docker_image
  - id: executable
    type:
      - 'null'
      - string
    doc: 'Path to the bcftools executable. (default: bcftools)'
    inputBinding:
      position: 102
      prefix: -executable
  - id: parquet_block_size
    type:
      - 'null'
      - int
    doc: 'Parquet block size (default: 134217728)'
    inputBinding:
      position: 102
      prefix: -parquet_block_size
  - id: parquet_compression_codec
    type:
      - 'null'
      - string
    doc: 'Parquet compression codec: UNCOMPRESSED, SNAPPY, GZIP, LZO, BROTLI, LZ4,
      ZSTD or LZ4_RAW (default: GZIP)'
    inputBinding:
      position: 102
      prefix: -parquet_compression_codec
  - id: parquet_disable_dictionary
    type:
      - 'null'
      - boolean
    doc: Disable dictionary encoding
    inputBinding:
      position: 102
      prefix: -parquet_disable_dictionary
  - id: parquet_logging_level
    type:
      - 'null'
      - string
    doc: 'Parquet logging level (default: SEVERE)'
    inputBinding:
      position: 102
      prefix: -parquet_logging_level
  - id: parquet_page_size
    type:
      - 'null'
      - int
    doc: 'Parquet page size (default: 1048576)'
    inputBinding:
      position: 102
      prefix: -parquet_page_size
  - id: single
    type:
      - 'null'
      - boolean
    doc: Saves OUTPUT as single file.
    inputBinding:
      position: 102
      prefix: -single
  - id: stringency
    type:
      - 'null'
      - string
    doc: 'Stringency level for various checks; can be SILENT, LENIENT, or STRICT.
      (default: STRICT)'
    inputBinding:
      position: 102
      prefix: -stringency
  - id: sudo
    type:
      - 'null'
      - boolean
    doc: Run via sudo.
    inputBinding:
      position: 102
      prefix: -sudo
  - id: use_docker
    type:
      - 'null'
      - boolean
    doc: If true, uses Docker to launch bcftools.
    inputBinding:
      position: 102
      prefix: -use_docker
  - id: use_singularity
    type:
      - 'null'
      - boolean
    doc: If true, uses Singularity to launch bcftools.
    inputBinding:
      position: 102
      prefix: -use_singularity
outputs:
  - id: output
    type:
      - File
      - Directory
    doc: Called variant contexts (one file with -single, otherwise a directory
      of parts)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
