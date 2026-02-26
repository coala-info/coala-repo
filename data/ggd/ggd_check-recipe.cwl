cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd check-recipe
label: ggd_check-recipe
doc: "Convert a ggd recipe created from `ggd make-recipe` into a data package. Test
  both ggd data recipe and data package\n\nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: recipe_path
    type: File
    doc: path to recipe directory (can also be path to the .bz2)
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set the stdout log level to debug
    inputBinding:
      position: 102
      prefix: --debug
  - id: dont_uninstall
    type:
      - 'null'
      - boolean
    doc: By default the newly installed local ggd data package is uninstalled 
      after the check has finished. To bypass this uninstall step (to keep the 
      local package installed) set this flag "-- --dont_uninstall"
    inputBinding:
      position: 102
      prefix: --dont_uninstall
  - id: meta_recipe_id
    type:
      - 'null'
      - string
    doc: 'If checking a meta-recipe the associated meta-recipe id needs to be supplied.
      (Example: for a geo meta- recipe use something like --id GSE123) NOTE: GGD does
      not try to correct the ID. Please provide the correct case sensitive ID.'
    inputBinding:
      position: 102
      prefix: --id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_check-recipe.out
