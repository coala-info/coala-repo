cwlVersion: v1.2
class: CommandLineTool
baseCommand: BlibBuild
label: bibliospec
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation for the tool. BiblioSpec is a suite of software
  for creating and searching tandem mass spectrometry software libraries.\n\nTool
  homepage: https://skyline.ms/project/home/software/BiblioSpec/begin.view?"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bibliospec:1.0--0
stdout: bibliospec.out
