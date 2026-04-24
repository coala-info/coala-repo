cwlVersion: v1.2
class: CommandLineTool
baseCommand: selscan
label: selscan
doc: "A program to calculate EHH-based scans for positive selection in genomes, implementing
  EHH, iHS, XP-EHH, and nSL.\n\nTool homepage: https://github.com/szpiech/selscan"
inputs:
  - id: alt
    type:
      - 'null'
      - boolean
    doc: Set this flag to calculate homozygosity based on the sum of the squared
      haplotype frequencies in the observed data instead of using binomial 
      coefficients.
    inputBinding:
      position: 101
      prefix: --alt
  - id: cutoff
    type:
      - 'null'
      - float
    doc: The EHH decay cutoff.
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: ehh
    type:
      - 'null'
      - string
    doc: "Calculate EHH of the '1' and '0' haplotypes at the specified locus. Output:
      <physical dist> <genetic dist> <'1' EHH> <'0' EHH>"
    inputBinding:
      position: 101
      prefix: --ehh
  - id: ehh_win
    type:
      - 'null'
      - int
    doc: When calculating EHH, this is the length of the window in bp in each 
      direction from the query locus.
    inputBinding:
      position: 101
      prefix: --ehh-win
  - id: gap_scale
    type:
      - 'null'
      - int
    doc: Gap scale parameter in bp. If a gap is encountered between two snps > 
      GAP_SCALE and < MAX_GAP, then the genetic distance is scaled by 
      GAP_SCALE/GAP.
    inputBinding:
      position: 101
      prefix: --gap-scale
  - id: hap
    type:
      - 'null'
      - File
    doc: A hapfile with one row per haplotype, and one column per variant. 
      Variants should be coded 0/1
    inputBinding:
      position: 101
      prefix: --hap
  - id: ihh12
    type:
      - 'null'
      - boolean
    doc: Set this flag to calculate iHH12.
    inputBinding:
      position: 101
      prefix: --ihh12
  - id: ihs
    type:
      - 'null'
      - boolean
    doc: Set this flag to calculate iHS.
    inputBinding:
      position: 101
      prefix: --ihs
  - id: ihs_detail
    type:
      - 'null'
      - boolean
    doc: Set this flag to write out left and right iHH scores for '1' and '0' in
      addition to iHS.
    inputBinding:
      position: 101
      prefix: --ihs-detail
  - id: keep_low_freq
    type:
      - 'null'
      - boolean
    doc: Include low frequency variants in the construction of your haplotypes.
    inputBinding:
      position: 101
      prefix: --keep-low-freq
  - id: maf
    type:
      - 'null'
      - float
    doc: If a site has a MAF below this value, the program will not use it as a 
      core snp.
    inputBinding:
      position: 101
      prefix: --maf
  - id: map
    type:
      - 'null'
      - File
    doc: A mapfile with one row per variant site. Formatted <chr#> <locusID> 
      <genetic pos> <physical pos>.
    inputBinding:
      position: 101
      prefix: --map
  - id: max_extend
    type:
      - 'null'
      - int
    doc: The maximum distance an EHH decay curve is allowed to extend from the 
      core. Set <= 0 for no restriction.
    inputBinding:
      position: 101
      prefix: --max-extend
  - id: max_extend_nsl
    type:
      - 'null'
      - int
    doc: The maximum distance an nSL haplotype is allowed to extend from the 
      core. Set <= 0 for no restriction.
    inputBinding:
      position: 101
      prefix: --max-extend-nsl
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum allowed gap in bp between two snps.
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: nsl
    type:
      - 'null'
      - boolean
    doc: Set this flag to calculate nSL.
    inputBinding:
      position: 101
      prefix: --nsl
  - id: pi
    type:
      - 'null'
      - boolean
    doc: Set this flag to calculate mean pairwise sequence difference in a 
      sliding window.
    inputBinding:
      position: 101
      prefix: --pi
  - id: pi_win
    type:
      - 'null'
      - int
    doc: Sliding window size in bp for calculating pi.
    inputBinding:
      position: 101
      prefix: --pi-win
  - id: ref
    type:
      - 'null'
      - File
    doc: A hapfile with one row per haplotype, and one column per variant. This 
      is the 'reference' population for XP-EHH calculations.
    inputBinding:
      position: 101
      prefix: --ref
  - id: skip_low_freq
    type:
      - 'null'
      - boolean
    doc: This flag is now on by default. If you want to include low frequency 
      variants in the construction of your haplotypes please use the 
      --keep-low-freq flag.
    inputBinding:
      position: 101
      prefix: --skip-low-freq
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to spawn during the calculation.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tped
    type:
      - 'null'
      - File
    doc: A TPED file containing haplotype and map data.
    inputBinding:
      position: 101
      prefix: --tped
  - id: tped_ref
    type:
      - 'null'
      - File
    doc: A TPED file containing haplotype and map data. This is the 'reference' 
      population for XP-EHH calculations.
    inputBinding:
      position: 101
      prefix: --tped-ref
  - id: trunc_ok
    type:
      - 'null'
      - boolean
    doc: If an EHH decay reaches the end of a sequence before reaching the 
      cutoff, integrate the curve anyway (iHS and XPEHH only).
    inputBinding:
      position: 101
      prefix: --trunc-ok
  - id: vcf
    type:
      - 'null'
      - File
    doc: A VCF file containing haplotype data. A map file must be specified with
      --map.
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_ref
    type:
      - 'null'
      - File
    doc: A VCF file containing haplotype and map data. This is the 'reference' 
      population for XP-EHH calculations.
    inputBinding:
      position: 101
      prefix: --vcf-ref
  - id: xpehh
    type:
      - 'null'
      - boolean
    doc: Set this flag to calculate XP-EHH.
    inputBinding:
      position: 101
      prefix: --xpehh
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: The basename for all output files.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selscan:1.2.0a--hb66fcc3_7
