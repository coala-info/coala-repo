cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar sem_sem.jar
label: sem_sem.jar
doc: "The provided text is an error log from a container build process and does not
  contain CLI help information or argument definitions. Based on the container source,
  this tool is likely SEM (Sequence Enrichment Model).\n\nTool homepage: https://github.com/YenLab/SEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sem:1.2.3--hdfd78af_0
stdout: sem_sem.jar.out
