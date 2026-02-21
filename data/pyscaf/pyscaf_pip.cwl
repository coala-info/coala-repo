cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscaf
label: pyscaf_pip
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool.\n\nTool
  homepage: https://github.com/pyscaffold/pyscaffold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscaf:0.12a4--py27_0
stdout: pyscaf_pip.out
