cwlVersion: v1.2
class: CommandLineTool
baseCommand: hs-blastn
label: hs-blastn
doc: "Homology Search BLASTN (Note: The provided text is a system error message indicating
  a failure to pull the container image due to lack of disk space and does not contain
  help documentation or argument details).\n\nTool homepage: https://github.com/chenying2016/queries"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hs-blastn:0.0.5--h9948957_6
stdout: hs-blastn.out
