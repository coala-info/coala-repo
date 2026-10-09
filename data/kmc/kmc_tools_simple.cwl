cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc_tools
label: kmc_tools_simple
doc: "kmc_tools simple performs a set operation on two KMC databases.\n\nTool homepage: https://github.com/refresh-bio/KMC"
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
  - id: kmc_database_1
    type: File
    doc: "First input KMC database: the .kmc_pre file (the .kmc_suf file must sit beside it)"
    secondaryFiles:
      - pattern: "^.kmc_suf"
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.kmc_pre$/, ''))
  - id: input1_ci
    type: ['null', int]
    doc: "Input 1: exclude k-mers occurring less than this many times"
    inputBinding:
      position: 11
      prefix: "-ci"
      separate: false
  - id: input1_cx
    type: ['null', int]
    doc: "Input 1: exclude k-mers occurring more than this many times"
    inputBinding:
      position: 12
      prefix: "-cx"
      separate: false
  - id: kmc_database_2
    type: File
    doc: "Second input KMC database: the .kmc_pre file (the .kmc_suf file must sit beside it)"
    secondaryFiles:
      - pattern: "^.kmc_suf"
    inputBinding:
      position: 13
      valueFrom: $(self.path.replace(/\.kmc_pre$/, ''))
  - id: input2_ci
    type: ['null', int]
    doc: "Input 2: exclude k-mers occurring less than this many times"
    inputBinding:
      position: 14
      prefix: "-ci"
      separate: false
  - id: input2_cx
    type: ['null', int]
    doc: "Input 2: exclude k-mers occurring more than this many times"
    inputBinding:
      position: 15
      prefix: "-cx"
      separate: false
  - id: operation
    type: string
    doc: "Set operation: intersect, union, kmers_subtract, counters_subtract, reverse_kmers_subtract or reverse_counters_subtract"
    inputBinding:
      position: 20
  - id: output_name
    type: string
    doc: "Name of the output KMC database"
    inputBinding:
      position: 21
  - id: output_ci
    type: ['null', int]
    doc: "Output: exclude k-mers occurring less than this many times"
    inputBinding:
      position: 22
      prefix: "-ci"
      separate: false
  - id: output_cx
    type: ['null', int]
    doc: "Output: exclude k-mers occurring more than this many times"
    inputBinding:
      position: 23
      prefix: "-cx"
      separate: false
  - id: output_cs
    type: ['null', int]
    doc: "Output: maximal value of a counter"
    inputBinding:
      position: 24
      prefix: "-cs"
      separate: false
  - id: output_format
    type: ['null', string]
    doc: "Output format kmc or kff (given as -o<value>)"
    inputBinding:
      position: 25
      prefix: "-o"
      separate: false
  - id: counter_mode
    type: ['null', string]
    doc: "Counter calculation mode for equal k-mers: min, max, sum, diff, left or right (given as -oc<value>)"
    inputBinding:
      position: 26
      prefix: "-oc"
      separate: false
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Output database files"
    outputBinding:
      glob:
        - $(inputs.output_name).kmc_*
        - $(inputs.output_name).kff
  - id: stdout
    type: stdout
    doc: "Standard output"
arguments:
  - position: 4
    valueFrom: simple
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc_tools_simple.out
