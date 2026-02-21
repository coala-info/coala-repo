cwlVersion: v1.2
class: CommandLineTool
baseCommand: PoolSNP.sh
label: poolsnp_PoolSNP.sh
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the PoolSNP image.\n\nTool homepage: https://github.com/capoony/PoolSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poolsnp:1.0.1--py312h7e72e81_0
stdout: poolsnp_PoolSNP.sh.out
