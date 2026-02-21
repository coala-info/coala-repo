cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngseqbasic
label: ngseqbasic
doc: "A tool for basic Next-Generation Sequencing (NGS) data processing. Note: The
  provided text contained system error messages regarding container image conversion
  and disk space, rather than functional help text; therefore, no specific arguments
  could be extracted.\n\nTool homepage: http://userweb.molbiol.ox.ac.uk/public/telenius/NGseqBasicManual/external/instructionsBioconda.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngseqbasic:20.0--hdfd78af_0
stdout: ngseqbasic.out
