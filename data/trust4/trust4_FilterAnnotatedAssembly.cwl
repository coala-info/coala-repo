cwlVersion: v1.2
class: CommandLineTool
baseCommand: FilterAnnotatedAssembly.pl
label: trust4_FilterAnnotatedAssembly
doc: "Filter the annotated assemblies (annot.fa written by the TRUST4 annotator): drops contigs with a missing CDR3 or inconsistent V/J/C coordinates. The filtered file goes to standard output.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: annot_file
    type: File
    doc: "annotated assembly file (annot.out / annot.fa)"
    inputBinding:
      position: 1
outputs:
  - id: filtered
    type: stdout
    doc: "Filtered annotated assemblies (standard output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: filter_annot.out
