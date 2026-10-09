cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - template
  - groupings
label: harpy_template_groupings
doc: "Create a template sample-grouping file from the sample names in a directory of FASTQ or BAM files. All samples are assigned to pop1; the template is written to standard output.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: inputdir
    type: Directory
    doc: Directory with the input FASTQ or BAM files; the sample names are taken from the file names
    inputBinding:
      position: 1
outputs:
  - id: template_file
    type: File
    doc: The template written to standard output
    outputBinding:
      glob: groupings.tsv
stdout: groupings.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
