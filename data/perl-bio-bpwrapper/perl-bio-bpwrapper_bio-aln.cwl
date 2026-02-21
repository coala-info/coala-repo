cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-aln
label: perl-bio-bpwrapper_bio-aln
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a Singularity/Apptainer image
  due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Bio::BPWrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bpwrapper:1.15--pl5321hdfd78af_0
stdout: perl-bio-bpwrapper_bio-aln.out
