cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pydamage
arguments:
  - position: 3
    valueFrom: binplot
label: pydamage_binplot
doc: "Plot Damage patterns for a given bin fasta file. CSV: path to PyDamage result file. FASTA: path to bin fasta file.\n\nTool homepage: https://github.com/maxibor/pydamage"
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
  - id: csv
    type: File
    doc: "Path to PyDamage result file."
    inputBinding:
      position: 5
  - id: fasta
    type: File
    doc: "Path to bin fasta file."
    inputBinding:
      position: 6
outputs:
  - id: results_dir
    type: Directory
    doc: "Output directory with the results."
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir : 'pydamage_results')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: "$(inputs.outdir ? inputs.outdir : 'pydamage_results')"
        entry: "$({class: 'Directory', basename: (inputs.outdir ? inputs.outdir : 'pydamage_results'), listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
