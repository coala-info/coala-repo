cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - marge
  - init
label: marge_init
doc: "MARGE is a free software to predict key regulated genes and cis-regulatory regions
  in human or mouse.\n\nTool homepage: http://cistrome.org/MARGE"
inputs:
  - id: directory
    type: string
    doc: Path to the directory where the workflow shall be initialized.
    inputBinding:
      position: 1
outputs:
  - id: workflow_dir
    type: Directory
    doc: Directory with the initialized workflow (Snakefile and config.json)
    outputBinding:
      glob: $(inputs.directory)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marge:1.0--py35h24bf2e0_1
stdout: marge_init.out
