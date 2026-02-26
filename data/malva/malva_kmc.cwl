cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc
label: malva_kmc
doc: "K-Mer Counter (KMC)\n\nTool homepage: https://algolab.github.io/malva/"
inputs:
  - id: input_file_name
    type: File
    doc: single file in specified (-f switch) format (gziped or not)
    inputBinding:
      position: 1
  - id: input_file_names_list
    type: File
    doc: file name with list of input files in specified (-f switch) format 
      (gziped or not)
    inputBinding:
      position: 2
  - id: output_file_name
    type: File
    doc: output file name
    inputBinding:
      position: 3
  - id: working_directory
    type: Directory
    doc: working directory
    inputBinding:
      position: 4
  - id: canonical_form_off
    type:
      - 'null'
      - boolean
    doc: turn off transformation of k-mers into canonical form
    inputBinding:
      position: 105
      prefix: -b
  - id: exclude_less_than_count
    type:
      - 'null'
      - int
    doc: exclude k-mers occurring less than <value> times
    default: 2
    inputBinding:
      position: 105
      prefix: -ci
  - id: exclude_more_than_count
    type:
      - 'null'
      - float
    doc: exclude k-mers occurring more of than <value> times
    default: '1e9'
    inputBinding:
      position: 105
      prefix: -cx
  - id: fastq_reading_threads
    type:
      - 'null'
      - int
    doc: number of FASTQ reading threads
    inputBinding:
      position: 105
      prefix: -sf
  - id: input_format
    type:
      - 'null'
      - string
    doc: input in FASTA format (-fa), FASTQ format (-fq), multi FASTA (-fm) or 
      BAM (-fbam)
    default: FASTQ
    inputBinding:
      position: 105
      prefix: -f
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length (k from 1 to 256)
    default: 25
    inputBinding:
      position: 105
      prefix: -k
  - id: max_counter_value
    type:
      - 'null'
      - int
    doc: maximal value of a counter
    default: 255
    inputBinding:
      position: 105
      prefix: -cs
  - id: max_ram_gb
    type:
      - 'null'
      - int
    doc: max amount of RAM in GB (from 1 to 1024)
    default: 12
    inputBinding:
      position: 105
      prefix: -m
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: without output
    inputBinding:
      position: 105
      prefix: -w
  - id: num_bins
    type:
      - 'null'
      - int
    doc: number of bins
    inputBinding:
      position: 105
      prefix: -n
  - id: ram_only_mode
    type:
      - 'null'
      - boolean
    doc: turn on RAM-only mode
    inputBinding:
      position: 105
      prefix: -r
  - id: signature_length
    type:
      - 'null'
      - int
    doc: signature length (5, 6, 7, 8, 9, 10, 11)
    default: 9
    inputBinding:
      position: 105
      prefix: -p
  - id: splitting_threads
    type:
      - 'null'
      - int
    doc: number of splitting threads
    inputBinding:
      position: 105
      prefix: -sp
  - id: stage2_threads
    type:
      - 'null'
      - int
    doc: number of threads for 2nd stage
    inputBinding:
      position: 105
      prefix: -sr
  - id: strict_memory_mode
    type:
      - 'null'
      - boolean
    doc: use strict memory mode (memory limit from -m<n> switch will not be 
      exceeded)
    inputBinding:
      position: 105
      prefix: -sm
  - id: summary_json_file
    type:
      - 'null'
      - File
    doc: file name with execution summary in JSON format
    inputBinding:
      position: 105
      prefix: -j
  - id: total_threads
    type:
      - 'null'
      - int
    doc: 'total number of threads (default: no. of CPU cores)'
    inputBinding:
      position: 105
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (shows all parameter settings)
    default: false
    inputBinding:
      position: 105
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva_kmc.out
