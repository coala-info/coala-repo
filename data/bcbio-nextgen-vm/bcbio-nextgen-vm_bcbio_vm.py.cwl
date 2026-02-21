cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio_vm.py
label: bcbio-nextgen-vm_bcbio_vm.py
doc: "The provided text contains system logs and error messages related to a container
  build failure (no space left on device) rather than the help documentation for the
  tool. As a result, no command-line arguments could be extracted.\n\nTool homepage:
  https://github.com/chapmanb/bcbio-nextgen-vm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen-vm:0.1.0a--py27_86
stdout: bcbio-nextgen-vm_bcbio_vm.py.out
