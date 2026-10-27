cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - expand-descriptors
label: voronota_expand-descriptors
doc: "Expands atom descriptors in text.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_text
    type: File
    doc: "any text containing atom descriptors (stdin)"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_text.path)
stdout: voronota_expand-descriptors.out
