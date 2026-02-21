cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebaseextract
label: emboss-lib_rebaseextract
doc: "Process REBASE data files for use by restriction enzyme analysis programs\n\n
  Tool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/emboss-lib:v6.6.0dfsg-6-deb_cv1
stdout: emboss-lib_rebaseextract.out
