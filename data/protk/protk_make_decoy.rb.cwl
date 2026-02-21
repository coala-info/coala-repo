cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_make_decoy.rb
label: protk_make_decoy.rb
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text for the tool. Based on the tool name hint 'protk_make_decoy.rb',
  this tool is typically used to generate decoy sequences for proteomics database
  searches.\n\nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_make_decoy.rb.out
