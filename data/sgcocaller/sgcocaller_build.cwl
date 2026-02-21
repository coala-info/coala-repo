cwlVersion: v1.2
class: CommandLineTool
baseCommand: sgcocaller_build
label: sgcocaller_build
doc: "The provided text appears to be a log of a container build process (Apptainer/Singularity)
  rather than help text for the sgcocaller_build tool. As a result, no command-line
  arguments or descriptions could be extracted.\n\nTool homepage: https://gitlab.svi.edu.au/biocellgen-public/sgcocaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sgcocaller:0.3.9--hda81887_2
stdout: sgcocaller_build.out
