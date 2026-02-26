cwlVersion: v1.2
class: CommandLineTool
baseCommand: darkprofiler download
label: darkprofiler_download
doc: "Download reference genome assemblies for darkprofiler.\n\nTool homepage: https://pypi.org/project/darkprofiler/"
inputs:
  - id: reference_assembly
    type: string
    doc: Reference assembly version to download.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/darkprofiler:0.2.6--pyhdfd78af_0
stdout: darkprofiler_download.out
