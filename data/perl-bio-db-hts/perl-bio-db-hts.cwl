cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-db-hts
label: perl-bio-db-hts
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the OCI image due to insufficient disk space ('no
  space left on device'). It does not contain help text or usage information for the
  tool.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::HTS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-db-hts:3.01--pl5321h577a1d6_12
stdout: perl-bio-db-hts.out
