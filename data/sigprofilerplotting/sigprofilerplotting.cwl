cwlVersion: v1.2
class: CommandLineTool
baseCommand: sigprofilerplotting
label: sigprofilerplotting
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: https://github.com/alexandrovlab/SigProfilerPlotting"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
stdout: sigprofilerplotting.out
