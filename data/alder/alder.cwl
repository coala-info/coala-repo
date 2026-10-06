cwlVersion: v1.2
class: CommandLineTool
baseCommand: alder
label: alder
doc: "ALDER computes weighted LD decay curves, performs curve-fitting to infer admixture
  dates, and uses the results to test for admixture.\n\nTool homepage: http://cb.csail.mit.edu/cb/alder/"
inputs:
  - id: parameter_file
    type: File
    doc: parameter file
    inputBinding:
      position: 101
      prefix: -p
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files named in the parameter file (genotypename, snpname, indivname,
      poplistname, weightname, badsnpname). They are staged in the working directory,
      so the parameter file must name them by file name only.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.data_files ? inputs.data_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alder:1.03--h13c21de_7
stdout: alder.out
