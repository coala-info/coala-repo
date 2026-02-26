cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf_ncrf_cat.py
label: ncrf_ncrf_cat.py
doc: "Concatenate several output files from Noise Cancelling Repeat Finder. This is
  little more than copying the files and adding a blank line between the files.\n\n\
  It can also be used to verify that the input files contain end-of-file markers i.e.
  that they were not truncated when created.\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: file1
    type: File
    doc: an output file from Noise Cancelling Repeat Finder
    inputBinding:
      position: 1
  - id: file2
    type:
      - 'null'
      - type: array
        items: File
    doc: another output file from Noise Cancelling Repeat Finder
    inputBinding:
      position: 2
  - id: markend
    type:
      - 'null'
      - boolean
    doc: "assume end-of-file markers are absent in the input, and add an end-of-file
      marker to the output\n             (by default we require inputs to have proper
      end-of-file markers)"
    inputBinding:
      position: 103
      prefix: --markend
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_ncrf_cat.py.out
