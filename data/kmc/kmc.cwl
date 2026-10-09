cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc
label: kmc
doc: "K-Mer Counter (KMC) counts the k-mers of FASTA, FASTQ, BAM or KMC inputs.\n\nTool homepage: https://github.com/refresh-bio/KMC"
inputs:
  - id: input_file
    type: ['null', File]
    doc: "Single input file in the format given by input_format (gzipped or not)"
    inputBinding:
      position: 10
  - id: input_list
    type: ['null', File]
    doc: "Text file listing input files, one per line (given to kmc as @list); the listed files must be given in input_list_files"
    inputBinding:
      position: 10
      valueFrom: $("@" + self.basename)
  - id: input_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in input_list, staged next to the list file"
  - id: output_file_name
    type: string
    doc: "Output name prefix (kmc writes <name>.kmc_pre and <name>.kmc_suf, or <name>.kff)"
    inputBinding:
      position: 11
  - id: working_directory
    type: string
    default: "kmc_tmp"
    doc: "Working directory for temporary files (created before the run)"
    inputBinding:
      position: 12
  - id: verbose
    type: ['null', boolean]
    doc: "Verbose mode (shows all parameter settings)"
    inputBinding:
      position: 1
      prefix: "-v"
  - id: kmer_length
    type: ['null', int]
    doc: "k-mer length (k from 1 to 256; default: 25)"
    inputBinding:
      position: 1
      prefix: "-k"
      separate: false
  - id: max_ram_gb
    type: ['null', int]
    doc: "Max amount of RAM in GB (from 1 to 1024); default: 12"
    inputBinding:
      position: 1
      prefix: "-m"
      separate: false
  - id: strict_memory_mode
    type: ['null', boolean]
    doc: "Use strict memory mode (memory limit from -m will not be exceeded)"
    inputBinding:
      position: 1
      prefix: "-sm"
  - id: count_homopolymer_compressed
    type: ['null', boolean]
    doc: "Count homopolymer compressed k-mers (approximate and experimental)"
    inputBinding:
      position: 1
      prefix: "-hc"
  - id: signature_length
    type: ['null', int]
    doc: "Signature length (5, 6, 7, 8, 9, 10, 11); default: 9"
    inputBinding:
      position: 1
      prefix: "-p"
      separate: false
  - id: input_format
    type: ['null', string]
    doc: "Input format: a = FASTA, q = FASTQ (default), m = multi FASTA, bam = BAM, kmc = KMC database (given to kmc as -f<value>)"
    inputBinding:
      position: 1
      prefix: "-f"
      separate: false
  - id: exclude_less_than_count
    type: ['null', int]
    doc: "Exclude k-mers occurring less than this many times (default: 2)"
    inputBinding:
      position: 1
      prefix: "-ci"
      separate: false
  - id: max_counter_value
    type: ['null', int]
    doc: "Maximal value of a counter (default: 255)"
    inputBinding:
      position: 1
      prefix: "-cs"
      separate: false
  - id: exclude_more_than_count
    type: ['null', int]
    doc: "Exclude k-mers occurring more than this many times (default: 1e9)"
    inputBinding:
      position: 1
      prefix: "-cx"
      separate: false
  - id: turn_off_canonical_form
    type: ['null', boolean]
    doc: "Turn off transformation of k-mers into canonical form"
    inputBinding:
      position: 1
      prefix: "-b"
  - id: ram_only_mode
    type: ['null', boolean]
    doc: "Turn on RAM-only mode"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: num_bins
    type: ['null', int]
    doc: "Number of bins"
    inputBinding:
      position: 1
      prefix: "-n"
      separate: false
  - id: total_threads
    type: ['null', int]
    doc: "Total number of threads (default: no. of CPU cores)"
    inputBinding:
      position: 1
      prefix: "-t"
      separate: false
  - id: fastq_reading_threads
    type: ['null', int]
    doc: "Number of FASTQ reading threads"
    inputBinding:
      position: 1
      prefix: "-sf"
      separate: false
  - id: splitting_threads
    type: ['null', int]
    doc: "Number of splitting threads"
    inputBinding:
      position: 1
      prefix: "-sp"
      separate: false
  - id: threads_2nd_stage
    type: ['null', int]
    doc: "Number of threads for 2nd stage"
    inputBinding:
      position: 1
      prefix: "-sr"
      separate: false
  - id: execution_summary_json
    type: ['null', string]
    doc: "File name for the execution summary in JSON format"
    inputBinding:
      position: 1
      prefix: "-j"
      separate: false
  - id: without_output
    type: ['null', boolean]
    doc: "Without output"
    inputBinding:
      position: 1
      prefix: "-w"
  - id: output_format
    type: ['null', string]
    doc: "Output in KMC or KFF format: kmc (default) or kff (given to kmc as -o<value>)"
    inputBinding:
      position: 1
      prefix: "-o"
      separate: false
  - id: hide_percentage_progress
    type: ['null', boolean]
    doc: "Hide percentage progress (default: false)"
    inputBinding:
      position: 1
      prefix: "-hp"
  - id: estimate_histogram
    type: ['null', boolean]
    doc: "Only estimate histogram of k-mer occurrences instead of exact k-mer counting"
    inputBinding:
      position: 1
      prefix: "-e"
  - id: optimize_output_size
    type: ['null', boolean]
    doc: "Optimize output database size (may increase running time)"
    inputBinding:
      position: 1
      prefix: "--opt-out-size"
outputs:
  - id: kmc_database
    type:
      type: array
      items: File
    doc: "K-mer database files (<name>.kmc_pre and <name>.kmc_suf, or <name>.kff)"
    outputBinding:
      glob:
        - "$(inputs.output_file_name).kmc_*"
        - "$(inputs.output_file_name).kff"
  - id: summary_json
    type: ['null', File]
    doc: "Execution summary written with -j"
    outputBinding:
      glob: $(inputs.execution_summary_json)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.working_directory, "listing": []})'
        writable: true
      - $(inputs.input_list_files)
      - $(inputs.input_list)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc.out
