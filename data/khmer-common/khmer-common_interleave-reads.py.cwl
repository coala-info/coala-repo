cwlVersion: v1.2
class: CommandLineTool
baseCommand: interleave-reads.py
label: khmer-common_interleave-reads.py
doc: "Interleave two files of reads (e.g., left and right paired-end reads).\n\nTool
  homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common_interleave-reads.py.out
