cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - cutoff
label: expam_cutoff
doc: "Apply cutoff to some set of already processed classifications. THIS WILL OVERWRITE OLD RESULTS!\n\nTool homepage: https://github.com/seansolari/expam"
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
  - id: taxonomy
    type:
      - 'null'
      - boolean
    doc: "Also convert the cut-off phylogenetic results to taxonomic results."
    inputBinding:
      position: 101
      prefix: --taxonomy
outputs:
  - id: results
    type:
      - 'null'
      - Directory
    doc: "Results directory with the re-summarised output"
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
