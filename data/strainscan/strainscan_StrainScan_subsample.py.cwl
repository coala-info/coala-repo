cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainscan_StrainScan_subsample.py
label: strainscan_StrainScan_subsample.py
doc: "A tool for subsampling reads, typically used within the StrainScan pipeline.
  (Note: The provided help text contains system error messages and does not list specific
  arguments or descriptions.)\n\nTool homepage: https://github.com/liaoherui/StrainScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainscan:1.0.14--pyhdfd78af_1
stdout: strainscan_StrainScan_subsample.py.out
