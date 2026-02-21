cwlVersion: v1.2
class: CommandLineTool
baseCommand: abruijn
label: abruijn_flye
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the image due to insufficient disk space.
  It does not contain the help text or usage information for the tool 'abruijn'.\n
  \nTool homepage: https://github.com/fenderglass/ABruijn/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abruijn:2.1b--py27_0
stdout: abruijn_flye.out
