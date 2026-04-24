cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haptools
  - ld
label: haptools_ld
doc: "Compute the pair-wise LD (Pearson's correlation) between haplotypes (or variants)
  and a single TARGET haplotype (or variant)\n\nTool homepage: https://github.com/cast-genomics/haptools"
inputs:
  - id: target
    type: string
    doc: The ID of a variant or haplotype. LD is computed pair-wise between 
      TARGET and all of the other haplotypes in the .hap (or genotype) file
    inputBinding:
      position: 1
  - id: genotypes
    type: File
    doc: GENOTYPES must be formatted as a VCF or PGEN
    inputBinding:
      position: 2
  - id: haplotypes
    type: File
    doc: HAPLOTYPES must be formatted according to the .hap format spec
    inputBinding:
      position: 3
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: If using a PGEN file, read genotypes in chunks of X variants; reduces 
      memory
    inputBinding:
      position: 104
      prefix: --chunk-size
  - id: discard_missing
    type:
      - 'null'
      - boolean
    doc: Ignore any samples that are missing genotypes for the required variants
    inputBinding:
      position: 104
      prefix: --discard-missing
  - id: from_gts
    type:
      - 'null'
      - boolean
    doc: By default, LD is computed with the haplotypes in the .hap file. Use 
      this switch to compute LD with the genotypes in the genotypes file, 
      instead.
    inputBinding:
      position: 104
      prefix: --from-gts
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of the haplotype IDs to use from the .hap file (ex: '-i H1 -i H2').
      Or, if --from-gts, a list of the variant IDs to use from the genotypes file.
      For this to work, the .hap file must be indexed"
    inputBinding:
      position: 104
      prefix: --id
  - id: ids_file
    type:
      - 'null'
      - File
    doc: A single column txt file containing a list of the haplotype (or 
      variant) IDs (one per line) to subset from the .hap (or genotype) file
    inputBinding:
      position: 104
      prefix: --ids-file
  - id: region
    type:
      - 'null'
      - string
    doc: "The region from which to extract haplotypes; ex: 'chr1:1234-34566' or 'chr7'.
      For this to work, the VCF and .hap file must be indexed and the seqname provided
      must correspond with one in the files"
    inputBinding:
      position: 104
      prefix: --region
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of the samples to subset from the genotypes file (ex: '-s sample1
      -s sample2')"
    inputBinding:
      position: 104
      prefix: --sample
  - id: samples_file
    type:
      - 'null'
      - File
    doc: A single column txt file containing a list of the samples (one per 
      line) to subset from the genotypes file
    inputBinding:
      position: 104
      prefix: --samples-file
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The level of verbosity desired
    inputBinding:
      position: 104
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: A .hap file containing haplotypes and their LD with TARGET
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
