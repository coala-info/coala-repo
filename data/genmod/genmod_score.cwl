cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genmod
  - score
label: genmod_score
doc: "Score variants in a vcf file using a Weighted Sum Model.\n\nTool homepage: http://github.com/moonso/genmod"
inputs:
  - id: vcf_file
    type: File
    doc: vcf file
    inputBinding:
      position: 1
  - id: family_file
    type: File
    doc: ped_file
    inputBinding:
      position: 102
      prefix: --family_file
  - id: family_id
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --family_id
  - id: family_type
    type:
      - 'null'
      - string
    doc: If the analysis use one of the known setups, please specify which one.
    inputBinding:
      position: 102
      prefix: --family_type
  - id: rank_results
    type:
      - 'null'
      - boolean
    doc: Add a info field that shows how the different categories contribute to 
      the rank score.
    inputBinding:
      position: 102
      prefix: --rank_results
  - id: score_config
    type:
      - 'null'
      - File
    doc: The plug-in config file(.ini)
    inputBinding:
      position: 102
      prefix: --score_config
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print the variants.
    inputBinding:
      position: 102
      prefix: --silent
  - id: skip_plugin_check
    type:
      - 'null'
      - boolean
    doc: If continue even if plugins does not exist in vcf.
    inputBinding:
      position: 102
      prefix: --skip_plugin_check
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify the path to a file where results should be stored.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
