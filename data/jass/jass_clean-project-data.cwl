cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - clean-project-data
label: jass_clean-project-data
doc: "Cleans project data by removing files that have not been accessed for a specified
  number of days.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: max_days_without_access
    type:
      - 'null'
      - int
    doc: Maximum number of days without access to retain files. Files older than
      this will be removed.
    inputBinding:
      position: 101
      prefix: --max-days-without-access
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass_clean-project-data.out
