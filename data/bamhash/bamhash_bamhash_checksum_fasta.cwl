cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamhash_checksum_fasta
label: bamhash_bamhash_checksum_fasta
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/DecodeGenetics/BamHash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
stdout: bamhash_bamhash_checksum_fasta.out
