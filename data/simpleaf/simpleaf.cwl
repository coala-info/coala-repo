cwlVersion: v1.2
class: CommandLineTool
baseCommand: simpleaf
label: simpleaf
doc: "The provided text does not contain help information or usage instructions; it
  consists of container build logs and a fatal error message regarding a SIF format
  conversion failure.\n\nTool homepage: https://github.com/COMBINE-lab/simpleaf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simpleaf:0.19.5--ha6fb395_0
stdout: simpleaf.out
