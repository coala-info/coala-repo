cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - phylotree
label: expam_phylotree
doc: "Draw results on phylotree.\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
  - id: results_in
    type: Directory
    doc: "Results directory of an earlier expam classify run (-o). It is staged writable in the work directory."
    inputBinding:
      position: 1
      prefix: -o
      valueFrom: $(self.basename)
  - id: cpm
    type:
      - 'null'
      - float
    doc: "Counts/million cutoff for read-count to be non-negligible."
    inputBinding:
      position: 101
      prefix: --cpm
  - id: group
    type:
      - 'null'
      - type: array
        items: string
    doc: "Space-separated list of sample files to be treated as a single group in phylotree (--group)."
    inputBinding:
      position: 101
      prefix: --group
  - id: colour_list
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of hex colours to use when plotting groups in phylotree."
    inputBinding:
      position: 101
      prefix: --colour-list
  - id: keep_zeros
    type:
      - 'null'
      - boolean
    doc: "Keep nodes of output where no reads have been assigned."
    inputBinding:
      position: 101
      prefix: --keep-zeros
  - id: ignore_names
    type:
      - 'null'
      - boolean
    doc: "Do not label phylotree nodes with names."
    inputBinding:
      position: 101
      prefix: --ignore-names
  - id: log_scores
    type:
      - 'null'
      - boolean
    doc: "Log transformation to opacity scores on phylotree (think uneven distributions)."
    inputBinding:
      position: 101
      prefix: --log-scores
  - id: itol
    type:
      - 'null'
      - boolean
    doc: "Output plotting data in ITOL format."
    inputBinding:
      position: 101
      prefix: --itol
  - id: flat_colour
    type:
      - 'null'
      - boolean
    doc: "Do not use abundance to make phylotree colours opaque."
    inputBinding:
      position: 101
      prefix: --flat-colour
outputs:
  - id: results
    type:
      - 'null'
      - Directory
    doc: "Results directory with the phylotree plots or iTOL files"
    outputBinding:
      glob: $(inputs.results_in.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
      - entry: $(inputs.results_in)
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: expam
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
