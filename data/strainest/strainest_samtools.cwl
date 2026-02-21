cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strainest
  - samtools
label: strainest_samtools
doc: "StrainEst is a tool for strain-level profiling of metagenomic samples. This
  command represents the samtools subcommand within the StrainEst suite.\n\nTool homepage:
  https://github.com/compmetagen/strainest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py36h2d50403_2
stdout: strainest_samtools.out
