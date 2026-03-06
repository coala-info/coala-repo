cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - convert
label: bcftools_convert
doc: Converts VCF/BCF to other formats and back.
inputs:
  - id: input_file
    type: File
    doc: Input VCF/BCF file
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - boolean
    doc: Output chromosome in first column instead of CHROM:POS_REF_ALT
    inputBinding:
      position: 102
      prefix: --chrom
  - id: columns
    type:
      - 'null'
      - string
    doc: Columns of the input tsv file
    inputBinding:
      position: 102
      prefix: --columns
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --exclude
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: Reference sequence in fasta format
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: gensample
    type:
      - 'null'
      - type: array
        items: string
    doc: <PREFIX>|<GEN-FILE>,<SAMPLE-FILE>
    inputBinding:
      position: 102
      prefix: --gensample
  - id: gensample2vcf
    type:
      - 'null'
      - type: array
        items: string
    doc: <PREFIX>|<GEN-FILE>,<SAMPLE-FILE>
    inputBinding:
      position: 102
      prefix: --gensample2vcf
  - id: gvcf2vcf
    type:
      - 'null'
      - boolean
    doc: Expand gVCF reference blocks
    inputBinding:
      position: 102
      prefix: --gvcf2vcf
  - id: haplegendsample
    type:
      - 'null'
      - type: array
        items: string
    doc: <PREFIX>|<HAP-FILE>,<LEGEND-FILE>,<SAMPLE-FILE>
    inputBinding:
      position: 102
      prefix: --haplegendsample
  - id: haplegendsample2vcf
    type:
      - 'null'
      - type: array
        items: string
    doc: <PREFIX>|<HAP-FILE>,<LEGEND-FILE>,<SAMPLE-FILE>
    inputBinding:
      position: 102
      prefix: --haplegendsample2vcf
  - id: haploid2diploid
    type:
      - 'null'
      - boolean
    doc: Convert haploid genotypes to diploid homozygotes
    inputBinding:
      position: 102
      prefix: --haploid2diploid
  - id: hapsample
    type:
      - 'null'
      - type: array
        items: string
    doc: <PREFIX>|<HAP-FILE>,<SAMPLE-FILE>
    inputBinding:
      position: 102
      prefix: --hapsample
  - id: hapsample2vcf
    type:
      - 'null'
      - type: array
        items: string
    doc: <PREFIX>|<HAP-FILE>,<SAMPLE-FILE>
    inputBinding:
      position: 102
      prefix: --hapsample2vcf
  - id: include
    type:
      - 'null'
      - string
    doc: Select sites for which the expression is true
    inputBinding:
      position: 102
      prefix: --include
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Keep duplicate positions
    inputBinding:
      position: 102
      prefix: --keep-duplicates
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 102
      prefix: --no-version
  - id: output
    type: string
    doc: Output file name
    inputBinding:
      position: 102
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'u/b: un/compressed BCF, v/z: un/compressed VCF, 0-9: compression level'
    inputBinding:
      position: 102
      prefix: --output-type
  - id: regions
    type:
      - 'null'
      - string
    doc: Restrict to comma-separated list of regions
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: regions_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: samples
    type:
      - 'null'
      - string
    doc: List of samples to include
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to include
    inputBinding:
      position: 102
      prefix: --samples-file
  - id: sex
    type:
      - 'null'
      - File
    doc: 'Output sex column in the sample-file, input format is: Sample\t[MF]'
    inputBinding:
      position: 102
      prefix: --sex
  - id: tag
    type:
      - 'null'
      - string
    doc: 'Tag to take values for .gen file: GT,PL,GL,GP'
    inputBinding:
      position: 102
      prefix: --tag
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: targets_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    inputBinding:
      position: 102
      prefix: --targets-overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: Use multithreading with INT worker threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: three_n_six
    type:
      - 'null'
      - boolean
    doc: Use 3*N+6 column format instead of the old 3*N+5 column format
    inputBinding:
      position: 102
      prefix: --3N6
  - id: tsv2vcf
    type:
      - 'null'
      - File
    doc: Convert TSV to VCF
    inputBinding:
      position: 102
      prefix: --tsv2vcf
  - id: vcf_ids
    type:
      - 'null'
      - boolean
    doc: Output VCF IDs instead of CHROM:POS_REF_ALT
    inputBinding:
      position: 102
      prefix: --vcf-ids
  - id: write_index
    type:
      - 'null'
      - string
    doc: Automatically index the output files
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
s:url: https://github.com/samtools/bcftools
$namespaces:
  s: https://schema.org/
