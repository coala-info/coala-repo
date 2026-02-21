cwlVersion: v1.2
class: CommandLineTool
baseCommand: poolsnp
label: poolsnp
doc: "A heuristic SNP caller for pooled sequencing data (Note: The provided text is
  a container runtime error log and does not contain CLI help information; no arguments
  could be extracted).\n\nTool homepage: https://github.com/capoony/PoolSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poolsnp:1.0.1--py312h7e72e81_0
stdout: poolsnp.out
