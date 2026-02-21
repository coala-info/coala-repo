cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal
label: reveal_npm
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a set of log messages from a container runtime (Singularity/Apptainer)
  reporting a fatal error during an image build process.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_npm.out
