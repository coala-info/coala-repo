cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - malva-geno
  - index
label: malva_malva-geno_index
doc: 'Build the MALVA index of the known variants (writes <variants>.c<ref-k>.k<k>.malvax.zst
  next to the VCF).


  Tool homepage: https://algolab.github.io/malva/'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.variants_vcf)
        writable: true
      - $(inputs.kmc_files)
inputs:
  - id: reference_fa
    type: File
    doc: reference file in FASTA format (may be gzipped)
    inputBinding:
      position: 10
  - id: variants_vcf
    type: File
    doc: variants file in VCF format (may be gzipped)
    inputBinding:
      position: 11
      valueFrom: $(self.basename)
  - id: kmc_files
    type:
      type: array
      items: File
    doc: 'KMC database of the sample reads: the .kmc_pre and .kmc_suf files made by
      kmc'
  - id: kmc_output_prefix
    type: string
    doc: prefix of the KMC output (file name without .kmc_pre / .kmc_suf)
    inputBinding:
      position: 12
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of the kmers to index (default:35)
    inputBinding:
      position: 1
      prefix: -k
  - id: ref_kmer_size
    type:
      - 'null'
      - int
    doc: size of the reference kmers to index (default:43)
    inputBinding:
      position: 1
      prefix: -r
  - id: error_rate
    type:
      - 'null'
      - float
    doc: expected sample error rate (default:0.001)
    inputBinding:
      position: 1
      prefix: -e
  - id: samples
    type:
      - 'null'
      - File
    doc: file containing the list of (VCF) samples to consider (default:-, i.e. all
      samples)
    inputBinding:
      position: 1
      prefix: -s
  - id: freq_key
    type:
      - 'null'
      - string
    doc: a priori frequency key in the INFO column of the input VCF (default:AF)
    inputBinding:
      position: 1
      prefix: -f
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: maximum coverage for variant alleles (default:200)
    inputBinding:
      position: 1
      prefix: -c
  - id: bf_size
    type:
      - 'null'
      - int
    doc: bloom filter size in GB (default:4)
    inputBinding:
      position: 1
      prefix: -b
  - id: strip_chr
    type:
      - 'null'
      - boolean
    doc: strip "chr" from sequence names (default:false)
    inputBinding:
      position: 1
      prefix: -p
  - id: uniform
    type:
      - 'null'
      - boolean
    doc: use uniform a priori probabilities (default:false)
    inputBinding:
      position: 1
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'output COVS and GTS in INFO column (default: false)'
    inputBinding:
      position: 1
      prefix: -v
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: 'run MALVA in haploid mode (default: false)'
    inputBinding:
      position: 1
      prefix: '-1'
outputs:
  - id: malva_index
    type:
      type: array
      items: File
    doc: MALVA index file
    outputBinding:
      glob: $(inputs.variants_vcf.basename).c*.k*.malvax*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva_malva-geno_index.out
