cwlVersion: v1.2
class: CommandLineTool
baseCommand: assembly_uploader
label: assembly_uploader
doc: "The provided text appears to be a log of a failed container build process (Singularity/Apptainer)
  rather than help text for the 'assembly_uploader' tool. No command-line arguments,
  flags, or usage instructions were found in the input.\n\nTool homepage: https://github.com/EBI-Metagenomics/assembly_uploader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblycomparator2:2.7.1--hdfd78af_2
stdout: assembly_uploader.out
