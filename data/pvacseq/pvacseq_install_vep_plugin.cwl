cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - install_vep_plugin
label: pvacseq_install_vep_plugin
doc: "Install the pVACseq VEP plugin into your VEP_plugins directory\n\nTool homepage:
  https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: vep_plugins_path
    type: Directory
    doc: Path to your VEP_plugins directory
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
stdout: pvacseq_install_vep_plugin.out
