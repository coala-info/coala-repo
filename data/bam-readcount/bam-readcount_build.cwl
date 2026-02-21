cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-readcount
label: bam-readcount_build
doc: "The provided text does not contain help documentation for the tool, but rather
  an error log from a container build process (Singularity/Apptainer) that failed
  due to insufficient disk space. No arguments or tool descriptions could be extracted
  from this specific text.\n\nTool homepage: https://github.com/genome/bam-readcount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam-readcount:1.0.1--h9aeec6d_3
stdout: bam-readcount_build.out
