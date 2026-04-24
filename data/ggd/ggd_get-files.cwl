cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd_get-files
label: ggd_get-files
doc: "Get a list of file(s) for a specific installed ggd package\n\nTool homepage:
  https://github.com/gogetdata/ggd-cli"
inputs:
  - id: name
    type: string
    doc: recipe name
    inputBinding:
      position: 1
  - id: channel
    type:
      - 'null'
      - string
    doc: The ggd channel of the recipe to find.
    inputBinding:
      position: 102
      prefix: --channel
  - id: genome_build
    type:
      - 'null'
      - string
    doc: (Optional) genome build the recipe is for. Use '*' for any genome 
      build.
    inputBinding:
      position: 102
      prefix: --genome-build
  - id: pattern
    type:
      - 'null'
      - string
    doc: (Optional) pattern to match the name of the file desired. To list all 
      files for a ggd package, do not use the -p option
    inputBinding:
      position: 102
      prefix: --pattern
  - id: prefix
    type:
      - 'null'
      - string
    doc: (Optional) The name or the full directory path to an conda environment 
      where a ggd recipe is stored. (Only needed if not getting file paths for 
      files in the current conda environment)
    inputBinding:
      position: 102
      prefix: --prefix
  - id: species
    type:
      - 'null'
      - string
    doc: (Optional) species recipe is for. Use '*' for any species
    inputBinding:
      position: 102
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_get-files.out
