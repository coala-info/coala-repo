cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapog
label: hapog
doc: "Hapo-G uses alignments produced by BWA (or any other aligner that produces SAM
  files) to polish the consensus of a genome assembly.\n\nTool homepage: https://github.com/institut-de-genomique/HAPO-G"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: "Skip mapping step and provide a sorted bam file. Important: the BAM file
      must not contain secondary alignments, please use the 'secondary=no' option
      in Minimap2."
    inputBinding:
      position: 101
      prefix: -b
  - id: chunk_list
    type:
      - 'null'
      - string
    doc: Comma-separated list of chunk numbers to process (e.g., '12,18'). 
      Useful for rerunning failed chunks.
    inputBinding:
      position: 101
      prefix: --chunk-list
  - id: genome
    type: File
    doc: Input genome file to map reads to
    inputBinding:
      position: 101
      prefix: --genome
  - id: hapog_bin
    type:
      - 'null'
      - string
    doc: Use a different Hapo-G binary (for debug purposes)
    inputBinding:
      position: 101
      prefix: --bin
  - id: hapog_threads
    type:
      - 'null'
      - int
    doc: Maximum number of Hapo-G jobs to launch in parallel (Defaults to the 
      same value as --threads)
    inputBinding:
      position: 101
      prefix: --hapog-threads
  - id: include_unpolished
    type:
      - 'null'
      - boolean
    doc: Include unpolished sequences in final output
    inputBinding:
      position: 101
      prefix: -u
  - id: long_reads
    type:
      - 'null'
      - File
    doc: Use long reads instead of short reads (can only be given one time, 
      please concatenate all read files into one)
    inputBinding:
      position: 101
      prefix: --single
  - id: pe1
    type:
      - 'null'
      - type: array
        items: File
    doc: Fastq.gz paired-end file (pair 1, can be given multiple times)
    inputBinding:
      position: 101
      prefix: --pe1
  - id: pe2
    type:
      - 'null'
      - type: array
        items: File
    doc: Fastq.gz paired-end file (pair 2, can be given multiple times)
    inputBinding:
      position: 101
      prefix: --pe2
  - id: samtools_mem
    type:
      - 'null'
      - string
    doc: "Amount of memory to use per samtools thread (Default: '5G')"
    default: 5G
    inputBinding:
      position: 101
      prefix: --samtools-mem
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (used in BWA, Samtools and Hapo-G)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory name
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapog:1.3.8--py39hb49fbdb_3
