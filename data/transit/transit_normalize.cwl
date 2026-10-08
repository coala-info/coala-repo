cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - normalize
label: transit_normalize
doc: "Normalize a wig file, or the samples of a combined wig file, and write the normalized counts.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: input_wig
    type: ['null', File]
    doc: "Input wig file (use this or input_combined_wig)"
    inputBinding:
      position: 1
  - id: input_combined_wig
    type: ['null', File]
    doc: "Input combined wig file (use this or input_wig)"
    inputBinding:
      position: 1
      prefix: -c
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 2
  - id: normalization_method
    type: ['null', string]
    doc: "Normalization method: TTR or betageom. Default: TTR"
    inputBinding:
      position: 20
      prefix: -n
outputs:
  - id: output_wig
    type: File
    doc: "Normalized output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
