cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabin
label: metabinkit_metabin
doc: "Metabin tool from the metabinkit suite (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/envmetagen/metabinkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
stdout: metabinkit_metabin.out
