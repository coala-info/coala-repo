cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyvcf
label: pyvcf
doc: "The provided text is a system error log from a container build process (Singularity/Apptainer)
  and does not contain CLI help information or argument definitions for the tool 'pyvcf'.\n
  \nTool homepage: https://github.com/jdoughertyii/PyVCF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pyvcf:v0.6.8-1-deb-py2_cv1
stdout: pyvcf.out
