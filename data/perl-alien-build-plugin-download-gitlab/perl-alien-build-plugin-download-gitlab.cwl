cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-alien-build-plugin-download-gitlab
label: perl-alien-build-plugin-download-gitlab
doc: "A plugin for Alien::Build that enables downloading source code or assets from
  GitLab repositories.\n\nTool homepage: https://metacpan.org/pod/Alien::Build::Plugin::Download::GitLab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-alien-build-plugin-download-gitlab:0.01--pl5321hdfd78af_0
stdout: perl-alien-build-plugin-download-gitlab.out
