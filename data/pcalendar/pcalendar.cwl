cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcalendar
label: pcalendar
doc: "A Java-based calendar application (pcalendar). Note: The provided text indicates
  this is a GUI-based application that requires an X11 display environment to run.\n
  \nTool homepage: https://github.com/omid/pcalendar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pcalendar:v3.4.1-3-deb_cv1
stdout: pcalendar.out
