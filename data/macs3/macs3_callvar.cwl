cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - callvar
label: macs3_callvar
doc: Call variants from ChIP-seq/ATAC-seq treatment and optional control BAM 
  files within peak regions.
inputs:
  - id: altallele_count
    type:
      - 'null'
      - int
    doc: The minimum count of the alternative (non-reference) allele at a loci.
    default: 2
    inputBinding:
      position: 101
      prefix: --altallele-count
  - id: base_quality_score
    type:
      - 'null'
      - int
    doc: Only consider bases with quality score greater than this value.
    default: 20
    inputBinding:
      position: 101
      prefix: -Q
  - id: control_file
    type:
      - 'null'
      - File
    doc: Optional control file in BAM format, sorted by coordinates. Make sure 
      the .bai file is avaiable in the same directory.
    inputBinding:
      position: 101
      prefix: --control
  - id: fermi
    type:
      - 'null'
      - string
    doc: 'Option to control when to apply local assembly through fermi-lite. Options:
      auto, on, off.'
    default: auto
    inputBinding:
      position: 101
      prefix: --fermi
  - id: fermi_overlap
    type:
      - 'null'
      - int
    doc: The minimal overlap for fermi to initially assemble two reads. Must be 
      between 1 and read length.
    default: 30
    inputBinding:
      position: 101
      prefix: --fermi-overlap
  - id: gq_cutoff_hetero
    type:
      - 'null'
      - float
    doc: Genotype Quality score (-10log10((L00+L11)/(L01+L00+L11))) cutoff for 
      Heterozygous allele type.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --gq-hetero
  - id: gq_cutoff_homo
    type:
      - 'null'
      - float
    doc: Genotype Quality score (-10log10((L00+L01)/(L01+L00+L11))) cutoff for 
      Homozygous allele (not the same as reference) type.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --gq-homo
  - id: max_ar
    type:
      - 'null'
      - float
    doc: The maximum Allele-Ratio allowed while calculating likelihood for 
      allele-specific binding.
    default: 0.95
    inputBinding:
      position: 101
      prefix: --max-ar
  - id: max_duplicate
    type:
      - 'null'
      - int
    doc: Maximum duplicated reads allowed per mapping position, mapping strand 
      and the same CIGAR code.
    default: 1
    inputBinding:
      position: 101
      prefix: -D
  - id: multiple_processing
    type:
      - 'null'
      - int
    doc: CPU used for multiple processing.
    default: 1
    inputBinding:
      position: 101
      prefix: --multiple-processing
  - id: outdir
    type: string
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_vcf
    type: string
    doc: Output VCF file name.
    inputBinding:
      position: 101
      prefix: --ofile
  - id: peak_bed
    type: File
    doc: Peak regions in BED format, sorted by coordinates.
    inputBinding:
      position: 101
      prefix: --peak
  - id: top2alleles_mratio
    type:
      - 'null'
      - float
    doc: The minimum ratio of reads for the top 2 most frequent alleles 
      comparing to total reads mapped. Must be a float between 0.5 and 1.
    default: 0.8
    inputBinding:
      position: 101
      prefix: --top2alleles-mratio
  - id: treatment_file
    type: File
    doc: ChIP-seq/ATAC-seq treatment file in BAM format, sorted by coordinates. 
      Make sure the .bai file is avaiable in the same directory.
    inputBinding:
      position: 101
      prefix: --treatment
outputs:
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_output_vcf
    type: File
    doc: Output VCF file name.
    outputBinding:
      glob: $(inputs.output_vcf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
s:url: https://pypi.org/project/MACS3/
$namespaces:
  s: https://schema.org/
