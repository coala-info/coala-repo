cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - akt
  - pedphase
label: akt_pedphase
doc: "simple Mendel inheritance phasing of duos/trios\n\nTool homepage: https://github.com/Illumina/akt"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file (e.g., input.vcf.gz)
    inputBinding:
      position: 1
  - id: exclude_chromosome
    type:
      - 'null'
      - string
    doc: leave these chromosomes unphased (unphased lines will still be in in output)
      eg. -x chrM,chrY
    inputBinding:
      position: 102
      prefix: --exclude-chromosome
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed
      VCF'
    inputBinding:
      position: 102
      prefix: --output-type
  - id: pedigree
    type: File
    doc: pedigree information in plink .fam format
    inputBinding:
      position: 102
      prefix: --pedigree
  - id: threads
    type:
      - 'null'
      - int
    doc: number of compression/decompression threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
