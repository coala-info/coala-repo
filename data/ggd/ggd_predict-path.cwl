cwlVersion: v1.2
class: CommandLineTool
baseCommand: ggd predict-path
label: ggd_predict-path
doc: "Get a predicted install file path for a data package before it is installed.
  (Use for workflows, such as Snakemake)\n\nTool homepage: https://github.com/gogetdata/ggd-cli"
inputs:
  - id: channel
    type:
      - 'null'
      - string
    doc: The ggd channel of the recipe to find.
    inputBinding:
      position: 101
      prefix: --channel
  - id: dir_path
    type: boolean
    doc: Whether or not to get the predicted directory path rather then the 
      predicted file path. If both --file-name and --dir- path are provided the 
      --file-name will be used and --dir-path will be ignored
    inputBinding:
      position: 101
      prefix: --dir-path
  - id: file_name
    type: string
    doc: The name of the file to predict that path for. It is best if you give 
      the full and correct name of the file to predict the path for. If not, ggd
      will try to identify the right file, but won't guarantee that it is the 
      right file
    inputBinding:
      position: 101
      prefix: --file-name
  - id: id
    type:
      - 'null'
      - string
    doc: The ID to predict the path for if the package is a meta-recipe. If it 
      is not a meta-recipe it will be ignored
    inputBinding:
      position: 101
      prefix: --id
  - id: package_name
    type: string
    doc: The name of the data package to predict a file path for
    inputBinding:
      position: 101
      prefix: --package-name
  - id: prefix
    type:
      - 'null'
      - string
    doc: The name or the full directory path to an conda environment. The 
      predicted path will be based on this conda environment. When installing, 
      the data package should also be installed in this environment. (Only 
      needed if not predicting for a path in the current conda environment)
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggd:1.1.3--pyh3252c3a_0
stdout: ggd_predict-path.out
