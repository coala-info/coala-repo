cwlVersion: v1.2
class: CommandLineTool
baseCommand: chira_chira_merge.py
label: chira_chira_merge.py
doc: "Merge multiple ChiRA (Chimeric Read Analysis) results into a single output.\n
  \nTool homepage: https://github.com/pavanvidem/chira/"
inputs:
  - id: indices
    type:
      type: array
      items: File
    doc: Input ChiRA result files to be merged.
    inputBinding:
      position: 101
      prefix: --indices
outputs:
  - id: output
    type: File
    doc: Output file to write the merged results.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
