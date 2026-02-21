cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysnptools
label: pysnptools
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for pysnptools.\n
  \nTool homepage: http://research.microsoft.com/en-us/um/redmond/projects/mscompbio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysnptools:0.3.13--py27_0
stdout: pysnptools.out
