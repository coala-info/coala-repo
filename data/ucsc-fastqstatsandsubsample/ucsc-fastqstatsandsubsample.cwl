cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqStatsAndSubsample
label: ucsc-fastqstatsandsubsample
doc: "A tool for calculating statistics and subsampling FASTQ files. (Note: The provided
  help text contained a container execution error and did not list specific arguments.)\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fastqstatsandsubsample:482--h0b57e2e_0
stdout: ucsc-fastqstatsandsubsample.out
