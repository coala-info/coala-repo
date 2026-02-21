cwlVersion: v1.2
class: CommandLineTool
baseCommand: kid_redis-cli
label: kid_redis-cli
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image conversion (no space left on device).\n\nTool homepage: https://github.com/zhihu/kids"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kid:0.9.6--py27_1
stdout: kid_redis-cli.out
