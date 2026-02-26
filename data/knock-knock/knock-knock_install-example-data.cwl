cwlVersion: v1.2
class: CommandLineTool
baseCommand: knock-knock install-example-data
label: knock-knock_install-example-data
doc: "Installs example data for a knock-knock project.\n\nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs:
  - id: base_dir
    type: Directory
    doc: the base directory to store input data, reference annotations, and 
      analysis output for a project
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_install-example-data.out
