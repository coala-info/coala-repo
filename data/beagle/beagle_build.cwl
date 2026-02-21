cwlVersion: v1.2
class: CommandLineTool
baseCommand: beagle_build
label: beagle_build
doc: "The provided text is a log of a failed container build process (Apptainer/Singularity)
  for the Beagle tool and does not contain CLI help documentation or argument definitions.\n
  \nTool homepage: https://github.com/yampelo/beagle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beagle:5.5_27Feb25.75f--hdfd78af_0
stdout: beagle_build.out
