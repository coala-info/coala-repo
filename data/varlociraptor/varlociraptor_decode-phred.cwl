cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varlociraptor
  - decode-phred
label: varlociraptor_decode-phred
doc: 'Decode PHRED-scaled values to human readable probabilities. Input is read from
  standard input.


  Tool homepage: https://varlociraptor.github.io'
inputs:
  - id: input_bcf
    type: File
    doc: Input BCF file (standard input)
outputs:
  - id: output_bcf
    type: stdout
    doc: Output BCF file
stdin: $(inputs.input_bcf.path)
stdout: decoded.bcf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
