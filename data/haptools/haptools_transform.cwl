cwlVersion: v1.2
class: CommandLineTool
baseCommand: haptools transform
label: haptools_transform
doc: "Creates a VCF composed of haplotypes\n\nTool homepage: https://github.com/cast-genomics/haptools"
inputs:
  - id: genotypes
    type: File
    doc: GENOTYPES must be formatted as a VCF or PGEN
    inputBinding:
      position: 1
  - id: haplotypes
    type: File
    doc: HAPLOTYPES must be formatted according to the .hap format spec
    inputBinding:
      position: 2
  - id: ancestry
    type:
      - 'null'
      - boolean
    doc: Also transform using VCF 'POP' FORMAT field and 'ancestry' .hap extra 
      field
    inputBinding:
      position: 103
      prefix: --ancestry
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: If using a PGEN file, read genotypes in chunks of X variants; reduces 
      memory
    inputBinding:
      position: 103
      prefix: --chunk-size
  - id: discard_missing
    type:
      - 'null'
      - boolean
    doc: Ignore any samples that are missing genotypes for the required variants
    inputBinding:
      position: 103
      prefix: --discard-missing
  - id: haplotype_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of the haplotype IDs to use from the .hap file (ex: '-i H1 -i H2')"
    inputBinding:
      position: 103
      prefix: --id
  - id: haplotype_ids_file
    type:
      - 'null'
      - File
    doc: A single column txt file containing a list of the haplotype IDs (one 
      per line) to subset from the .hap file
    inputBinding:
      position: 103
      prefix: --ids-file
  - id: maf
    type:
      - 'null'
      - float
    doc: Do not output haplotypes with an MAF below this value
    inputBinding:
      position: 103
      prefix: --maf
  - id: region
    type:
      - 'null'
      - string
    doc: "The region from which to extract haplotypes; ex: 'chr1:1234-34566' or 'chr7'.
      For this to work, the VCF and .hap file must be indexed and the seqname provided
      must correspond with one in the files"
    inputBinding:
      position: 103
      prefix: --region
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of the samples to subset from the genotypes file (ex: '-s sample1
      -s sample2')"
    inputBinding:
      position: 103
      prefix: --sample
  - id: samples_file
    type:
      - 'null'
      - File
    doc: A single column txt file containing a list of the samples (one per 
      line) to subset from the genotypes file
    inputBinding:
      position: 103
      prefix: --samples-file
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The level of verbosity desired
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: A VCF file containing haplotype 'genotypes'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
