cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbwt
label: pbwt
doc: "Positional Burrows-Wheeler Transform (PBWT) for genetic data analysis, including
  reading/writing various formats, phasing, and imputation.\n\nTool homepage: https://github.com/richarddurbin/pbwt"
inputs:
  - id: build_reverse
    type:
      - 'null'
      - boolean
    doc: build reverse pbwt
    inputBinding:
      position: 101
      prefix: -buildReverse
  - id: check
    type:
      - 'null'
      - boolean
    doc: do various checks
    inputBinding:
      position: 101
      prefix: -check
  - id: checkpoint
    type:
      - 'null'
      - int
    doc: checkpoint every n sites while reading
    inputBinding:
      position: 101
      prefix: -checkpoint
  - id: copy_samples
    type:
      - 'null'
      - type: array
        items: float
    doc: make M new samples copied from current haplotypes with mean switch 
      length len (expects <M> <len>)
    inputBinding:
      position: 101
      prefix: -copySamples
  - id: corrupt_samples
    type:
      - 'null'
      - type: array
        items: float
    doc: randomise fraction q of positions for fraction p of samples (expects 
      <p> <q>)
    inputBinding:
      position: 101
      prefix: -corruptSamples
  - id: corrupt_sites
    type:
      - 'null'
      - type: array
        items: float
    doc: randomise fraction q of positions at fraction p of sites (expects <p> 
      <q>)
    inputBinding:
      position: 101
      prefix: -corruptSites
  - id: fit_alpha_beta
    type:
      - 'null'
      - int
    doc: fit probabilistic model 1..3
    inputBinding:
      position: 101
      prefix: -fitAlphaBeta
  - id: four_haps_stats
    type:
      - 'null'
      - boolean
    doc: mu:rho 4 hap test stats
    inputBinding:
      position: 101
      prefix: -4hapsStats
  - id: genotype_compare
    type:
      - 'null'
      - string
    doc: compare genotypes with those from reference whose root name is the 
      argument
    inputBinding:
      position: 101
      prefix: -genotypeCompare
  - id: impute_explore
    type:
      - 'null'
      - int
    doc: n'th impute test
    inputBinding:
      position: 101
      prefix: -imputeExplore
  - id: impute_missing
    type:
      - 'null'
      - boolean
    doc: impute data marked as missing
    inputBinding:
      position: 101
      prefix: -imputeMissing
  - id: ll_copy_model
    type:
      - 'null'
      - type: array
        items: float
    doc: log likelihood of Li-Stephens model (expects <theta> <rho>)
    inputBinding:
      position: 101
      prefix: -llCopyModel
  - id: log
    type:
      - 'null'
      - File
    doc: log file; '-' for stderr
    inputBinding:
      position: 101
      prefix: -log
  - id: long_within
    type:
      - 'null'
      - int
    doc: find matches within set longer than L
    inputBinding:
      position: 101
      prefix: -longWithin
  - id: match_dynamic
    type:
      - 'null'
      - File
    doc: maximal match seqs in pbwt file to reference
    inputBinding:
      position: 101
      prefix: -matchDynamic
  - id: match_indexed
    type:
      - 'null'
      - File
    doc: maximal match seqs in pbwt file to reference
    inputBinding:
      position: 101
      prefix: -matchIndexed
  - id: match_naive
    type:
      - 'null'
      - File
    doc: maximal match seqs in pbwt file to reference
    inputBinding:
      position: 101
      prefix: -matchNaive
  - id: max_within
    type:
      - 'null'
      - boolean
    doc: find maximal matches within set
    inputBinding:
      position: 101
      prefix: -maxWithin
  - id: merge
    type:
      - 'null'
      - type: array
        items: File
    doc: merge two or more pbwt files
    inputBinding:
      position: 101
      prefix: -merge
  - id: paint
    type:
      - 'null'
      - type: array
        items: string
    doc: output painting co-ancestry matrix to fileroot, optionally specififying
      the number per region (expects <fileNameRoot> [n])
    inputBinding:
      position: 101
      prefix: -paint
  - id: paint_sparse
    type:
      - 'null'
      - type: array
        items: string
    doc: output sparse painting to fileroot, optionally specififying the number 
      per region (expects <fileNameRoot> [n])
    inputBinding:
      position: 101
      prefix: -paintSparse
  - id: phase
    type:
      - 'null'
      - int
    doc: phase with n sparse pbwts
    inputBinding:
      position: 101
      prefix: -phase
  - id: pretty
    type:
      - 'null'
      - type: array
        items: string
    doc: pretty plot at site k (expects <file> <k>)
    inputBinding:
      position: 101
      prefix: -pretty
  - id: read
    type:
      - 'null'
      - File
    doc: read pbwt file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -read
  - id: read_all
    type:
      - 'null'
      - string
    doc: read .pbwt and if present .sites, .samples, .missing - note not by 
      default dosage
    inputBinding:
      position: 101
      prefix: -readAll
  - id: read_dosage
    type:
      - 'null'
      - File
    doc: read dosage file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -readDosage
  - id: read_gen
    type:
      - 'null'
      - type: array
        items: string
    doc: read impute2 gen file - must set chrom (expects <file> <chrom>)
    inputBinding:
      position: 101
      prefix: -readGen
  - id: read_genetic_map
    type:
      - 'null'
      - File
    doc: read Oxford format genetic map file
    inputBinding:
      position: 101
      prefix: -readGeneticMap
  - id: read_hap
    type:
      - 'null'
      - type: array
        items: string
    doc: read impute2 hap file - must set chrom (expects <file> <chrom>)
    inputBinding:
      position: 101
      prefix: -readHap
  - id: read_hap_legend
    type:
      - 'null'
      - type: array
        items: string
    doc: read impute2 hap and legend file - must set chrom (expects <hap_file> 
      <legend_file> <chrom>)
    inputBinding:
      position: 101
      prefix: -readHapLegend
  - id: read_macs
    type:
      - 'null'
      - File
    doc: read MaCS output file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -readMacs
  - id: read_missing
    type:
      - 'null'
      - File
    doc: read missing file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -readMissing
  - id: read_phase
    type:
      - 'null'
      - File
    doc: read Li and Stephens phase file
    inputBinding:
      position: 101
      prefix: -readPhase
  - id: read_reverse
    type:
      - 'null'
      - File
    doc: read reverse file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -readReverse
  - id: read_samples
    type:
      - 'null'
      - File
    doc: read samples file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -readSamples
  - id: read_sites
    type:
      - 'null'
      - File
    doc: read sites file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -readSites
  - id: read_vcf_gt
    type:
      - 'null'
      - File
    doc: read GTs from vcf or bcf file; '-' for stdin vcf only ; biallelic sites
      only - require diploid!
    inputBinding:
      position: 101
      prefix: -readVcfGT
  - id: read_vcf_pl
    type:
      - 'null'
      - File
    doc: read PLs from vcf or bcf file; '-' for stdin vcf only ; biallelic sites
      only - require diploid!
    inputBinding:
      position: 101
      prefix: -readVcfPL
  - id: read_vcfq
    type:
      - 'null'
      - File
    doc: read VCFQ file; '-' for stdin
    inputBinding:
      position: 101
      prefix: -readVcfq
  - id: ref_freq
    type:
      - 'null'
      - File
    doc: read site frequency information into the refFreq field of current sites
    inputBinding:
      position: 101
      prefix: -refFreq
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference fasta filename for VCF/BCF writing (optional)
    inputBinding:
      position: 101
      prefix: -referenceFasta
  - id: reference_impute
    type:
      - 'null'
      - type: array
        items: string
    doc: impute current pbwt into reference whose root name is the first 
      argument; optional nSparse > 1 and fSparse (expects <root> [nSparse] 
      [fSparse])
    inputBinding:
      position: 101
      prefix: -referenceImpute
  - id: reference_phase
    type:
      - 'null'
      - string
    doc: phase current pbwt against reference whose root name is the argument
    inputBinding:
      position: 101
      prefix: -referencePhase
  - id: remove_sites
    type:
      - 'null'
      - File
    doc: remove sites as in sites file
    inputBinding:
      position: 101
      prefix: -removeSites
  - id: select_samples
    type:
      - 'null'
      - File
    doc: select samples as in samples file
    inputBinding:
      position: 101
      prefix: -selectSamples
  - id: select_sites
    type:
      - 'null'
      - File
    doc: select sites as in sites file
    inputBinding:
      position: 101
      prefix: -selectSites
  - id: sfs
    type:
      - 'null'
      - boolean
    doc: print site frequency spectrum (log scale) - also writes sites.freq file
    inputBinding:
      position: 101
      prefix: -sfs
  - id: site_info
    type:
      - 'null'
      - type: array
        items: string
    doc: export PBWT information at sites with allele count kmin <= k < kmax 
      (expects <file> <kmin> <kmax>)
    inputBinding:
      position: 101
      prefix: -siteInfo
  - id: stats
    type:
      - 'null'
      - boolean
    doc: print stats depending on commands; writes to stdout
    inputBinding:
      position: 101
      prefix: -stats
  - id: subrange
    type:
      - 'null'
      - type: array
        items: int
    doc: cut down to sites in [start,end) (expects <start> <end>)
    inputBinding:
      position: 101
      prefix: -subrange
  - id: subsample
    type:
      - 'null'
      - type: array
        items: int
    doc: subsample <n> samples from index <start> (expects <start> <n>)
    inputBinding:
      position: 101
      prefix: -subsample
  - id: subsites
    type:
      - 'null'
      - type: array
        items: float
    doc: subsample <frac> sites with AF > <fmin> (expects <fmin> <frac>)
    inputBinding:
      position: 101
      prefix: -subsites
  - id: haps_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `haps_path`
    inputBinding:
      position: 102
      prefix: --haps
  - id: write_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_path`
    inputBinding:
      position: 103
      prefix: --write
  - id: write_all_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_all_path`
    inputBinding:
      position: 104
      prefix: --write-all
  - id: write_bcf_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_bcf_path`
    inputBinding:
      position: 105
      prefix: --write-bcf
  - id: write_bcf_gz_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_bcf_gz_path`
    inputBinding:
      position: 106
      prefix: --write-bcf-gz
  - id: write_dosage_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_dosage_path`
    inputBinding:
      position: 107
      prefix: --write-dosage
  - id: write_gen_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_gen_path`
    inputBinding:
      position: 108
      prefix: --write-gen
  - id: write_impute_haps_g_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_impute_haps_g_path`
    inputBinding:
      position: 109
      prefix: --write-impute-haps-g
  - id: write_impute_ref_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_impute_ref_path`
    inputBinding:
      position: 110
      prefix: --write-impute-ref
  - id: write_missing_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_missing_path`
    inputBinding:
      position: 111
      prefix: --write-missing
  - id: write_phase_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_phase_path`
    inputBinding:
      position: 112
      prefix: --write-phase
  - id: write_reverse_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_reverse_path`
    inputBinding:
      position: 113
      prefix: --write-reverse
  - id: write_samples_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_samples_path`
    inputBinding:
      position: 114
      prefix: --write-samples
  - id: write_sites_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_sites_path`
    inputBinding:
      position: 115
      prefix: --write-sites
  - id: write_transpose_haplotypes_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_transpose_haplotypes_path`
    inputBinding:
      position: 116
      prefix: --write-transpose-haplotypes
  - id: write_vcf_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_vcf_path`
    inputBinding:
      position: 117
      prefix: --write-vcf
  - id: write_vcf_gz_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `write_vcf_gz_path`
    inputBinding:
      position: 118
      prefix: --write-vcf-gz
outputs:
  - id: write
    type:
      - 'null'
      - File
    doc: write pbwt file; '-' for stdout
    outputBinding:
      glob: $(inputs.write_path)
  - id: write_sites
    type:
      - 'null'
      - File
    doc: write sites file; '-' for stdout
    outputBinding:
      glob: $(inputs.write_sites_path)
  - id: write_samples
    type:
      - 'null'
      - File
    doc: write samples file; '-' for stdout
    outputBinding:
      glob: $(inputs.write_samples_path)
  - id: write_missing
    type:
      - 'null'
      - File
    doc: write missing file; '-' for stdout
    outputBinding:
      glob: $(inputs.write_missing_path)
  - id: write_dosage
    type:
      - 'null'
      - File
    doc: write missing file; '-' for stdout
    outputBinding:
      glob: $(inputs.write_dosage_path)
  - id: write_reverse
    type:
      - 'null'
      - File
    doc: write reverse file; '-' for stdout
    outputBinding:
      glob: $(inputs.write_reverse_path)
  - id: write_all
    type:
      - 'null'
      - File
    doc: write .pbwt and if present .sites, .samples, .missing, .dosage
    outputBinding:
      glob: $(inputs.write_all_path)
  - id: write_impute_ref
    type:
      - 'null'
      - File
    doc: write .imputeHaps and .imputeLegend
    outputBinding:
      glob: $(inputs.write_impute_ref_path)
  - id: write_impute_haps_g
    type:
      - 'null'
      - File
    doc: write haplotype file for IMPUTE -known_haps_g
    outputBinding:
      glob: $(inputs.write_impute_haps_g_path)
  - id: write_phase
    type:
      - 'null'
      - File
    doc: write FineSTRUCTURE/ChromoPainter input format (Impute/ShapeIT output 
      format) phase file
    outputBinding:
      glob: $(inputs.write_phase_path)
  - id: write_transpose_haplotypes
    type:
      - 'null'
      - File
    doc: write transposed haplotype file (one hap per row); '-' for stdout
    outputBinding:
      glob: $(inputs.write_transpose_haplotypes_path)
  - id: haps
    type:
      - 'null'
      - File
    doc: write haplotype file; '-' for stdout
    outputBinding:
      glob: $(inputs.haps_path)
  - id: write_gen
    type:
      - 'null'
      - File
    doc: write impute2 gen file; '-' for stdout
    outputBinding:
      glob: $(inputs.write_gen_path)
  - id: write_vcf
    type:
      - 'null'
      - File
    doc: write VCF; uncompressed; '-' for stdout
    outputBinding:
      glob: $(inputs.write_vcf_path)
  - id: write_vcf_gz
    type:
      - 'null'
      - File
    doc: write VCF; bgzip compressed file
    outputBinding:
      glob: $(inputs.write_vcf_gz_path)
  - id: write_bcf
    type:
      - 'null'
      - File
    doc: write BCF; uncompressed
    outputBinding:
      glob: $(inputs.write_bcf_path)
  - id: write_bcf_gz
    type:
      - 'null'
      - File
    doc: write BCF; bgzip compressed file
    outputBinding:
      glob: $(inputs.write_bcf_gz_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbwt:3.0--hed50d52_1
