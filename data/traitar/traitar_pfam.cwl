cwlVersion: v1.2
class: CommandLineTool
baseCommand: traitar pfam
label: traitar_pfam
doc: "Download and uncompress pfam files.\nThe files are required for gene annotation.\n\
  \nTool homepage: http://github.com/aweimann/traitar"
inputs:
  - id: download_dir
    type: Directory
    doc: Download Pfam HMMs into this directory and untar and unzip them
    inputBinding:
      position: 1
  - id: local
    type:
      - 'null'
      - boolean
    doc: The Pfam HMMs are in the above directory with name "Pfam-A.hmm"
    inputBinding:
      position: 102
      prefix: --local
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
stdout: traitar_pfam.out
