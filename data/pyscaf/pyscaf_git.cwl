cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscaf
label: pyscaf_git
doc: "A tool for genomic scaffold linking and finishing (Note: The provided text is
  a container build log and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/pyscaffold/pyscaffold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscaf:0.12a4--py27_0
stdout: pyscaf_git.out
