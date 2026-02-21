cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_md_mdrun
label: biobb_md_mdrun
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the tool's image due to lack of disk space. No help
  text or argument information was found in the input.\n\nTool homepage: https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_md:3.7.2--pyhdfd78af_0
stdout: biobb_md_mdrun.out
