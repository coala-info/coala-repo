cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- roh
label: bcftools_roh
doc: HMM model for detecting runs of autozygosity.
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
inputs:
- id: input_file
  type: File
  doc: Input VCF/BCF file
  inputBinding:
    position: 1
- id: af_dflt
  type: float?
  doc: If AF is not known, use this allele frequency
  inputBinding:
    position: 102
    prefix: --AF-dflt
- id: af_file
  type: File?
  doc: read allele frequencies from file (CHR\tPOS\tREF,ALT\tAF)
  inputBinding:
    position: 102
    prefix: --AF-file
- id: af_tag
  type: string?
  doc: Use TAG for allele frequency
  inputBinding:
    position: 102
    prefix: --AF-tag
- id: az_to_hw
  type: float?
  doc: P(HW|AZ) transition probability from AZ to HW state
  inputBinding:
    position: 102
    prefix: --az-to-hw
- id: buffer_size
  type: string?
  doc: Buffer size and the number of overlapping sites, 0 for unlimited. If 
    negative, interpreted as max memory in MB.
  inputBinding:
    position: 102
    prefix: --buffer-size
- id: estimate_af
  type: string?
  doc: Estimate AF from FORMAT/TAG (GT or PL) of all samples ("-") or samples 
    listed in FILE.
  inputBinding:
    position: 102
    prefix: --estimate-AF
- id: exclude
  type: string?
  doc: Exclude sites for which the expression is true
  inputBinding:
    position: 102
    prefix: --exclude
- id: genetic_map
  type: File?
  doc: Genetic map in IMPUTE2 format, single file or mask
  inputBinding:
    position: 102
    prefix: --genetic-map
- id: gts_only
  type: float?
  doc: Use GTs and ignore PLs, instead using FLOAT for PL of the two least 
    likely genotypes.
  inputBinding:
    position: 102
    prefix: --GTs-only
- id: hw_to_az
  type: float?
  doc: P(AZ|HW) transition probability from HW (Hardy-Weinberg) to AZ 
    (autozygous) state
  inputBinding:
    position: 102
    prefix: --hw-to-az
- id: ignore_homref
  type: boolean?
  doc: Skip hom-ref genotypes (0/0)
  inputBinding:
    position: 102
    prefix: --ignore-homref
- id: include
  type: string?
  doc: Select sites for which the expression is true
  inputBinding:
    position: 102
    prefix: --include
- id: include_noalt
  type: boolean?
  doc: Include sites with no ALT allele (ignored by default)
  inputBinding:
    position: 102
    prefix: --include-noalt
- id: output
  type: string
  doc: Write output to a file
  inputBinding:
    position: 102
    prefix: --output
- id: output_type
  type: string?
  doc: Output s:per-site, r:regions, z:compressed
  inputBinding:
    position: 102
    prefix: --output-type
- id: rec_rate
  type: float?
  doc: Constant recombination rate per bp
  inputBinding:
    position: 102
    prefix: --rec-rate
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
  doc: include if POS in the region (0), record overlaps (1), variant overlaps 
    (2)
  inputBinding:
    position: 102
    prefix: --regions-overlap
- id: samples
  type: string?
  doc: List of samples to analyze
  inputBinding:
    position: 102
    prefix: --samples
- id: samples_file
  type: File?
  doc: File of samples to analyze
  inputBinding:
    position: 102
    prefix: --samples-file
- id: skip_indels
  type: boolean?
  doc: Skip indels as their genotypes are enriched for errors
  inputBinding:
    position: 102
    prefix: --skip-indels
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
- id: threads
  type: int?
  doc: Use multithreading with <int> worker threads
  inputBinding:
    position: 102
    prefix: --threads
- id: viterbi_training
  type: float?
  doc: Estimate HMM parameters, FLOAT is the convergence threshold
  inputBinding:
    position: 102
    prefix: --viterbi-training
- id: ignore_pl
  type: boolean?
  doc: The FORMAT/PL tag not found in the header, consider running with -G
  inputBinding:
    position: 102
    prefix: -G
outputs:
- id: output_output
  type: File
  doc: Write output to a file
  outputBinding:
    glob: $(inputs.output)
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
