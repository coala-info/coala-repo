cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncl-tools
label: ncl-tools
doc: "The NEXUS Class Library (NCL) is a C++ library for parsing NEXUS files. This
  package includes various tools for processing and validating phylogenetic data in
  NEXUS format.\n\nTool homepage: https://github.com/ethz-asl/nclt_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncl-tools:v2.1.21git20180827.c71b264-2-deb_cv1
stdout: ncl-tools.out
