cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc
label: malva_kmc
doc: 'K-Mer Counter (KMC)


  Tool homepage: https://algolab.github.io/malva/'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.working_directory)
        entry: '$({"class": "Directory", "basename": inputs.working_directory, "listing": []})'
        writable: true
inputs:
  - id: input_file_name
    type:
      - 'null'
      - File
    doc: Single input file in the format set by input_format (gzipped or not). Use
      this or input_file_names_list.
    inputBinding:
      position: 10
  - id: input_file_names_list
    type:
      - 'null'
      - File
    doc: file name with list of input files in specified (-f switch) format (gziped
      or not)
    inputBinding:
      position: 10
      valueFrom: '@$(self.path)'
  - id: output_file_name
    type: string
    doc: output file name
    inputBinding:
      position: 11
  - id: working_directory
    type: string
    doc: Working (temporary) directory for KMC; it is created in the job directory
    inputBinding:
      position: 12
  - id: canonical_form_off
    type:
      - 'null'
      - boolean
    doc: turn off transformation of k-mers into canonical form
    inputBinding:
      position: 1
      prefix: -b
  - id: exclude_less_than_count
    type:
      - 'null'
      - int
    doc: exclude k-mers occurring less than <value> times
    inputBinding:
      position: 1
      prefix: -ci
      separate: false
  - id: exclude_more_than_count
    type:
      - 'null'
      - float
    doc: exclude k-mers occurring more of than <value> times
    inputBinding:
      position: 1
      prefix: -cx
      separate: false
  - id: fastq_reading_threads
    type:
      - 'null'
      - int
    doc: number of FASTQ reading threads
    inputBinding:
      position: 1
      prefix: -sf
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: input in FASTA format (-fa), FASTQ format (-fq), multi FASTA (-fm) or BAM
      (-fbam)
    inputBinding:
      position: 1
      prefix: -f
      separate: false
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length (k from 1 to 256)
    inputBinding:
      position: 1
      prefix: -k
      separate: false
  - id: max_counter_value
    type:
      - 'null'
      - int
    doc: maximal value of a counter
    inputBinding:
      position: 1
      prefix: -cs
      separate: false
  - id: max_ram_gb
    type:
      - 'null'
      - int
    doc: max amount of RAM in GB (from 1 to 1024)
    inputBinding:
      position: 1
      prefix: -m
      separate: false
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: without output
    inputBinding:
      position: 1
      prefix: -w
  - id: num_bins
    type:
      - 'null'
      - int
    doc: number of bins
    inputBinding:
      position: 1
      prefix: -n
      separate: false
  - id: ram_only_mode
    type:
      - 'null'
      - boolean
    doc: turn on RAM-only mode
    inputBinding:
      position: 1
      prefix: -r
  - id: signature_length
    type:
      - 'null'
      - int
    doc: signature length (5, 6, 7, 8, 9, 10, 11)
    inputBinding:
      position: 1
      prefix: -p
      separate: false
  - id: splitting_threads
    type:
      - 'null'
      - int
    doc: number of splitting threads
    inputBinding:
      position: 1
      prefix: -sp
      separate: false
  - id: stage2_threads
    type:
      - 'null'
      - int
    doc: number of threads for 2nd stage
    inputBinding:
      position: 1
      prefix: -sr
      separate: false
  - id: strict_memory_mode
    type:
      - 'null'
      - boolean
    doc: use strict memory mode (memory limit from -m<n> switch will not be exceeded)
    inputBinding:
      position: 1
      prefix: -sm
  - id: summary_json_file
    type:
      - 'null'
      - string
    doc: File name for the execution summary in JSON format
    inputBinding:
      position: 1
      prefix: -j
      separate: false
  - id: total_threads
    type:
      - 'null'
      - int
    doc: 'total number of threads (default: no. of CPU cores)'
    inputBinding:
      position: 1
      prefix: -t
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode (shows all parameter settings)
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: kmc_files
    type:
      type: array
      items: File
    doc: KMC database files (<output_file_name>.kmc_pre and .kmc_suf)
    outputBinding:
      glob: $(inputs.output_file_name).kmc_*
  - id: summary_json
    type:
      - 'null'
      - File
    doc: Execution summary
    outputBinding:
      glob: $(inputs.summary_json_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva_kmc.out
