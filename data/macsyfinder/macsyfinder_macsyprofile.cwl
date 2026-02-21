cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macsyfinder
  - macsyprofile
label: macsyfinder_macsyprofile
doc: "A tool within the MacSyFinder suite. (Note: The provided help text contains
  only system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
stdout: macsyfinder_macsyprofile.out
