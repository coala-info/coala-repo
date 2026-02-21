cwlVersion: v1.2
class: CommandLineTool
baseCommand: pwiz-i-agree-to-the-vendor-licenses
label: pwiz-i-agree-to-the-vendor-licenses
doc: The provided text is a container runtime error log and does not contain CLI help
  information or usage instructions.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pwiz-i-agree-to-the-vendor-licenses:phenomenal-v3.0.18205_cv1.3.58
stdout: pwiz-i-agree-to-the-vendor-licenses.out
