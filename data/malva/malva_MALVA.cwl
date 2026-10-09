cwlVersion: v1.2
class: CommandLineTool
baseCommand: MALVA
label: malva_MALVA
doc: 'MALVA is a tool for variant calling in sequencing data.


  Tool homepage: https://algolab.github.io/malva/'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.variants)
        writable: true
      - entry: $(inputs.sample)
        writable: true
inputs:
  - id: reference
    type: File
    doc: reference file in FASTA format
    inputBinding:
      position: 10
  - id: variants
    type: File
    doc: variants file in VCF format; staged in the job directory because the MALVA
      script writes its index beside it
    inputBinding:
      position: 11
      valueFrom: $(self.basename)
  - id: sample
    type: File
    doc: sample file in FASTA format (the script counts its k-mers with kmc -fm);
      staged in the job directory because the script writes the KMC files beside it
    inputBinding:
      position: 12
      valueFrom: $(self.basename)
  - id: bloom_filter_size_gb
    type:
      - 'null'
      - int
    doc: bloom filter size in GB
    inputBinding:
      position: 1
      prefix: -b
  - id: expected_error_rate
    type:
      - 'null'
      - float
    doc: expected sample error rate
    inputBinding:
      position: 1
      prefix: -e
  - id: freq_key
    type:
      - 'null'
      - string
    doc: a priori frequency key in the INFO column of the input VCF
    inputBinding:
      position: 1
      prefix: -f
  - id: haploid_mode
    type:
      - 'null'
      - boolean
    doc: run MALVA in haploid mode
    inputBinding:
      position: 1
      prefix: '-1'
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of the kmers to index
    inputBinding:
      position: 1
      prefix: -k
  - id: max_cov
    type:
      - 'null'
      - int
    doc: maximum coverage for variant alleles
    inputBinding:
      position: 1
      prefix: -c
  - id: max_ram_gb
    type:
      - 'null'
      - int
    doc: max amount of RAM in GB - KMC parameter
    inputBinding:
      position: 1
      prefix: -m
  - id: output_covs_gts
    type:
      - 'null'
      - boolean
    doc: output COVS and GTS in INFO column
    inputBinding:
      position: 1
      prefix: -v
  - id: ref_kmer_size
    type:
      - 'null'
      - int
    doc: size of the reference kmers to index
    inputBinding:
      position: 1
      prefix: -r
  - id: sample_list_file
    type:
      - 'null'
      - File
    doc: file containing the list of (VCF) samples to consider (default:-, i.e. all
      samples)
    inputBinding:
      position: 1
      prefix: -s
  - id: strip_chr
    type:
      - 'null'
      - boolean
    doc: strip "chr" from sequence names
    inputBinding:
      position: 1
      prefix: -p
  - id: uniform_prior
    type:
      - 'null'
      - boolean
    doc: use uniform a priori probabilities
    inputBinding:
      position: 1
      prefix: -u
outputs:
  - id: genotyped_vcf
    type: stdout
    doc: Genotyped VCF
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva_MALVA.vcf
