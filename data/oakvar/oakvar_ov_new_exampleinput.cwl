cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ov
  - new
  - exampleinput
label: oakvar_ov_new_exampleinput
doc: "Makes a file with example input variants.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: directory
    type:
      - 'null'
      - string
    doc: Directory to make the example input file in.
    inputBinding:
      position: 101
      prefix: -d
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run quietly.
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: example_input
    type:
      - 'null'
      - File
    doc: Example input variant file in VCF format.
    outputBinding:
      glob: |
        ${ return inputs.directory ? inputs.directory + '/oakvar_example.vcf' : 'oakvar_example.vcf'; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov_new_exampleinput.out
