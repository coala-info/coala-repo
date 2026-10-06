cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bacpage
  - utilities
  - extract_region
label: bacpage_utilities_extract_region
doc: "Extract regions specified in a bed file from consensus sequences in a project
  directory.\n\nTool homepage: https://github.com/CholGen/bacpage"
inputs:
  - id: directory
    type: Directory
    doc: Project directory (consensus FASTAs in results/consensus) or a folder of 
      FASTA files; results are written to results/extractions inside it.
    inputBinding:
      position: 1
  - id: region
    type: File
    doc: BED file containing region(s) to extract (name, start, end). The tool 
      fails without it.
    inputBinding:
      position: 0
      prefix: --region
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: extractions
    type: Directory
    doc: Folder with one <region>.extracts.fasta per BED region
    outputBinding:
      glob: $(inputs.directory.basename)/results/extractions
  - id: extract_fastas
    type: File[]
    doc: One multi-FASTA per BED region
    outputBinding:
      glob: $(inputs.directory.basename)/results/extractions/*.extracts.fasta
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
stdout: bacpage_utilities_extract_region.out
