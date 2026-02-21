cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_recon
label: mob_suite_mob_recon
doc: "The provided text does not contain help information or argument definitions;
  it contains system log messages and a fatal error regarding disk space during a
  container build.\n\nTool homepage: https://github.com/phac-nml/mob-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle-tutorials:v1.5.0-4-deb_cv1
stdout: mob_suite_mob_recon.out
