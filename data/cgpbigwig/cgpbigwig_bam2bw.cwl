cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgpbigwig_bam2bw
label: cgpbigwig_bam2bw
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/cancerit/cgpBigWig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0
stdout: cgpbigwig_bam2bw.out
