cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - allhic
  - extract
label: allhic_extract
doc: "Extract information from BAM and FASTA files for ALLHIC\n\nTool homepage: https://github.com/tanghaibao/allhic"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 2
  - id: min_links
    type:
      - 'null'
      - int
    doc: Minimum number of links for contig pair
    inputBinding:
      position: 103
      prefix: --minLinks
  - id: re
    type:
      - 'null'
      - string
    doc: Restriction site pattern, use comma to separate multiple patterns (N is considered
      as [ACGT]), e.g. 'GATCGATC,GANTGATC,GANTANTC,GATCANTC'
    inputBinding:
      position: 103
      prefix: --RE
outputs:
  - id: clm
    type: File
    doc: Inter-contig link positions (<bam prefix>.clm)
    outputBinding:
      glob: $(inputs.bam_file.nameroot).clm
  - id: counts_re
    type: File
    doc: Restriction site counts per contig (<bam prefix>.counts_<RE>.txt)
    outputBinding:
      glob: $(inputs.bam_file.nameroot).counts_*.txt
  - id: pairs
    type: File
    doc: Contig pair link counts (<bam prefix>.pairs.txt)
    outputBinding:
      glob: $(inputs.bam_file.nameroot).pairs.txt
  - id: distribution
    type: File
    doc: Intra-contig link size distribution (<bam prefix>.distribution.txt)
    outputBinding:
      glob: $(inputs.bam_file.nameroot).distribution.txt
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allhic:0.9.14--he881be0_0
stdout: allhic_extract.out
