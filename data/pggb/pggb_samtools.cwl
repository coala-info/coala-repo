cwlVersion: v1.2
class: CommandLineTool
baseCommand: pggb_samtools
label: pggb_samtools
doc: "The provided text is an error log from a container build process (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb_samtools.out
