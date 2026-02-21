cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod_cover
label: perl-pod-coverage_pod_cover
doc: "Pod coverage analysis tool\n\nTool homepage: https://github.com/richardc/perl-pod-coverage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-coverage:0.23--pl5.22.0_0
stdout: perl-pod-coverage_pod_cover.out
