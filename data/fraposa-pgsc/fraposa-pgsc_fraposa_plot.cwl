cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraposa_plot
label: fraposa-pgsc_fraposa_plot
doc: "Plots the results of FRA-POSA.\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs:
  - id: ref_filepref
    type: string
    doc: Prefix of binary PLINK file for the reference data.
    inputBinding:
      position: 1
  - id: stu_filepref
    type: string
    doc: Prefix of binary PLINK file for the study data.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa_plot.out
