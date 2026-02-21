cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-nextgen-vm
label: bcbio-nextgen-vm
doc: "bcbio-nextgen-vm (Note: The provided text is a system error log regarding a
  container build failure and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/chapmanb/bcbio-nextgen-vm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen-vm:0.1.0a--py27_86
stdout: bcbio-nextgen-vm.out
