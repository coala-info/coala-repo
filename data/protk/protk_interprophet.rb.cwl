cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_interprophet.rb
label: protk_interprophet.rb
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Singularity/Apptainer)
  failure.\n\nTool homepage: https://github.com/iracooke/protk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
stdout: protk_interprophet.rb.out
