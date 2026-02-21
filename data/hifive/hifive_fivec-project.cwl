cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hifive
  - fivec-project
label: hifive_fivec-project
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log indicating a 'no space left on device' failure
  during a SIF image build.\n\nTool homepage: https://github.com/bxlab/hifive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifive:1.5.7--py27h24bf2e0_0
stdout: hifive_fivec-project.out
