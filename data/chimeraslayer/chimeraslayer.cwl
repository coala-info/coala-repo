cwlVersion: v1.2
class: CommandLineTool
baseCommand: chimeraslayer
label: chimeraslayer
doc: 'ChimeraSlayer is a chimeric sequence detection tool (Note: The provided text
  contains container build errors and does not include the actual help documentation
  for the tool).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/chimeraslayer:v20101212dfsg1-2-deb_cv1
stdout: chimeraslayer.out
