cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-coverage-trustpod
label: perl-pod-coverage-trustpod
doc: "A tool to check POD coverage using Pod::Coverage::TrustPod, which allows for
  trusting specific symbols via the =for Pod::Coverage directive.\n\nTool homepage:
  https://github.com/rjbs/Pod-Coverage-TrustPod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-pod-coverage-trustpod:0.100006--pl5321hdfd78af_0
stdout: perl-pod-coverage-trustpod.out
