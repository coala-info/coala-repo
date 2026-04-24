cwlVersion: v1.2
class: CommandLineTool
baseCommand: dysgu fetch
label: dysgu_fetch
doc: "Filters input bam/cram for read-pairs that are discordant or have a soft-clip
  of length > '--clip-length', saves bam file in WORKING_DIRECTORY\n\nTool homepage:
  https://github.com/kcleal/dysgu"
inputs:
  - id: working_directory
    type: Directory
    doc: Working directory to save output BAM file
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: Input BAM/CRAM file
    inputBinding:
      position: 2
  - id: clip_length
    type:
      - 'null'
      - int
    doc: Minimum soft-clip length, >= threshold are kept. Set to -1 to ignore
    inputBinding:
      position: 103
      prefix: --clip-length
  - id: compression
    type:
      - 'null'
      - string
    doc: Set output bam compression level. Default is uncompressed
    inputBinding:
      position: 103
      prefix: --compression
  - id: exclude
    type:
      - 'null'
      - File
    doc: .bed file, do not search/call SVs within regions. Takes precedence over
      --search
    inputBinding:
      position: 103
      prefix: --exclude
  - id: max_cov
    type:
      - 'null'
      - float
    doc: Genomic regions with coverage > max-cov are discarded. Set to -1 to 
      ignore.
    inputBinding:
      position: 103
      prefix: --max-cov
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size of SV to report
    inputBinding:
      position: 103
      prefix: --min-size
  - id: mq
    type:
      - 'null'
      - int
    doc: Minimum map quality < threshold are discarded
    inputBinding:
      position: 103
      prefix: --mq
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite temp files
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: pfix
    type:
      - 'null'
      - string
    doc: Post-fix to add to temp alignment files
    inputBinding:
      position: 103
      prefix: --pfix
  - id: pl
    type:
      - 'null'
      - string
    doc: Type of input reads
    inputBinding:
      position: 103
      prefix: --pl
  - id: procs
    type:
      - 'null'
      - int
    doc: Compression threads to use for writing bam
    inputBinding:
      position: 103
      prefix: --procs
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file for opening cram files
    inputBinding:
      position: 103
      prefix: --reference
  - id: search
    type:
      - 'null'
      - File
    doc: .bed file, limit search to regions
    inputBinding:
      position: 103
      prefix: --search
  - id: write_all
    type:
      - 'null'
      - boolean
    doc: Write all alignments from SV-read template to temp file
    inputBinding:
      position: 103
      prefix: --write_all
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output reads, discordant, supplementary and soft-clipped reads to file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
