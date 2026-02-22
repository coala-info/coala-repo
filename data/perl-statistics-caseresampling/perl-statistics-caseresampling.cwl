cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-caseresampling
label: perl-statistics-caseresampling
doc: "Statistics::CaseResampling - Resampling and jackknifing statistics. (Note: The
  provided text contains system error messages regarding container image retrieval
  and does not include the tool's help documentation or usage instructions.)\n\nTool
  homepage: http://metacpan.org/pod/Statistics::CaseResampling"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-statistics-caseresampling:0.15--pl5321h7b50bb2_5
stdout: perl-statistics-caseresampling.out
