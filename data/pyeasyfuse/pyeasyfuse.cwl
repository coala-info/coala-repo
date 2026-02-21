cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyeasyfuse
label: pyeasyfuse
doc: "A tool for pyeasyfuse (Note: The provided text appears to be a container build
  log rather than help documentation, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/TRON-bioinformatics/easyfuse-src"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyeasyfuse:2.0.3--py37r42hdfd78af_0
stdout: pyeasyfuse.out
