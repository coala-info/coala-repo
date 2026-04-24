cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd install
label: ggd_install
doc: "Install a ggd data package into the current or specified conda environment\n\
  \nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: name
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The data package name to install. Can use more than once (e.g. ggd install
      <pkg 1> <pkg 2> <pkg 3> ). (NOTE: No need to designate version as it is implicated
      in the package name)'
    inputBinding:
      position: 1
  - id: channel
    type:
      - 'null'
      - string
    doc: The ggd channel the desired recipe is stored in. (Default = genomics)
    inputBinding:
      position: 102
      prefix: --channel
  - id: debug
    type:
      - 'null'
      - boolean
    doc: (Optional) When the -d flag is set debug output will be printed to 
      stdout.
    inputBinding:
      position: 102
      prefix: --debug
  - id: file
    type:
      - 'null'
      - type: array
        items: File
    doc: A file with a list of ggd data packages to install. One package per 
      line. Can use more than one (e.g. ggd install --file <file_1> --file 
      <file_2> )
    inputBinding:
      position: 102
      prefix: --file
  - id: meta_recipe_id
    type:
      - 'null'
      - string
    doc: 'The ID to use for the meta recipe being installed. For example, if installing
      the GEO meta-recipe for GEO Accession ID GSE123, use `--id GSE123` NOTE: GGD
      will NOT try to correct the ID. The ID must be accurately entered with case
      sensitive alphanumeric order'
    inputBinding:
      position: 102
      prefix: --id
  - id: prefix
    type:
      - 'null'
      - string
    doc: (Optional) The name or the full directory path to an existing conda 
      environment where you want to install a ggd data package. (Only needed if 
      you want to install the data package into a different conda environment 
      then the one you are currently in)
    inputBinding:
      position: 102
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_install.out
