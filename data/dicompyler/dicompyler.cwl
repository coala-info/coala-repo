cwlVersion: v1.2
class: CommandLineTool
baseCommand: dicompyler
label: dicompyler
doc: "dicompyler is an extensible open source radiation oncology storage and analysis
  tool. (Note: The provided text appears to be a container execution error log rather
  than help text; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/bastula/dicompyler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dicompyler:v0.4.2-3-deb_cv1
stdout: dicompyler.out
