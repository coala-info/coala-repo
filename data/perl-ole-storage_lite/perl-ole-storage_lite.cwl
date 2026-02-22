cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ole-storage_lite
label: perl-ole-storage_lite
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a Singularity/Docker container build failure due
  to lack of disk space.\n\nTool homepage: http://metacpan.org/pod/OLE-Storage_Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl:5.32
stdout: perl-ole-storage_lite.out
