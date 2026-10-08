cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - to_taxonomy
label: expam_to_taxonomy
doc: "Convert phylogenetic results to taxonomic setting.\n\nTool homepage: https://github.com/seansolari/expam"
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
outputs:
  - id: results
    type:
      - 'null'
      - Directory
    doc: "Results directory with the added taxonomic output (tax/)"
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
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
    dockerOutputDirectory: /w
