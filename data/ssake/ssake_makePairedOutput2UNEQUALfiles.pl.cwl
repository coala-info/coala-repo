cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssake_makePairedOutput2UNEQUALfiles.pl
label: ssake_makePairedOutput2UNEQUALfiles.pl
doc: "A script within the SSAKE suite, likely used to process or format paired-end
  reads from files of unequal size/length.\n\nTool homepage: https://github.com/warrenlr/SSAKE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssake:v4.0-2-deb_cv1
stdout: ssake_makePairedOutput2UNEQUALfiles.pl.out
