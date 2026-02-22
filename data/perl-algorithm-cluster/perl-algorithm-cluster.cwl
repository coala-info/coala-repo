cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-algorithm-cluster
label: perl-algorithm-cluster
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull an image due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Algorithm::Cluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-algorithm-cluster:1.59--pl5321h7b50bb2_5
stdout: perl-algorithm-cluster.out
