cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sphae
  - config
label: sphae_config
doc: "Copy the system default config file\n\nTool homepage: https://github.com/linsalrob/sphae/"
inputs:
  - id: configfile
    type:
      - 'null'
      - string
    doc: Copy template config to file
    inputBinding:
      position: 101
      prefix: --configfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sphae:1.5.3--pyhdfd78af_0
stdout: sphae_config.out
