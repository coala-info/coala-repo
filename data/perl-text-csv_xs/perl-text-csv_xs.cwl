cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-text-csv_xs
doc: "The provided text is an error message indicating a failure to pull the container
  image and does not contain help documentation for the tool. Text::CSV_XS is typically
  a Perl module used for fast CSV processing.\n\nTool homepage: https://metacpan.org/pod/Text::CSV_XS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl:5.32
stdout: perl-text-csv_xs.out
