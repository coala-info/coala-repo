cwlVersion: v1.2
class: CommandLineTool
baseCommand: art-nextgen-simulation-tools-profiles
label: art-nextgen-simulation-tools-profiles
doc: 'Profiles for ART next-generation sequencing simulation tools. Note: The provided
  text appears to be a container build error log rather than CLI help text, so no
  arguments could be extracted.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      biocontainers/art-nextgen-simulation-tools-profiles:v20160605dfsg-3-deb_cv1
stdout: art-nextgen-simulation-tools-profiles.out
