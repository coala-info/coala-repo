cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tree-dag_node
label: perl-tree-dag_node
doc: "FATAL: Unable to handle docker://quay.io/biocontainers/perl:5.32 uri: failed
  to get checksum for docker://quay.io/biocontainers/perl:5.32: error parsing IndexManifest:
  EOF\n\nTool homepage: http://metacpan.org/pod/Tree-DAG_Node"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl:5.32
stdout: perl-tree-dag_node.out
