cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacerextractor
  - extract_spacers
label: spacerextractor_extract_spacers
doc: "extract spacers from metagenomic reads using a database of known repeats\n\nTool homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
inputs:
  - id: repeat_db_dir
    type: Directory
    doc: "Path to the repeat database folder"
    inputBinding:
      position: 101
      prefix: --repeat_db_dir
  - id: input_fastq
    type: File
    doc: "Fastq file of the reads to be mined (can be gzipped)"
    inputBinding:
      position: 101
      prefix: --input_fastq
  - id: input_fastq_r2
    type:
      - 'null'
      - File
    doc: "Fastq file of the R2 reads, if the reads come as R1 and R2 file"
    inputBinding:
      position: 101
      prefix: --input_fastq_r2
  - id: out_dir
    type: string
    doc: "Output directory (will be created if it does not exist)"
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: "To bypass the quality-based trimming (e.g. for SRA data without quality information) - note that this will also bypass the attempt at merging reads"
    inputBinding:
      position: 101
      prefix: --no_trim
  - id: min_len
    type:
      - 'null'
      - int
    doc: "To change the default cutoff on minimum read length (default: 90) - Note: SpacerExtractor has only been tested with reads 90bp and longer, so lowering this cutoff should be considered experimental !!"
    inputBinding:
      position: 101
      prefix: --min_len
  - id: n_threads
    type:
      - 'null'
      - int
    doc: "number of threads to use [default: 2]"
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: bbtools_memory
    type:
      - 'null'
      - string
    doc: "memory allocated to bbtools [default: 20g]"
    inputBinding:
      position: 101
      prefix: --bbtools_memory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Run in a more verbose mode for debugging / troubleshooting purposes"
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Run in a very quiet mode, will only show error/critical messages"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: "If you want to force SpacerExtractor to recompute all the steps"
    inputBinding:
      position: 101
      prefix: --force_rerun
outputs:
  - id: out_dir_output
    type: Directory
    doc: "Output directory with the extracted spacers"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
