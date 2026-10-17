cwlVersion: v1.2
class: CommandLineTool
baseCommand: reformat_pykofamsearch
label: pykofamsearch_reformat_pykofamsearch
doc: "Reformat the hit table written by pykofamsearch into one row per protein (table)
  or a pickled dictionary (pickle), optionally keeping only the best hit.\n\nTool
  homepage: https://github.com/jolespin/pykofamsearch"
inputs:
  - id: input
    type: File
    doc: path/to/input.tsv. The results of pykofamsearch
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
    doc: Output format (table or pickle)
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
    dockerPull: quay.io/biocontainers/pykofamsearch:2025.9.5--pyhdfd78af_1
