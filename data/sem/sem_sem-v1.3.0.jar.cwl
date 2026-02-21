cwlVersion: v1.2
class: CommandLineTool
baseCommand: sem
label: sem_sem-v1.3.0.jar
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for the tool sem_sem-v1.3.0.jar.\n
  \nTool homepage: https://github.com/YenLab/SEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sem:1.2.3--hdfd78af_0
stdout: sem_sem-v1.3.0.jar.out
