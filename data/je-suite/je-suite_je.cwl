cwlVersion: v1.2
class: CommandLineTool
baseCommand: je
label: je-suite_je
doc: "JE-Suite is a collection of tools for processing sequencing data, particularly
  for single-cell RNA sequencing.\n\nTool homepage: https://gbcs.embl.de/Je"
inputs:
  - id: command
    type: string
    doc: 'The command to execute. Available commands: clip, debarcode, demultiplex,
      demultiplex-illu, markdupes, dropseq, retag.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/je-suite:2.0.RC--0
stdout: je-suite_je.out
