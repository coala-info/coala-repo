cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-sort
label: sambamba_sort
doc: "Sort BAM files.\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: level of compression for sorted BAM, from 0 to 9
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: filter
    type:
      - 'null'
      - string
    doc: keep only reads that satisfy FILTER
    inputBinding:
      position: 102
      prefix: --filter
  - id: match_mates
    type:
      - 'null'
      - boolean
    doc: pull mates of the same alignment together when sorting by read name
    inputBinding:
      position: 102
      prefix: --match-mates
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: approximate total memory limit for all threads
    inputBinding:
      position: 102
      prefix: --memory-limit
  - id: natural_sort
    type:
      - 'null'
      - boolean
    doc: sort by read name instead of coordinate (so-called 'natural' sort as in
      samtools)
    inputBinding:
      position: 102
      prefix: --natural-sort
  - id: nthreads
    type:
      - 'null'
      - int
    doc: use specified number of threads
    inputBinding:
      position: 102
      prefix: --nthreads
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show progressbar in STDERR
    inputBinding:
      position: 102
      prefix: --show-progress
  - id: sort_by_name
    type:
      - 'null'
      - boolean
    doc: sort by read name instead of coordinate (lexicographical order)
    inputBinding:
      position: 102
      prefix: --sort-by-name
  - id: sort_picard
    type:
      - 'null'
      - boolean
    doc: sort by query name like in picard
    inputBinding:
      position: 102
      prefix: --sort-picard
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for storing intermediate files; default is system directory 
      for temporary files
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: uncompressed_chunks
    type:
      - 'null'
      - boolean
    doc: write sorted chunks as uncompressed BAM (default is writing with 
      compression level 1), that might be faster in some cases but uses more 
      disk space
    inputBinding:
      position: 102
      prefix: --uncompressed-chunks
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name; if not provided, the result is written to a file with
      .sorted.bam extension
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
