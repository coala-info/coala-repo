cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio_vm.py
label: bcbio-nextgen-vm_bcbio_vm.py
doc: "Automatic installation for bcbio-nextgen pipelines, with docker.\n\nTool homepage:
  https://github.com/chapmanb/bcbio-nextgen-vm"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: datadir
    type:
      - 'null'
      - Directory
    doc: Directory with genome data and associated files.
    inputBinding:
      position: 102
      prefix: --datadir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
stdout: bcbio-nextgen-vm_bcbio_vm.py.out
