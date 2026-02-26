cwlVersion: v1.2
class: CommandLineTool
baseCommand: vispr archive
label: vispr_archive
doc: "Create a compressed archive for easy distribution of a given config file with
  all referenced files.\n\nTool homepage: https://bitbucket.org/liulab/vispr"
inputs:
  - id: config
    type: File
    doc: YAML config file pointing to MAGeCK results.
    inputBinding:
      position: 1
  - id: tarfile
    type: File
    doc: The tar archive to write. Has to end with .tar, .tar.gz, or .tar.bz2
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
stdout: vispr_archive.out
