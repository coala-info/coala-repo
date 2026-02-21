cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_init
label: mob_suite_mob_init
doc: "Initialize or update the MOB-suite databases. (Note: The provided text contains
  system error messages regarding container execution and disk space rather than the
  tool's help documentation.)\n\nTool homepage: https://github.com/phac-nml/mob-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle-tutorials:v1.5.0-4-deb_cv1
stdout: mob_suite_mob_init.out
