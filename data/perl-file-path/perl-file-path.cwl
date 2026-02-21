cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-path
label: perl-file-path
doc: "The provided text does not contain help information for the tool. It consists
  of system logs from an Apptainer/Singularity build process ending in a fatal error
  indicating that the executable 'perl-file-path' was not found in the PATH.\n\nTool
  homepage: http://metacpan.org/pod/File::Path"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-path:2.16--pl526_0
stdout: perl-file-path.out
