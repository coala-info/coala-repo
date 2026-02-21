cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainr2_PreProcessR
label: strainr2_PreProcessR
doc: "The provided text does not contain help information for the tool; it is a container
  engine error log reporting a failure to fetch the OCI image.\n\nTool homepage: https://github.com/BisanzLab/StrainR2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainr2:2.3.0--r44h577a1d6_0
stdout: strainr2_PreProcessR.out
