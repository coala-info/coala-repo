cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CATS_rb_map
label: cats-rb_CATS_rb_map
doc: "The provided text does not contain help information for the tool, but indicates
  a system error during container image extraction (no space left on device).\n\n
  Tool homepage: https://github.com/bodulic/CATS-rb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rb:1.0.3--hdfd78af_0
stdout: cats-rb_CATS_rb_map.out
