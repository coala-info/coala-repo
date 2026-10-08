cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haphpipe
  - demo
label: haphpipe_demo
doc: "Runs a demo of HAPHPipe.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: outdir
    type:
      - 'null'
      - string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: refonly
    type:
      - 'null'
      - boolean
    doc: Does not run entire demo, only pulls the reference files
    inputBinding:
      position: 101
      prefix: --refonly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.outdir ? [{entryname: inputs.outdir, entry: {class: 'Directory', listing: []}, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_demo.out
