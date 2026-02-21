cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-interface-executor-plugins
label: snakemake-interface-executor-plugins
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log output from a container runtime (Singularity/Apptainer) reporting
  a fatal error during an image build process.\n\nTool homepage: https://github.com/snakemake/snakemake-interface-executor-plugins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-interface-executor-plugins:9.3.9--pyhdfd78af_0
stdout: snakemake-interface-executor-plugins.out
