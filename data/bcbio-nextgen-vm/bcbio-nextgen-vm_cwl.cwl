cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bcbio_vm.py, cwl]
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: bcbio
  - class: InitialWorkDirRequirement
    listing:
      - ${ return [inputs.sample_config].concat(inputs.sample_files || []); }
  - class: InlineJavascriptRequirement
label: bcbio-nextgen-vm_cwl
doc: "Generate Common Workflow Language (CWL) from configuration inputs\n\nTool homepage: https://github.com/bcbio/bcbio-nextgen-vm"
inputs:
  - id: sample_config
    type: File
    doc: YAML file with details about samples to process (staged in the working directory).
    inputBinding:
      position: 10
      valueFrom: $(self.basename)
  - id: sample_files
    type:
      - 'null'
      - File[]
    doc: Read and other files named in the sample YAML; staged with the YAML in the working directory
      so relative names resolve
  - id: systemconfig
    type:
      - 'null'
      - File
    doc: Global YAML configuration file specifying system details. Defaults to installed bcbio_system.yaml.
    inputBinding:
      position: 1
      prefix: --systemconfig
  - id: add_container_tag
    type:
      - 'null'
      - string
    doc: Add a container revision tag to CWL ('quay_lookup' retrieves latest from quay.io)
    inputBinding:
      position: 1
      prefix: --add-container-tag
outputs:
  - id: workflow_dir
    type: Directory
    doc: Generated CWL workflow directory (<sample_config>-workflow with main-<name>.cwl and steps/)
    outputBinding:
      glob: $(inputs.sample_config.nameroot)-workflow
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
