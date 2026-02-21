cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-snapfun
label: profnet-snapfun
doc: The provided text does not contain help information for the tool; it contains
  container runtime logs and a fatal error message regarding an image build failure.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-snapfun:v1.0.22-6-deb_cv1
stdout: profnet-snapfun.out
