cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextstrain_deploy
label: nextstrain_deploy
doc: "Uploads (deploys) a set of built pathogen JSON data files or Markdown narratives
  to a remote source.\n\nTool homepage: https://nextstrain.org"
inputs:
  - id: remote_path
    type: string
    doc: Remote path as a URL, with optional key/path prefix
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Files to upload, typically Auspice JSON data files
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
stdout: nextstrain_deploy.out
