cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-scalar-util-numeric
label: perl-scalar-util-numeric
doc: "The provided text is an error log indicating a failure to pull or build a Singularity/Docker
  container and does not contain help documentation or usage instructions for the
  tool.\n\nTool homepage: https://github.com/perlancar/perl-Bencher-Scenario-ScalarUtilNumeric"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-scalar-util-numeric:0.40--pl5321h7b50bb2_7
stdout: perl-scalar-util-numeric.out
