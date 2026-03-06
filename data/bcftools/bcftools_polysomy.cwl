cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- polysomy
label: bcftools_polysomy
doc: Detect number of chromosomal copies from Illumina's B-allele frequency 
  (BAF)
inputs:
- id: input_vcf
  type: File
  doc: Input VCF file
  inputBinding:
    position: 1
- id: cn_penalty
  type: float?
  doc: Penalty for increasing CN (0-1, larger is stricter)
  inputBinding:
    position: 102
    prefix: --cn-penalty
- id: fit_th
  type: float?
  doc: Goodness of fit threshold (>0, smaller is stricter)
  inputBinding:
    position: 102
    prefix: --fit-th
- id: include_aa
  type: boolean?
  doc: Include the AA peak in CN2 and CN3 evaluation
  inputBinding:
    position: 102
    prefix: --include-aa
- id: min_fraction
  type: float?
  doc: Minimum distinguishable fraction of aberrant cells
  inputBinding:
    position: 102
    prefix: --min-fraction
- id: output_dir
  type: string
  doc: Output directory
  inputBinding:
    position: 102
    prefix: --output-dir
- id: peak_size
  type: float?
  doc: Minimum peak size (0-1, larger is stricter)
  inputBinding:
    position: 102
    prefix: --peak-size
- id: peak_symmetry
  type: float?
  doc: Peak symmetry threshold (0-1, larger is stricter)
  inputBinding:
    position: 102
    prefix: --peak-symmetry
- id: regions
  type: string?
  doc: Restrict to comma-separated list of regions
  inputBinding:
    position: 102
    prefix: --regions
- id: regions_file
  type: File?
  doc: Restrict to regions listed in a file
  inputBinding:
    position: 102
    prefix: --regions-file
- id: regions_overlap
  type: int?
  doc: Include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --regions-overlap
- id: sample
  type: string
  doc: Sample to analyze
  inputBinding:
    position: 102
    prefix: --sample
- id: targets
  type: string?
  doc: Similar to -r but streams rather than index-jumps
  inputBinding:
    position: 102
    prefix: --targets
- id: targets_file
  type: File?
  doc: Similar to -R but streams rather than index-jumps
  inputBinding:
    position: 102
    prefix: --targets-file
- id: targets_overlap
  type: int?
  doc: Include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --targets-overlap
outputs:
- id: output_output_dir
  type: Directory
  doc: Output directory
  outputBinding:
    glob: $(inputs.output_dir)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
