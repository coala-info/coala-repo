cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cojac
  - phe2cojac
label: cojac_phe2cojac
doc: "convert phe-genomics to cojac's dedicated variant YAML format\n\nTool homepage:
  https://github.com/cbg-ethz/cojac"
inputs:
  - id: in_yaml
    type: File
    doc: Input YAML file
    inputBinding:
      position: 1
  - id: shortname
    type:
      - 'null'
      - string
    doc: shortname to use (otherwise auto-build one based on phe-genomic's 
      unique id)
    inputBinding:
      position: 102
      prefix: --shortname
outputs:
  - id: out_yaml
    type:
      - 'null'
      - File
    doc: write cojac variant to a YAML file instead of printing (if empty, build
      filename from shortname)
    outputBinding:
      glob: $(inputs.out_yaml)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cojac:0.9.3--pyh7e72e81_0
