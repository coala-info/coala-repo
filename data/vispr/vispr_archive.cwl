cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vispr
  - archive
label: vispr_archive
doc: "Create a compressed archive for easy distribution of a given config file with
  all referenced files.\n\nTool homepage: https://bitbucket.org/liulab/vispr"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.config)
      - $(inputs.referenced_files)
inputs:
  - id: config
    type: File
    doc: YAML config file pointing to MAGeCK results.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: referenced_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file (staged next to the config file so the
      relative paths resolve).
  - id: tarfile
    type: string
    doc: The tar archive to write. Has to end with .tar, .tar.gz, or .tar.bz2
    inputBinding:
      position: 2
outputs:
  - id: tarfile_out
    type: File
    doc: The tar archive to write.
    outputBinding:
      glob: $(inputs.tarfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
