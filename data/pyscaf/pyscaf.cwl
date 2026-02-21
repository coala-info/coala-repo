cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscaf
label: pyscaf
doc: "A tool for scaffolding genomic assemblies using various types of long-range
  information (Note: The provided text contains container runtime errors rather than
  command-line help documentation).\n\nTool homepage: https://github.com/pyscaffold/pyscaffold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscaf:0.12a4--py27_0
stdout: pyscaf.out
