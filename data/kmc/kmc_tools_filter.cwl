cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc_tools
label: kmc_tools_filter
doc: "kmc_tools filter removes reads with too few (or too many) k-mers present in a KMC database.\n\nTool homepage: https://github.com/refresh-bio/KMC"
inputs:
  - id: total_threads
    type: ['null', int]
    doc: "Total number of threads (default: no. of CPU cores)"
    inputBinding:
      position: 1
      prefix: "-t"
      separate: false
  - id: verbose
    type: ['null', boolean]
    doc: "Enable verbose mode (shows some information)"
    inputBinding:
      position: 2
      prefix: "-v"
  - id: hide_percentage_progress
    type: ['null', boolean]
    doc: "Hide percentage progress"
    inputBinding:
      position: 3
      prefix: "-hp"
  - id: trim_reads
    type: ['null', boolean]
    doc: "Trim reads on first invalid k-mer instead of removing them entirely"
    inputBinding:
      position: 5
      prefix: "-t"
  - id: hard_mask
    type: ['null', boolean]
    doc: "Hard mask invalid k-mers in a read"
    inputBinding:
      position: 6
      prefix: "-hm"
  - id: kmc_database
    type: File
    doc: "Input KMC database: the .kmc_pre file (the .kmc_suf file must sit beside it)"
    secondaryFiles:
      - pattern: "^.kmc_suf"
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.kmc_pre$/, ''))
  - id: db_ci
    type: ['null', int]
    doc: "K-mer database: exclude k-mers occurring less than this many times"
    inputBinding:
      position: 11
      prefix: "-ci"
      separate: false
  - id: db_cx
    type: ['null', int]
    doc: "K-mer database: exclude k-mers occurring more than this many times"
    inputBinding:
      position: 12
      prefix: "-cx"
      separate: false
  - id: input_reads
    type: File
    doc: "Input set of reads (FASTA or FASTQ)"
    inputBinding:
      position: 13
  - id: reads_ci
    type: ['null', string]
    doc: "Input reads: remove reads containing fewer k-mers than this value (integer, or a fraction in [0.0;1.0]; default 2)"
    inputBinding:
      position: 14
      prefix: "-ci"
      separate: false
  - id: reads_cx
    type: ['null', string]
    doc: "Input reads: remove reads containing more k-mers than this value (integer, or a fraction in [0.0;1.0]; default 1e9)"
    inputBinding:
      position: 15
      prefix: "-cx"
      separate: false
  - id: input_format
    type: ['null', string]
    doc: "Input reads format: a (FASTA) or q (FASTQ, default); given as -f<value>"
    inputBinding:
      position: 16
      prefix: "-f"
      separate: false
  - id: output_reads
    type: string
    doc: "Output set of reads"
    inputBinding:
      position: 20
  - id: output_format
    type: ['null', string]
    doc: "Output reads format: a (FASTA) or q (FASTQ); default same as input; given as -f<value>"
    inputBinding:
      position: 21
      prefix: "-f"
      separate: false
outputs:
  - id: filtered_reads
    type: File
    doc: "Filtered reads"
    outputBinding:
      glob: $(inputs.output_reads)
  - id: stdout
    type: stdout
    doc: "Standard output"
arguments:
  - position: 4
    valueFrom: filter
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc_tools_filter.out
