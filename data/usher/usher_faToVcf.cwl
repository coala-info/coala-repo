cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToVcf
label: usher_faToVcf
doc: 'faToVcf: converts a FASTA alignment file to Variant Call Format (VCF) single-nucleotide
  diffs.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: fasta
  type: File
  doc: 'in.fa: a series of sequences with different names and the same length (an
    alignment). Both N and - are treated as missing information.'
  inputBinding:
    position: 1
- id: out_vcf
  type: string
  doc: Name of the output VCF file (out.vcf).
  inputBinding:
    position: 2
- id: ambiguous_to_n
  type:
  - 'null'
  - boolean
  doc: Treat all IUPAC ambiguous bases (N, R, V etc) as N (no call).
  inputBinding:
    position: 101
    prefix: -ambiguousToN
- id: exclude_file
  type:
  - 'null'
  - File
  doc: Exclude sequences named in file which has one sequence name per line
  inputBinding:
    position: 101
    prefix: -excludeFile=
    separate: false
- id: include_no_alt_n
  type:
  - 'null'
  - boolean
  doc: Include base positions with no alternate alleles observed, but at least one
    N (missing base / no-call)
  inputBinding:
    position: 101
    prefix: -includeNoAltN
- id: include_ref
  type:
  - 'null'
  - boolean
  doc: 'Include the reference in the genotype columns (default: omitted as redundant)'
  inputBinding:
    position: 101
    prefix: -includeRef
- id: mask_sites
  type:
  - 'null'
  - File
  doc: Exclude variants in positions recommended for masking in file (typically the
    problematic_sites_sarsCov2.vcf file)
  inputBinding:
    position: 101
    prefix: -maskSites=
    separate: false
- id: max_diff
  type:
  - 'null'
  - int
  doc: Exclude sequences with more than N mismatches with the reference (if -windowSize
    is used, sequences are masked accordingly first)
  inputBinding:
    position: 101
    prefix: -maxDiff=
    separate: false
- id: min_ac
  type:
  - 'null'
  - int
  doc: Ignore alternate alleles observed fewer than N times
  inputBinding:
    position: 101
    prefix: -minAc=
    separate: false
- id: min_af
  type:
  - 'null'
  - float
  doc: Ignore alternate alleles observed in less than F of non-N bases
  inputBinding:
    position: 101
    prefix: -minAf=
    separate: false
- id: min_ambig_in_window
  type:
  - 'null'
  - int
  doc: 'When -windowSize is provided, mask any base for which there are at least this
    many N, ambiguous or gap characters within the window. (default: 2)'
  inputBinding:
    position: 101
    prefix: -minAmbigInWindow=
    separate: false
- id: no_genotypes
  type:
  - 'null'
  - boolean
  doc: Output 8-column VCF, without the sample genotype columns
  inputBinding:
    position: 101
    prefix: -noGenotypes
- id: ref
  type:
  - 'null'
  - string
  doc: 'Use seqName as the reference sequence; must be present in faFile (default:
    first sequence in faFile)'
  inputBinding:
    position: 101
    prefix: -ref=
    separate: false
- id: resolve_ambiguous
  type:
  - 'null'
  - boolean
  doc: For IUPAC ambiguous characters like R (A or G), if the character represents
    two bases and one is the reference base, convert it to the non-reference base.
    Otherwise convert it to N.
  inputBinding:
    position: 101
    prefix: -resolveAmbiguous
- id: start_offset
  type:
  - 'null'
  - int
  doc: Add N bases to each position (for trimmed alignments)
  inputBinding:
    position: 101
    prefix: -startOffset=
    separate: false
- id: vcf_chrom
  type:
  - 'null'
  - string
  doc: 'Use seqName for the CHROM column in VCF (default: ref sequence)'
  inputBinding:
    position: 101
    prefix: -vcfChrom=
    separate: false
- id: window_size
  type:
  - 'null'
  - int
  doc: Mask any base for which there are at least -minAmbigWindow bases in a window
    of +-N bases around the base. Use -windowSize=7 for same results as the sarscov2phylo
    mask_seq.py.
  inputBinding:
    position: 101
    prefix: -windowSize=
    separate: false
outputs:
- id: vcf
  type: File
  doc: Output VCF file.
  outputBinding:
    glob: $(inputs.out_vcf)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
