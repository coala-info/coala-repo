cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast select
label: mrpast_select
doc: "Selects the best model based on AIC from multiple solver outputs.\n\nTool homepage:
  https://aprilweilab.github.io/"
inputs:
  - id: solved_results
    type:
      type: array
      items: File
    doc: Two or more JSON file output by the solver.
    inputBinding:
      position: 1
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: Emit the distribution of AIC values for all bootstrapped samples. 
      Requires that you have previously run 'mrpast confidence --bootstrap' to 
      produce a .csv for each of the solved_results.
    inputBinding:
      position: 102
      prefix: --bootstrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_select.out
