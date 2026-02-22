cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-set-intervaltree
label: perl-set-intervaltree
doc: "The provided text does not contain help documentation for the tool. It consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull or build an image due to insufficient disk space.\n\nTool homepage:
  https://metacpan.org/pod/Set::IntervalTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-set-intervaltree:0.12--pl5321h503566f_6
stdout: perl-set-intervaltree.out
