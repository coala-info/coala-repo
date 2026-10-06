cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bcbio_vm.py, template]
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: bcbio
label: bcbio-nextgen-vm_template
doc: "Create a bcbio sample.yaml file from a standard template and inputs\n\nTool homepage: https://github.com/bcbio/bcbio-nextgen-vm"
inputs:
  - id: template
    type:
      - File
      - string
    doc: 'Template name or path to template YAML file. Built in choices (fetched from GitHub): freebayes-variant,
      gatk-variant, tumor-paired, noalign-variant, illumina-rnaseq, illumina-chipseq'
    inputBinding:
      position: 10
  - id: metadata
    type: File
    doc: CSV file with project metadata. Name of file used as project name.
    inputBinding:
      position: 11
  - id: input_files
    type:
      - 'null'
      - File[]
    doc: Input read files, in BAM or fastq format
    inputBinding:
      position: 12
  - id: only_metadata
    type:
      - 'null'
      - boolean
    doc: Ignore samples not present in metadata CSV file
    inputBinding:
      position: 1
      prefix: --only-metadata
  - id: force_single
    type:
      - 'null'
      - boolean
    doc: Treat all files as single reads
    inputBinding:
      position: 1
      prefix: --force-single
  - id: separators
    type:
      - 'null'
      - string
    doc: semicolon separated list of separators that indicates paired files
    inputBinding:
      position: 1
      prefix: --separators
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
  - id: relpaths
    type:
      - 'null'
      - boolean
    doc: Convert inputs into relative paths to the work directory
    inputBinding:
      position: 1
      prefix: --relpaths
outputs:
  - id: project_dir
    type: Directory
    doc: Project directory with config/ and work/
    outputBinding:
      glob: $(inputs.metadata.nameroot)
  - id: sample_config
    type: File
    doc: Generated bcbio sample YAML configuration
    outputBinding:
      glob: $(inputs.metadata.nameroot)/config/$(inputs.metadata.nameroot).yaml
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
