cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbb
label: tbb
doc: "Intel Threading Building Blocks (TBB) is a C++ library for shared-memory parallel
  programming and heterogeneous computing. (Note: The provided text is a container
  build error log and does not contain CLI usage information.)\n\nTool homepage: https://github.com/uxlfoundation/oneTBB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbb:4.4_20150728--0
stdout: tbb.out
