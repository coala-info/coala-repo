cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - uropa_summary.R
label: uropa_uropa_summary.R
doc: "Create a summary pdf with graphs from the result tables of a UROPA run.\n\nTool homepage: https://github.com/loosolab/UROPA"
inputs:
  - id: finalhits
    type: File
    doc: file containing the final hits from UROPA.
    inputBinding:
      position: 101
      prefix: --finalhits
  - id: config
    type: File
    doc: file containing the json formatted configuration from the UROPA run.
    inputBinding:
      position: 101
      prefix: --config
  - id: output
    type:
      - 'null'
      - string
    doc: file name of output file [summary.pdf].
    inputBinding:
      position: 101
      prefix: --output
  - id: allhits
    type:
      - 'null'
      - File
    doc: file containing all hits from UROPA.
    inputBinding:
      position: 101
      prefix: --allhits
  - id: call
    type:
      - 'null'
      - string
    doc: original command line call.
    inputBinding:
      position: 101
      prefix: --call
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: summary_pdf
    type: File
    doc: summary pdf
    outputBinding:
      glob: |
        ${ return inputs.output ? inputs.output : 'summary.pdf'; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uropa:4.0.3--pyhdfd78af_0
stdout: uropa_uropa_summary.R.out
