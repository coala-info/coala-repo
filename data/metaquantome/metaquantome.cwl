cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquantome
label: metaquantome
doc: "metaQuantome is a tool that performs quantitative analysis on the function and
  taxonomy of microbomes and their interactions. For more background information,
  please read the associated manuscript: https://doi.org/10.1074/mcp.ra118.001240.
  For a more hands-on tutorial, please visit the following page: https://galaxyproteomics.github.io/metaquantome_mcp_analysis/cli_tutorial/cli_tutorial.html.\n\
  \nThe metaQuantome workflow is as follows: db → expand → filter → stat → viz.\n\n\
  Run `metaquantome {db,expand,filter,stat,viz} -h` for more information on the individual
  modules. Any issues can be brought to attention here: https://github.com/galaxyproteomics/metaquantome/issues.\n\
  \nTool homepage: https://github.com/galaxyproteomics/metaquant"
inputs:
  - id: command
    type: string
    doc: 'Available commands: db, expand, filter, stat, viz'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
stdout: metaquantome.out
