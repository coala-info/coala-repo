cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-postscript
label: perl-postscript
doc: "The provided text does not contain help information for 'perl-postscript'. It
  consists of Apptainer/Singularity container runtime logs indicating that the executable
  was not found in the environment.\n\nTool homepage: https://github.com/manwar/perlweeklychallenge-club"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-postscript:0.06--0
stdout: perl-postscript.out
