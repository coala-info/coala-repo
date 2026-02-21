cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bolt
  - call
label: bolt_call
doc: "Call variants using the BOLT tool\n\nTool homepage: https://github.com/sakkayaphab/bolt"
inputs:
  - id: reference_file
    type: File
    doc: reference file path
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_file
    type: File
    doc: sample file path
    inputBinding:
      position: 101
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_path
    type: File
    doc: output path
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bolt:0.3.0--h3889886_0
