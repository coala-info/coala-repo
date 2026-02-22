cwlVersion: v1.2
class: CommandLineTool
baseCommand: coot-headless
label: coot-headless
doc: "The provided text appears to be a system error log from a container build process
  (Singularity/Apptainer) rather than the help text for the 'coot-headless' tool.
  Consequently, no command-line arguments, flags, or tool-specific descriptions could
  be extracted.\n\nTool homepage: https://www2.mrc-lmb.cam.ac.uk/personal/pemsley/coot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coot-headless:1.1.20--py311he85460a_1
stdout: coot-headless.out
