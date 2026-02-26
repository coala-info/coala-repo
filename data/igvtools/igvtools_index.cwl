cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - index
label: igvtools_index
doc: "Creates an index for an alignment or feature file (e.g., BED, GFF, or VCF).\n\
  \nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: The input file to be indexed (e.g., .sam, .bam, .tdf, .vcf, .bed).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
stdout: igvtools_index.out
