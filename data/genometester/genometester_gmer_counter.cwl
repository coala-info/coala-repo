cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmer_counter
label: genometester_gmer_counter
doc: "Nothing to do!\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs:
  - id: arguments
    type: string
    doc: Arguments
    inputBinding:
      position: 1
  - id: sequences
    type:
      type: array
      items: string
    doc: Sequences
    inputBinding:
      position: 2
  - id: database
    type:
      - 'null'
      - File
    doc: SNP/KMER database file
    inputBinding:
      position: 103
      prefix: -db
  - id: dbbinary
    type:
      - 'null'
      - File
    doc: binary database file
    inputBinding:
      position: 103
      prefix: -dbb
  - id: debug_level
    type:
      - 'null'
      - boolean
    doc: increase debug level
    inputBinding:
      position: 103
      prefix: -D
  - id: distribution
    type:
      - 'null'
      - int
    doc: print kmer distribution (up to given number)
    inputBinding:
      position: 103
      prefix: --distribution
  - id: header
    type:
      - 'null'
      - boolean
    doc: print header row
    inputBinding:
      position: 103
      prefix: --header
  - id: kmers
    type:
      - 'null'
      - boolean
    doc: print individual kmer counts (default if no other output)
    inputBinding:
      position: 103
      prefix: --kmers
  - id: max_kmers
    type:
      - 'null'
      - int
    doc: maximum number of kmers per node
    inputBinding:
      position: 103
      prefix: --max_kmers
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of worker threads (default 24)
    inputBinding:
      position: 103
      prefix: --num_threads
  - id: prefetch
    type:
      - 'null'
      - boolean
    doc: prefetch memory mapped files (faster on high-memory systems)
    inputBinding:
      position: 103
      prefix: --prefetch
  - id: silent
    type:
      - 'null'
      - boolean
    doc: do not output kmer counts (useful if only compiling db or index is 
      needed
    inputBinding:
      position: 103
      prefix: --silent
  - id: total
    type:
      - 'null'
      - boolean
    doc: print the total number of kmers per node
    inputBinding:
      position: 103
      prefix: --total
  - id: unique
    type:
      - 'null'
      - boolean
    doc: print the number of nonzero kmers per node
    inputBinding:
      position: 103
      prefix: --unique
  - id: use_32bit_integers
    type:
      - 'null'
      - boolean
    doc: use 32-bit integeres for counts (default 16-bit)
    inputBinding:
      position: 103
      prefix: '-32'
outputs:
  - id: write_binary_database
    type:
      - 'null'
      - File
    doc: write binary database to file
    outputBinding:
      glob: $(inputs.write_binary_database)
  - id: compile_index
    type:
      - 'null'
      - File
    doc: Add read index to database and write it to file
    outputBinding:
      glob: $(inputs.compile_index)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
