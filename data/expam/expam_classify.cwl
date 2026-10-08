cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - classify
label: expam_classify
doc: "Classify reads against the database. Writes phylogenetic results (phy/) and, with --taxonomy, taxonomic results (tax/).\n\nTool homepage: https://github.com/seansolari/expam"
inputs:
  - id: database
    type: Directory
    doc: "Expam database directory (-db). It is staged writable in the work directory and returned as an output."
    inputBinding:
      position: 1
      prefix: -db
      valueFrom: $(self.basename)
  - id: reads
    type: Directory
    doc: "Directory of read files (-d). They are staged in the work directory."
    inputBinding:
      position: 101
      prefix: -d
      valueFrom: $(self.basename)
  - id: out_name
    type: string
    doc: "Name of the results directory (-o). It is created in the work directory."
    inputBinding:
      position: 1
      prefix: -o
  - id: paired
    type:
      - 'null'
      - boolean
    doc: "Treat reads as paired-end."
    inputBinding:
      position: 101
      prefix: --paired
  - id: taxonomy
    type:
      - 'null'
      - boolean
    doc: "Convert phylogenetic results to taxonomic results."
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: cpm
    type:
      - 'null'
      - float
    doc: "Counts/million cutoff for read-count to be non-negligible."
    inputBinding:
      position: 101
      prefix: --cpm
  - id: alpha
    type:
      - 'null'
      - float
    doc: "Percentage requirement for classification subtrees (see Tutorials 1 and 2)."
    inputBinding:
      position: 101
      prefix: --alpha
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
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Set logging level to DEBUG (as opposed to INFO)."
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: results
    type:
      - 'null'
      - Directory
    doc: "Results directory with phy/classified.csv, phy/split.csv, per-sample files and raw read-wise output"
    outputBinding:
      glob: $(inputs.out_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
      - entry: $(inputs.reads)
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
