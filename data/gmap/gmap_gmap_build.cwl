cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmap_build
label: gmap_gmap_build
doc: "The provided text contains a system error message regarding container execution
  and does not include the help documentation for gmap_build. As a result, no arguments
  could be extracted.\n\nTool homepage: http://research-pub.gene.com/gmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
stdout: gmap_gmap_build.out
