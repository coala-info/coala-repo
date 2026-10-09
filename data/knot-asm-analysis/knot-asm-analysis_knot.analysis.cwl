cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.analysis
label: knot-asm-analysis_knot.analysis
doc: "Generate a report from knot output.\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: classification
    type:
      - 'null'
      - boolean
    doc: Add path classification in report
    inputBinding:
      position: 101
      prefix: --classification
  - id: hamilton_path
    type:
      - 'null'
      - boolean
    doc: Add hamilton path in report
    inputBinding:
      position: 101
      prefix: --hamilton-path
  - id: aag_file
    type: File
    doc: assembly-assembly graph <input_prefix>_AAG.csv written by knot; staged in the working directory
  - id: knot_dir
    type: Directory
    doc: directory <input_prefix>_knot written by knot (needs contigs.fasta); staged writable because the report step writes classification.csv and hamilton_path.csv there
  - id: input_prefix
    type: string
    doc: prefix of knot output (the names of aag_file and knot_dir must be <input_prefix>_AAG.csv and <input_prefix>_knot)
    inputBinding:
      position: 101
      prefix: --input_prefix
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: path where report was write
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.aag_file)
      - entry: $(inputs.knot_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
