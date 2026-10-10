cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mirdeep2bed.pl
label: mirdeep2_mirdeep2bed.pl
doc: "Convert the result.csv file of miRDeep2 into a BED file of the novel and known miRNAs\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: csv_file
    type: File
    doc: miRDeep2 result csv file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: BED file with one line per novel or known miRNA
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: mirdeep2bed.bed
