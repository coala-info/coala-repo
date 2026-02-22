cwlVersion: v1.2
class: CommandLineTool
baseCommand: assemblycomparator2
label: assemblycomparator2
doc: "A tool for comparing genome assemblies. (Note: The provided text appears to
  be a container build error log rather than help text, so no arguments could be extracted.)\n\
  \nTool homepage: https://github.com/cmkobel/assemblycomparator2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblycomparator2:2.7.1--hdfd78af_2
stdout: assemblycomparator2.out
