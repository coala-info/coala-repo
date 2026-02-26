cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifihla
label: hifihla
doc: "Call HLA loci from an aligned BAM of HiFi reads\n\nTool homepage: https://github.com/PacificBiosciences/hifihla"
inputs:
  - id: command
    type: string
    doc: Command to run (call-reads, call-contigs, call-consensus, align-imgt, 
      help)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
stdout: hifihla.out
