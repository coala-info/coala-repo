cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bcbio_vm.py, run]
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: bcbio
  - class: InitialWorkDirRequirement
    listing:
      - ${ return [inputs.sample_config].concat(inputs.sample_files || []); }
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
label: bcbio-nextgen-vm_run
doc: "Run an automated analysis on the local machine (inside the bcbio Docker container)\n\nTool homepage:\
  \ https://github.com/bcbio/bcbio-nextgen-vm"
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
  - id: fcdir
    type:
      - 'null'
      - Directory
    doc: A directory of Illumina output or fastq files to process
    inputBinding:
      position: 1
      prefix: --fcdir
  - id: image
    type:
      - 'null'
      - string
    doc: Docker image name to use, could point to compatible pre-installed image.
    inputBinding:
      position: 1
      prefix: --image
  - id: systemconfig
    type:
      - 'null'
      - File
    doc: Global YAML configuration file specifying system details. Defaults to installed bcbio_system.yaml.
    inputBinding:
      position: 1
      prefix: --systemconfig
  - id: numcores
    type:
      - 'null'
      - int
    doc: Total cores to use for processing
    inputBinding:
      position: 1
      prefix: --numcores
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Files and directories written to the working directory (work and final upload folders)
    outputBinding:
      glob: '*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
