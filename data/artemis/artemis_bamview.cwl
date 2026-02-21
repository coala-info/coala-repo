cwlVersion: v1.2
class: CommandLineTool
baseCommand: artemis_bamview
label: artemis_bamview
doc: "A tool for visualizing BAM/CRAM alignment files within the Artemis genome browser
  environment. (Note: The provided input text contains system error logs regarding
  a container build failure and does not include the actual help documentation for
  the tool's arguments.)\n\nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_bamview.out
