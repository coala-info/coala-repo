cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - stats
label: slow5tools_stats
doc: "Prints statistics of a SLOW5/BLOW5 file to the stdout. If no argument is given
  details about slow5tools is printed.\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: slow5_file
    type:
      - 'null'
      - File
    doc: SLOW5/BLOW5 file to print statistics from
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
stdout: slow5tools_stats.out
