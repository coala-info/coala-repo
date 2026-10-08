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
  - id: ref_files
    type: File[]
    doc: 'Reference files: <ref_filepref>.pcs and <ref_filepref>.popu'
  - id: stu_files
    type: File[]
    doc: 'Study files: <stu_filepref>.pcs and <stu_filepref>.popu'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: plot_png
    type: File
    doc: PC plot of reference and study samples (<stu_filepref>.png)
    outputBinding:
      glob: $(inputs.stu_filepref).png
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa_plot.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.ref_files.concat(inputs.stu_files ? inputs.stu_files : []))'
