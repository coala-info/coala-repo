cwlVersion: v1.2
class: CommandLineTool
baseCommand: ramid
label: ramid
doc: "Retention time Alignment for Mass spectrometry Ion Data (Note: The provided
  text is a container build log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/eboigne/PyRAMID-CT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ramid:phenomenal-v1.0_cv1.0.18
stdout: ramid.out
