cwlVersion: v1.2
class: CommandLineTool
baseCommand: treekin
label: perl-bio-rna-treekin
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a lack of disk space during
  a container execution attempt.\n\nTool homepage: https://metacpan.org/pod/Bio::RNA::Treekin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-bio-rna-treekin:0.05--pl5321hdfd78af_0
stdout: perl-bio-rna-treekin.out
