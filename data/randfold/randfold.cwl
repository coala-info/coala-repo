cwlVersion: v1.2
class: CommandLineTool
baseCommand: randfold
label: randfold
doc: "Performs randomizations on a sequence file to assess statistical significance
  of predicted RNA structures.\n\nTool homepage: https://github.com/erbon7/randfold"
inputs:
  - id: method
    type: string
    doc: 'The randomization method flag: -s (simple mononucleotide shuffling), -d
      (dinucleotide shuffling) or -m (markov chain 1 shuffling).'
    inputBinding:
      position: 1
  - id: file_name
    type: File
    doc: The input sequence file.
    inputBinding:
      position: 2
  - id: number_of_randomizations
    type: int
    doc: The number of randomizations to perform.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/randfold:2.0.1--h7b50bb2_9
stdout: randfold.out
