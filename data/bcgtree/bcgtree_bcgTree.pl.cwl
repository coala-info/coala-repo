cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcgTree.pl
label: bcgtree_bcgTree.pl
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/molbiodiv/bcgtree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcgtree:1.2.1--pl5321hdfd78af_0
stdout: bcgtree_bcgTree.pl.out
