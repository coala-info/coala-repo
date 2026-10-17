cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pydamage
arguments:
  - position: 3
    valueFrom: analyze
label: pydamage_analyze
doc: "Run the PyDamage analysis. BAM: path to BAM/SAM/CRAM alignment file. MD tags need to be set.\n\nTool homepage: https://github.com/maxibor/pydamage"
inputs:
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory (default: pydamage_results)."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Predicted accuracy filtering threshold. Set to 0 for finding threshold with kneed method (default: 0.5)."
    inputBinding:
      position: 2
      prefix: --threshold
  - id: bam
    type: File
    doc: "Path to BAM/SAM/CRAM alignment file. MD tags need to be set."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 5
  - id: wlen
    type:
      - 'null'
      - int
    doc: "Window length (in bp) for damage modeling (default: 13)."
    inputBinding:
      position: 4
      prefix: --wlen
  - id: minlen
    type:
      - 'null'
      - int
    doc: "Minimum of length of reference sequence to consider (default: 0)."
    inputBinding:
      position: 4
      prefix: --minlen
  - id: process
    type:
      - 'null'
      - int
    doc: "Number of processes for parallel computing (default: 2)."
    inputBinding:
      position: 4
      prefix: --process
  - id: show_al
    type:
      - 'null'
      - boolean
    doc: "Display alignments representations."
    inputBinding:
      position: 4
      prefix: --show_al
  - id: plot
    type:
      - 'null'
      - boolean
    doc: "Write damage fitting plots to disk."
    inputBinding:
      position: 4
      prefix: --plot
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode."
    inputBinding:
      position: 4
      prefix: --verbose
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force overwriting of results directory."
    inputBinding:
      position: 4
      prefix: --force
  - id: group
    type:
      - 'null'
      - boolean
    doc: "Use entire BAM file as single reference for analysis (ignore reference headers)."
    inputBinding:
      position: 4
      prefix: --group
  - id: no_ga
    type:
      - 'null'
      - boolean
    doc: "Do not use G->A transitions."
    inputBinding:
      position: 4
      prefix: --no_ga
  - id: rescale
    type:
      - 'null'
      - boolean
    doc: "Rescale base quality scores using the PyDamage damage model. Mutually exclusive with subsample."
    inputBinding:
      position: 4
      prefix: --rescale
  - id: subsample
    type:
      - 'null'
      - float
    doc: "Subsample a fraction of the reads for damage modeling (0 to 1). Mutually exclusive with rescale."
    inputBinding:
      position: 4
      prefix: --subsample
outputs:
  - id: results_dir
    type: Directory
    doc: "Output directory with the results."
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir : 'pydamage_results')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
