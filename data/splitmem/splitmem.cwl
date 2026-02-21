cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitmem
label: splitmem
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to fetch the splitmem image.\n\nTool homepage: https://github.com/SeimoDev/SplitMeme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splitmem:1.0--h9948957_7
stdout: splitmem.out
