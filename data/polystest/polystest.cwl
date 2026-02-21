cwlVersion: v1.2
class: CommandLineTool
baseCommand: polystest
label: polystest
doc: "The provided text does not contain help information or usage instructions for
  the tool 'polystest'. It contains system logs and a fatal error message regarding
  a container build process.\n\nTool homepage: https://bitbucket.org/veitveit/polystest/src/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polystest:1.3.4--hdfd78af_0
stdout: polystest.out
