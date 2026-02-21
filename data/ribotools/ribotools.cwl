cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotools
label: ribotools
doc: "A tool for ribosome profiling analysis (Note: The provided text is a container
  build log and does not contain CLI help information or argument definitions).\n\n
  Tool homepage: https://github.com/eboileau/ribotools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotools:2.0.0--pyhdfd78af_0
stdout: ribotools.out
