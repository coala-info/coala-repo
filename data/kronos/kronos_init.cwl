cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kronos
  - init
label: kronos_init
doc: "initialize a pipeline from a given config file\n\nTool homepage: https://github.com/jtaghiyar/kronos"
inputs:
  - id: config_file
    type: File
    doc: path to the config_file.yaml
    inputBinding:
      position: 101
      prefix: --config_file
  - id: input_samples
    type:
      - 'null'
      - File
    doc: path to the samples file
    inputBinding:
      position: 101
      prefix: --input_samples
  - id: pipeline_name
    type: string
    doc: a name for the resultant pipeline
    inputBinding:
      position: 101
      prefix: --pipeline_name
  - id: setup_file
    type:
      - 'null'
      - File
    doc: path to the setup file
    inputBinding:
      position: 101
      prefix: --setup_file
  - id: component_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Component directories staged into the working directory so the components can be imported
outputs:
  - id: pipeline_script
    type:
      - 'null'
      - File
    doc: The generated pipeline script
    outputBinding:
      glob: $(inputs.pipeline_name).py
  - id: updated_config
    type:
      - 'null'
      - File
    doc: The updated config file
    outputBinding:
      glob: "*_kronos.yaml"
  - id: intermediate_pipeline_scripts
    type:
      - 'null'
      - Directory
    doc: Per-sample pipeline scripts
    outputBinding:
      glob: intermediate_pipeline_scripts
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.component_dirs ? inputs.component_dirs : [])"
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: kronos
      - envName: PYTHONPATH
        envValue: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0
stdout: kronos_init.out
