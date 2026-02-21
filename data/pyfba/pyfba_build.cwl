cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba_build
label: pyfba_build
doc: "The provided text appears to be a log output from a failed Singularity/Apptainer
  build process rather than command-line help text. No arguments or descriptions could
  be extracted.\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_build.out
