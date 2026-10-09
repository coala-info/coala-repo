cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmc_tools
label: kmc_tools_transform
doc: "kmc_tools transform transforms a single KMC database to an output (text file or KMC database).\n\nTool homepage: https://github.com/refresh-bio/KMC"
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
  - id: kmc_database
    type: File
    doc: "Input KMC database: the .kmc_pre file (the .kmc_suf file must sit beside it)"
    secondaryFiles:
      - pattern: "^.kmc_suf"
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.kmc_pre$/, ''))
  - id: input_ci
    type: ['null', int]
    doc: "Input parameter: exclude k-mers occurring less than this many times"
    inputBinding:
      position: 11
      prefix: "-ci"
      separate: false
  - id: input_cx
    type: ['null', int]
    doc: "Input parameter: exclude k-mers occurring more than this many times"
    inputBinding:
      position: 12
      prefix: "-cx"
      separate: false
  - id: operation
    type: string
    doc: "Transform operation: sort, reduce, compact, histogram, dump or set_counts"
    inputBinding:
      position: 20
  - id: set_counts_value
    type: ['null', int]
    doc: "Value for the set_counts operation (all k-mer counts are set to it)"
    inputBinding:
      position: 21
  - id: dump_sorted
    type: ['null', boolean]
    doc: "For the dump operation: sorted output (-s)"
    inputBinding:
      position: 22
      prefix: "-s"
  - id: output_name
    type: string
    doc: "Path of the output (text file for dump and histogram, KMC database name for the other operations)"
    inputBinding:
      position: 23
  - id: output_ci
    type: ['null', int]
    doc: "Output parameter: exclude k-mers occurring less than this many times (histogram: minimum counter value stored)"
    inputBinding:
      position: 24
      prefix: "-ci"
      separate: false
  - id: output_cx
    type: ['null', int]
    doc: "Output parameter: exclude k-mers occurring more than this many times (histogram: maximum counter value stored)"
    inputBinding:
      position: 25
      prefix: "-cx"
      separate: false
  - id: output_cs
    type: ['null', int]
    doc: "Output parameter: maximal value of a counter (sort and reduce)"
    inputBinding:
      position: 26
      prefix: "-cs"
      separate: false
  - id: output_format
    type: ['null', string]
    doc: "Output format kmc or kff (compact, reduce, set_counts and sort; given as -o<value>)"
    inputBinding:
      position: 27
      prefix: "-o"
      separate: false
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Output files (<name> for text outputs, <name>.kmc_pre and <name>.kmc_suf for databases)"
    outputBinding:
      glob:
        - $(inputs.output_name)
        - $(inputs.output_name).kmc_*
        - $(inputs.output_name).kff
  - id: stdout
    type: stdout
    doc: "Standard output"
arguments:
  - position: 4
    valueFrom: transform
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
stdout: kmc_tools_transform.out
