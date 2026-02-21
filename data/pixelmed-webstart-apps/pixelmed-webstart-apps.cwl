cwlVersion: v1.2
class: CommandLineTool
baseCommand: pixelmed-webstart-apps
label: pixelmed-webstart-apps
doc: "PixelMed DICOM toolkit webstart applications. (Note: The provided text is a
  system error log regarding a container build failure and does not contain CLI help
  information or argument definitions.)\n\nTool homepage: https://github.com/alexdobin/STAR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pixelmed-webstart-apps:v20150917-1-deb_cv1
stdout: pixelmed-webstart-apps.out
