cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_basenji_sat_vcf.py
label: basenji_basenji_sat_vcf.py
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process due to insufficient disk space.\n\nTool homepage:
  https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_sat_vcf.py.out
