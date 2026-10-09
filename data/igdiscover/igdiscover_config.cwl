cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - config
label: igdiscover_config
doc: "Change a configuration file (igdiscover.yaml) by setting keys; without set values the current configuration is printed to standard output.\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: config_file
    type: File
    doc: "Configuration file to modify (staged writable; the modified copy is returned)"
    inputBinding:
      position: 1
      prefix: --file
      valueFrom: $(self.basename)
  - id: set_values
    type:
      - 'null'
      - type: array
        items: config_set_pair
        inputBinding:
          prefix: --set
    doc: "Set KEY to VALUE. Use KEY.SUBKEY[.SUBSUBKEY...] for nested keys."
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: "Current configuration (printed when no set values are given)"
  - id: modified_config
    type: File
    doc: "The configuration file after the changes"
    outputBinding:
      glob: $(inputs.config_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: config_set_pair
        type: record
        fields:
          - name: key
            type: string
            inputBinding:
              position: 1
          - name: value
            type: string
            inputBinding:
              position: 2
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.config_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_config.out
