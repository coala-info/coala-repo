cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agg
  - genotype
label: agg_genotype
doc: "genotypes samples from agg chunks\n\nTool homepage: https://github.com/Illumina/agg"
inputs:
  - id: chunks
    type:
      type: array
      items: string
    doc: agg chunks to genotype
    inputBinding:
      position: 1
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed
      VCF'
    inputBinding:
      position: 102
      prefix: --output-type
  - id: regions
    type: string
    doc: region to genotype eg. chr1 or chr20:5000000-6000000
    inputBinding:
      position: 102
      prefix: --regions
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: --thread
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agg:0.3.6--hd28b015_0
