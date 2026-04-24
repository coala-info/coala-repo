cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacerextractor
  - extract_spacers
label: spacerextractor_extract_spacers
doc: "extract spacers from metagenomic reads using a database of known repeats\n\n\
  Tool homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
inputs:
  - id: bbtools_memory
    type:
      - 'null'
      - string
    doc: memory allocated to bbtools
    inputBinding:
      position: 101
      prefix: --bbtools_memory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Run in a more verbose mode for debugging / troubleshooting purposes (warning:
      spacerextractor becomes quite chatty in this mode..)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: If you want to force SpacerExtractor to recompute all the steps
    inputBinding:
      position: 101
      prefix: --force_rerun
  - id: input_fastq
    type: File
    doc: Fastq file of the reads to be mined (can be gzipped)
    inputBinding:
      position: 101
      prefix: --input_fastq
  - id: input_fastq_r2
    type:
      - 'null'
      - File
    doc: Fastq file of the R2 reads, if the reads come as R1 and R2 file
    inputBinding:
      position: 101
      prefix: --input_fastq_r2
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'To change the default cutoff on minimum read length (default: 90) - Note:
      SpacerExtractor has only been tested with reads 90bp and longer, so lowering
      this cutoff should be considered experimental !!'
    inputBinding:
      position: 101
      prefix: --min_len
  - id: n_threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: To bypass the quality-based trimming (e.g. for SRA data without quality
      information) - note that this will also bypass the attempt at merging 
      reads
    inputBinding:
      position: 101
      prefix: --no_trim
  - id: out_dir
    type: Directory
    doc: Output directory (will be created if it does not exist)
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in a very quiet mode, will only show error/critical messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: repeat_db_dir
    type: Directory
    doc: Path to the repeat database folder
    inputBinding:
      position: 101
      prefix: --repeat_db_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
stdout: spacerextractor_extract_spacers.out
