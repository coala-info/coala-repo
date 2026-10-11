cwlVersion: v1.2
class: CommandLineTool
baseCommand: [neurodocker, reprozip, trace]
label: neurodocker_reprozip_trace
doc: "Minify a container for traced command(s): trace the commands in a running Docker
  container and save a ReproZip pack file.\n\nTool homepage: https://github.com/kaczmarj/neurodocker"
inputs:
  - id: container
    type: string
    doc: Running container in which to trace commands.
    inputBinding:
      position: 3
  - id: commands
    type:
      type: array
      items: string
    doc: Command(s) to trace.
    inputBinding:
      position: 4
  - id: packfile_save_dir
    type:
      - 'null'
      - string
    doc: Directory in which to save the pack file (default current directory).
    inputBinding:
      position: 1
      prefix: --dir
  - id: verbosity
    type:
      - 'null'
      - type: enum
        symbols: [debug, info, warning, error, critical]
        name: neurodocker_trace_verbosity
    doc: Logging verbosity.
    inputBinding:
      position: 2
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pack_files
    type:
      type: array
      items: File
    doc: ReproZip pack files.
    outputBinding:
      glob: |-
        ${ return (inputs.packfile_save_dir ? inputs.packfile_save_dir + '/' : '') + '*.rpz'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neurodocker:0.5.0--py_0
stdout: neurodocker_reprozip_trace.out
