cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc
label: kmc
doc: "K-Mer Counter\n\nTool homepage: https://github.com/refresh-bio/kmc"
inputs:
  - id: input_file_name
    type: string
    doc: single file in specified (-f switch) format (gziped or not)
    inputBinding:
      position: 1
  - id: output_file_name
    type: string
    doc: output file name
    inputBinding:
      position: 2
  - id: working_directory
    type: Directory
    doc: working directory
    inputBinding:
      position: 3
  - id: canonical_form
    type:
      - 'null'
      - boolean
    doc: turn off transformation of k-mers into canonical form
    inputBinding:
      position: 104
      prefix: -b
  - id: count_homopolymer_compressed
    type:
      - 'null'
      - boolean
    doc: count homopolymer compressed k-mers (approximate and experimental)
    inputBinding:
      position: 104
      prefix: -hc
  - id: estimate_histogram
    type:
      - 'null'
      - boolean
    doc: only estimate histogram of k-mers occurrences instead of exact k-mer 
      counting
    inputBinding:
      position: 104
      prefix: -e
  - id: exclude_less_than_count
    type:
      - 'null'
      - int
    doc: exclude k-mers occurring less than <value> times
    default: 2
    inputBinding:
      position: 104
      prefix: -ci
  - id: exclude_more_than_count
    type:
      - 'null'
      - float
    doc: exclude k-mers occurring more of than <value> times
    default: '1e9'
    inputBinding:
      position: 104
      prefix: -cx
  - id: execution_summary_json
    type:
      - 'null'
      - File
    doc: file name with execution summary in JSON format
    inputBinding:
      position: 104
      prefix: -j
  - id: fastq_reading_threads
    type:
      - 'null'
      - int
    doc: number of FASTQ reading threads
    inputBinding:
      position: 104
      prefix: -sf
  - id: hide_percentage_progress
    type:
      - 'null'
      - boolean
    doc: hide percentage progress
    default: false
    inputBinding:
      position: 104
      prefix: -hp
  - id: input_format
    type:
      - 'null'
      - string
    doc: input in FASTA format (-fa), FASTQ format (-fq), multi FASTA (-fm) or 
      BAM (-fbam) or KMC (-fkmc)
    default: FASTQ
    inputBinding:
      position: 104
      prefix: -f
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length (k from 1 to 256)
    default: 25
    inputBinding:
      position: 104
      prefix: -k
  - id: max_counter_value
    type:
      - 'null'
      - int
    doc: maximal value of a counter
    default: 255
    inputBinding:
      position: 104
      prefix: -cs
  - id: max_ram_gb
    type:
      - 'null'
      - int
    doc: max amount of RAM in GB (from 1 to 1024)
    default: 12
    inputBinding:
      position: 104
      prefix: -m
  - id: num_bins
    type:
      - 'null'
      - int
    doc: number of bins
    inputBinding:
      position: 104
      prefix: -n
  - id: optimize_output_size
    type:
      - 'null'
      - boolean
    doc: optimize output database size (may increase running time)
    inputBinding:
      position: 104
      prefix: --opt-out-size
  - id: output_format
    type:
      - 'null'
      - string
    doc: output in KMC of KFF format
    default: KMC
    inputBinding:
      position: 104
      prefix: -o
  - id: ram_only_mode
    type:
      - 'null'
      - boolean
    doc: turn on RAM-only mode
    inputBinding:
      position: 104
      prefix: -r
  - id: signature_length
    type:
      - 'null'
      - int
    doc: signature length (5, 6, 7, 8, 9, 10, 11)
    default: 9
    inputBinding:
      position: 104
      prefix: -p
  - id: splitting_threads
    type:
      - 'null'
      - int
    doc: number of splitting threads
    inputBinding:
      position: 104
      prefix: -sp
  - id: strict_memory_mode
    type:
      - 'null'
      - boolean
    doc: use strict memory mode (memory limit from -m<n> switch will not be 
      exceeded)
    inputBinding:
      position: 104
      prefix: -sm
  - id: threads_2nd_stage
    type:
      - 'null'
      - int
    doc: number of threads for 2nd stage
    inputBinding:
      position: 104
      prefix: -sr
  - id: total_threads
    type:
      - 'null'
      - int
    doc: 'total number of threads (default: no. of CPU cores)'
    inputBinding:
      position: 104
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (shows all parameter settings)
    default: false
    inputBinding:
      position: 104
      prefix: -v
  - id: without_output
    type:
      - 'null'
      - boolean
    doc: without output
    inputBinding:
      position: 104
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc.out
