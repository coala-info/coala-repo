cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrublet
label: scrublet
doc: "The provided text does not contain help information or usage instructions for
  the tool 'scrublet'. It is a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build the image due to insufficient disk space ('no space
  left on device').\n\nTool homepage: https://github.com/allonkleinlab/scrublet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrublet:0.2.3--pyh5e36f6f_1
stdout: scrublet.out
