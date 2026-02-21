cwlVersion: v1.2
class: CommandLineTool
baseCommand: picard
label: picard
doc: "A set of command line tools (Java) for manipulating high-throughput sequencing
  (HTS) data and formats such as SAM/BAM/CRAM and VCF.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: program_name
    type: string
    doc: The name of the Picard tool to execute (e.g., MarkDuplicates, SortSam, 
      CollectHsMetrics).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
stdout: picard.out
