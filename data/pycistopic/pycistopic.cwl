cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycistopic
label: pycistopic
doc: "The provided text is a log of a failed container build process (Singularity/Apptainer)
  and does not contain CLI help information or argument definitions for the tool 'pycistopic'.\n
  \nTool homepage: https://github.com/aertslab/pycistopic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
stdout: pycistopic.out
