cwlVersion: v1.2
class: CommandLineTool
baseCommand: suma_package
label: suma_package
doc: "The provided text is a container build log and does not contain help information
  or argument definitions for the tool.\n\nTool homepage: https://github.com/suman-komarla-adinarayana-groups/SumanKAGreatLearningInfo-EducationStudyAssignment10-TourismPackagePrediction"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suma_package:1.0.00--h577a1d6_8
stdout: suma_package.out
