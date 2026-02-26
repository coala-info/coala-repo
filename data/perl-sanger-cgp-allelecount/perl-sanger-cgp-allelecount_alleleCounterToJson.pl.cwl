cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounterToJson.pl
label: perl-sanger-cgp-allelecount_alleleCounterToJson.pl
doc: "Converts alleleCounter output to JSON format.\n\nTool homepage: https://github.com/cancerit/alleleCount"
inputs:
  - id: allelecount_file
    type: File
    doc: Allelecounter output file
    inputBinding:
      position: 101
      prefix: -allelecount-file
  - id: locus_file
    type: File
    doc: File containing SNP positions used for allelecounter
    inputBinding:
      position: 101
      prefix: -locus-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2
