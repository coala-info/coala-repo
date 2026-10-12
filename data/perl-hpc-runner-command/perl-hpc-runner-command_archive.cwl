cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hpcrunner.pl
  - archive
label: perl-hpc-runner-command_archive
doc: "Create an archive of results. Default is to add all files in your current working directory\n\nTool homepage: https://github.com/biosails/HPC-Runner-Command"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TZ
        envValue: UTC
inputs:
  - id: include_paths
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --include_paths
    doc: "Include files or directories"
    inputBinding:
      position: 101
  - id: exclude_paths
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude_paths
    doc: "Files or directories to exclude"
    inputBinding:
      position: 101
  - id: archive
    type:
      - 'null'
      - string
    doc: "Name of the archive file to write"
    inputBinding:
      position: 101
      prefix: --archive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: archive_file
    type:
      - 'null'
      - File
    doc: Archive written with the archive option
    outputBinding:
      glob: $(inputs.archive)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
stdout: perl-hpc-runner-command_archive.out
