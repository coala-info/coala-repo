cwlVersion: v1.2
class: CommandLineTool
baseCommand: murasaki
label: murasaki
doc: "Murasaki is a multiple genome alignment tool. (Note: The provided help text
  contains only system error messages and no usage information; arguments could not
  be extracted from the source text).\n\nTool homepage: https://github.com/prinsss/hexo-theme-murasaki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/murasaki:v1.68.6-6b4-deb_cv1
stdout: murasaki.out
