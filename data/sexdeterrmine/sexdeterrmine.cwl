cwlVersion: v1.2
class: CommandLineTool
baseCommand: sexdeterrmine
label: sexdeterrmine
doc: "Calculate the relative X- and Y-chromosome coverage of data, as well as the
  associated error bars for each.\n\nTool homepage: https://github.com/TCLamnidis/Sex.DetERRmine"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input samtools depth file. Omit to read from stdin.
    inputBinding:
      position: 101
      prefix: --Input
  - id: sample_list
    type:
      - 'null'
      - string
    doc: A list of samples/bams that were in the depth file. One per line. 
      Should be in the order of the samtools depth output.
    inputBinding:
      position: 101
      prefix: --SampleList
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sexdeterrmine:1.1.2--hdfd78af_1
stdout: sexdeterrmine.out
