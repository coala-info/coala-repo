cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mac-propertylist
label: perl-mac-propertylist
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a 'no space left on device' failure during a
  container image pull/build process.\n\nTool homepage: https://github.com/briandfoy/mac-propertylist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-mac-propertylist:1.504--pl5321hdfd78af_0
stdout: perl-mac-propertylist.out
