cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToVcf
label: ucsc-fatovcf_faToVcf
doc: "Convert a FASTA alignment file to Variant Call Format (VCF) single-nucleotide
  diffs\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA alignment file
    inputBinding:
      position: 1
  - id: ambiguous_to_n
    type:
      - 'null'
      - boolean
    doc: Treat all IUPAC ambiguous bases (N, R, V etc) as N (no call).
    inputBinding:
      position: 102
      prefix: -ambiguousToN
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: Exclude sequences named in file which has one sequence name per line
    inputBinding:
      position: 102
      prefix: -excludeFile
  - id: include_no_alt_n
    type:
      - 'null'
      - boolean
    doc: Include base positions with no alternate alleles observed, but at least
      one N (missing base / no-call)
    inputBinding:
      position: 102
      prefix: -includeNoAltN
  - id: include_ref
    type:
      - 'null'
      - boolean
    doc: 'Include the reference in the genotype columns (default: omitted as redundant)'
    inputBinding:
      position: 102
      prefix: -includeRef
  - id: mask_sites
    type:
      - 'null'
      - File
    doc: Exclude variants in positions recommended for masking in file 
      (typically 
      https://github.com/W-L/ProblematicSites_SARS-CoV2/raw/master/problematic_sites_sarsCov2.vcf)
    inputBinding:
      position: 102
      prefix: -maskSites
  - id: max_diff
    type:
      - 'null'
      - int
    doc: Exclude sequences with more than N mismatches with the reference (if 
      -windowSize is used, sequences are masked accordingly first)
    inputBinding:
      position: 102
      prefix: -maxDiff
  - id: min_ac
    type:
      - 'null'
      - int
    doc: Ignore alternate alleles observed fewer than N times
    inputBinding:
      position: 102
      prefix: -minAc
  - id: min_af
    type:
      - 'null'
      - float
    doc: Ignore alternate alleles observed in less than F of non-N bases
    inputBinding:
      position: 102
      prefix: -minAf
  - id: min_ambig_in_window
    type:
      - 'null'
      - int
    doc: 'When -windowSize is provided, mask any base for which there are at least
      this many N, ambiguous or gap characters within the window. (default: 2)'
    inputBinding:
      position: 102
      prefix: -minAmbigInWindow
  - id: no_genotypes
    type:
      - 'null'
      - boolean
    doc: Output 8-column VCF, without the sample genotype columns
    inputBinding:
      position: 102
      prefix: -noGenotypes
  - id: ref
    type:
      - 'null'
      - string
    doc: 'Use seqName as the reference sequence; must be present in faFile (default:
      first sequence in faFile)'
    inputBinding:
      position: 102
      prefix: -ref
  - id: resolve_ambiguous
    type:
      - 'null'
      - boolean
    doc: For IUPAC ambiguous characters like R (A or G), if the character 
      represents two bases and one is the reference base, convert it to the 
      non-reference base. Otherwise convert it to N.
    inputBinding:
      position: 102
      prefix: -resolveAmbiguous
  - id: start_offset
    type:
      - 'null'
      - int
    doc: Add N bases to each position (for trimmed alignments)
    inputBinding:
      position: 102
      prefix: -startOffset
  - id: vcf_chrom
    type:
      - 'null'
      - string
    doc: 'Use seqName for the CHROM column in VCF (default: ref sequence)'
    inputBinding:
      position: 102
      prefix: -vcfChrom
  - id: window_size
    type:
      - 'null'
      - int
    doc: Mask any base for which there are at least -minAmbigWindow bases in a 
      window of +-N bases around the base. Masking approach adapted from 
      https://github.com/roblanf/sarscov2phylo/ file scripts/mask_seq.py Use 
      -windowSize=7 for same results.
    inputBinding:
      position: 102
      prefix: -windowSize
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatovcf:482--hdc0a859_1
