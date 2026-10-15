cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_subsets_of_tiled_probes
label: phyluce_phyluce_probe_get_subsets_of_tiled_probes
doc: "Given an input file of probes, filter the list for certain taxa\n\nTool homepage:\
  \ https://github.com/faircloth-lab/phyluce"
inputs:
  - id: probes
    type: File
    doc: The probe file to filter.
    inputBinding:
      prefix: --probes
  - id: taxa
    type:
      type: array
      items: string
    doc: The taxa for which to filter probes.
    inputBinding:
      prefix: --taxa
  - id: output_path
    type: string
    doc: The file in which to store the output.
    inputBinding:
      prefix: --output
  - id: regex
    type:
      - 'null'
      - string
    doc: A regular expression to apply to the probe names for replacement [default='^(uce-\d+)(?:_p\d+.*)'].
    inputBinding:
      prefix: --regex
outputs:
  - id: output
    type: File
    doc: The filtered probe file.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
