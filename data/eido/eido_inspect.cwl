cwlVersion: v1.2
class: CommandLineTool
baseCommand: eido_inspect
label: eido_inspect
doc: "Inspect a PEP\n\nTool homepage: https://github.com/mayneyao/eidos"
inputs:
  - id: pep
    type: File
    doc: Path to a PEP configuration file in yaml format.
    inputBinding:
      position: 1
  - id: attr_limit
    type:
      - 'null'
      - int
    doc: Number of sample attributes to display.
    inputBinding:
      position: 102
      prefix: --attr-limit
  - id: sample_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of the samples to inspect.
    inputBinding:
      position: 102
      prefix: --sample-name
  - id: st_index
    type:
      - 'null'
      - string
    doc: Sample table index to use, samples are identified by 'sample_name' by 
      default.
    inputBinding:
      position: 102
      prefix: --st-index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/eido:0.1.9_cv2
stdout: eido_inspect.out
