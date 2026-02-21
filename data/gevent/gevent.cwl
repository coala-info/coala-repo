cwlVersion: v1.2
class: CommandLineTool
baseCommand: gevent
label: gevent
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to insufficient disk space.\n\nTool
  homepage: https://github.com/gevent/gevent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gevent:1.1rc4--py36_0
stdout: gevent.out
