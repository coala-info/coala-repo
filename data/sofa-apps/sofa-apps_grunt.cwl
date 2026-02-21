cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-apps_grunt
label: sofa-apps_grunt
doc: "The provided text does not contain help information for sofa-apps_grunt; it
  contains system logs and a fatal error message regarding a container build failure.\n
  \nTool homepage: https://github.com/sofa/app"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-apps:v1.0beta4-11b3-deb_cv1
stdout: sofa-apps_grunt.out
