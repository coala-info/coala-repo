cwlVersion: v1.2
class: CommandLineTool
baseCommand: reformat_pyhmmsearch
label: pyhmmsearch_reformat_pyhmmsearch
doc: "Reformat the hit table written by pyhmmsearch into one row per protein (table) or
  a pickled dictionary (pickle), optionally keeping only the best hit.\n\nTool homepage:
  https://github.com/jolespin/pyhmmsearch"
inputs:
  - id: input
    type: File
    doc: path/to/input.tsv. The results of pyhmmsearch
    inputBinding:
      position: 1
      prefix: --input
  - id: output_path
    type: string
    doc: path/to/output.tsv
    inputBinding:
      position: 2
      prefix: --output
  - id: format
    type: ['null', string]
    doc: Output format (pickle or table)
    inputBinding:
      position: 3
      prefix: --format
  - id: no_header
    type: ['null', boolean]
    doc: Input does not have header
    inputBinding:
      position: 4
      prefix: --no_header
  - id: best_hits_only
    type: ['null', boolean]
    doc: Best hits only
    inputBinding:
      position: 5
      prefix: --best_hits_only
outputs:
  - id: output
    type: File
    doc: Reformatted hit table
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
