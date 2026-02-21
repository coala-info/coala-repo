cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-www-robotrules
label: perl-www-robotrules
doc: "The perl-www-robotrules package (WWW::RobotRules) provides a database of robots.txt-derived
  permissions. Note: The provided help text indicates a fatal error where the executable
  was not found, so no specific arguments could be extracted.\n\nTool homepage: https://github.com/ngerakines/perl-www-robotrules-cache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-www-robotrules:6.02--0
stdout: perl-www-robotrules.out
