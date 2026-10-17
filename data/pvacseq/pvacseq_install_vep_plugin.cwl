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
      valueFrom: $(self.basename)
outputs:
  - id: vep_plugins_dir
    type: Directory
    doc: VEP_plugins directory with the pVACseq plugin added
    outputBinding:
      glob: $(inputs.vep_plugins_path.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.vep_plugins_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
stdout: pvacseq_install_vep_plugin.out
