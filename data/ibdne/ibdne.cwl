cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - zcat
  - -f
label: ibdne
doc: "Estimates historical effective population size from identity by descent (IBD)
  segments. The IBD files (plain or gzip) are concatenated with zcat -f (same as cat for plain files) and piped into ibdne.\n\nTool
  homepage: https://faculty.washington.edu/browning/ibdne.html"
inputs:
  - id: ibd_files
    type:
      type: array
      items: File
    doc: Beagle-format IBD files, concatenated and piped to ibdne
    inputBinding:
      position: 1
  - id: map
    type: File
    doc: PLINK-format genetic map with cM distances
    inputBinding:
      position: 11
      prefix: map=
      separate: false
  - id: out_prefix
    type: string
    doc: Output file prefix
    inputBinding:
      position: 12
      prefix: out=
      separate: false
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: Java memory option passed to the ibdne wrapper script (for example -Xmx4g)
    inputBinding:
      position: 10
  - id: minibd
    type:
      - 'null'
      - float
    doc: Min cM length of an IBD segment (default 4.0)
    inputBinding:
      position: 13
      prefix: minibd=
      separate: false
  - id: minregion
    type:
      - 'null'
      - float
    doc: Min cM length of a continuous region (default 50.0)
    inputBinding:
      position: 14
      prefix: minregion=
      separate: false
  - id: filtersamples
    type:
      - 'null'
      - boolean
    doc: Whether to filter samples (default true)
    inputBinding:
      position: 15
      valueFrom: '$(self === null ? null : "filtersamples=" + self)'
  - id: trim
    type:
      - 'null'
      - float
    doc: cM to trim from ends of each region (default 0.2)
    inputBinding:
      position: 16
      prefix: trim=
      separate: false
  - id: nits
    type:
      - 'null'
      - int
    doc: Number of iterations (default 50)
    inputBinding:
      position: 17
      prefix: nits=
      separate: false
  - id: nstarts
    type:
      - 'null'
      - int
    doc: Number of random starts (default 50)
    inputBinding:
      position: 18
      prefix: nstarts=
      separate: false
  - id: nboots
    type:
      - 'null'
      - int
    doc: Number of bootstrap samples (default 80)
    inputBinding:
      position: 19
      prefix: nboots=
      separate: false
  - id: gmax
    type:
      - 'null'
      - int
    doc: Max number of generations before present (default depends on minibd)
    inputBinding:
      position: 20
      prefix: gmax=
      separate: false
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator (default -99999)
    inputBinding:
      position: 21
      prefix: seed=
      separate: false
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of computational threads (default 1)
    inputBinding:
      position: 22
      prefix: nthreads=
      separate: false
outputs:
  - id: ne_estimates
    type: File
    doc: Effective population size estimates per generation
    outputBinding:
      glob: $(inputs.out_prefix).ne
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.out_prefix).log
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
arguments:
  - position: 2
    shellQuote: false
    valueFrom: "| ibdne"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
