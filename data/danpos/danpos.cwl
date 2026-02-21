cwlVersion: v1.2
class: CommandLineTool
baseCommand: danpos
label: danpos
doc: "The provided text does not contain the help documentation for the tool. It is
  a log of a failed container build process (Singularity/Apptainer) due to 'no space
  left on device'. As a result, no functional arguments or descriptions could be extracted
  from this specific input.\n\nTool homepage: https://sites.google.com/site/danposdoc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
stdout: danpos.out
