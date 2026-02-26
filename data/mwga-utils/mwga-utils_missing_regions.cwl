cwlVersion: v1.2
class: CommandLineTool
baseCommand: missing_regions
label: mwga-utils_missing_regions
doc: "Add regions from the reference genome that are missing from a MAF file.\n\n\
  Tool homepage: https://github.com/RomainFeron/mgwa_utils"
inputs:
  - id: maf_file
    type: File
    doc: Path to a MAF file.
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Path to a FASTA file for the reference assembly.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_missing_regions.out
