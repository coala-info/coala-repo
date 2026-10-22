cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - collapse
label: slamdunk_alleyoop_collapse
doc: "Collapse UTRs\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: tcount
    type:
      type: array
      items: File
    doc: 'Tcount file(s)'
    inputBinding:
      position: 100
  - id: threads
    type: ['null', int]
    doc: 'Thread number (default: 1)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: output_dir
    type: string
    default: collapse_out
    doc: Output directory
    inputBinding:
      position: 1
      prefix: --outputDir
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
