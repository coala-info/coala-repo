cwlVersion: v1.2
class: CommandLineTool
baseCommand: negspy_chr_pos_to_genome_pos.py
label: negspy_chr_pos_to_genome_pos.py
doc: "Converts chromosome and position to genome position.\n\nTool homepage: https://github.com/pkerpedjiev/negspy"
inputs:
  - id: chromosome
    type: string
    doc: Chromosome name (e.g., chr1, 1)
    inputBinding:
      position: 1
  - id: position
    type: int
    doc: Position on the chromosome (1-based)
    inputBinding:
      position: 2
  - id: assembly
    type:
      - 'null'
      - string
    doc: Genome assembly to use (e.g., hg19, hg38, mm10)
    default: hg19
    inputBinding:
      position: 103
      prefix: --assembly
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Optional output file to write results to. If not provided, results are 
      printed to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negspy:0.2.24--pyh7e72e81_0
