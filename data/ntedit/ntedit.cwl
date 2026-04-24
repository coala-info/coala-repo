cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntedit
label: ntedit
doc: "Fast, lightweight, scalable genome sequence polishing and SNV detection & annotation\n\
  \nTool homepage: https://github.com/bcgsc/ntEdit"
inputs:
  - id: bloom_filter
    type: File
    doc: Bloom filter (BF) or counting BF (CBF) file (generated from ntStat 
      v1.0.0+), REQUIRED
    inputBinding:
      position: 101
      prefix: -r
  - id: draft_genome
    type: File
    doc: draft genome assembly (FASTA, Multi-FASTA, and/or gzipped compatible), 
      REQUIRED
    inputBinding:
      position: 101
      prefix: -f
  - id: editing_mode
    type:
      - 'null'
      - int
    doc: mode of editing, range 0-2
    inputBinding:
      position: 101
      prefix: -m
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: input VCF file with annotated variants (e.g., clinvar.vcf), OPTIONAL
    inputBinding:
      position: 101
      prefix: -l
  - id: insertion_cap
    type:
      - 'null'
      - string
    doc: cap for the number of base insertions that can be made at one position
    inputBinding:
      position: 101
      prefix: -c
  - id: kmer_ratio_missing
    type:
      - 'null'
      - float
    doc: k/x ratio for the number of k-mers that should be missing
    inputBinding:
      position: 101
      prefix: -x
  - id: kmer_ratio_present
    type:
      - 'null'
      - float
    doc: k/y ratio for the number of edited k-mers that should be present
    inputBinding:
      position: 101
      prefix: -y
  - id: kmer_subset_missing_ratio
    type:
      - 'null'
      - float
    doc: ratio of number of k-mers in the k subset that should be missing in 
      order to attempt fix (higher=stringent)
    inputBinding:
      position: 101
      prefix: -X
  - id: kmer_subset_present_ratio
    type:
      - 'null'
      - float
    doc: ratio of number of k-mers in the k subset that should be present to 
      accept an edit (higher=stringent)
    inputBinding:
      position: 101
      prefix: -Y
  - id: kmer_subset_step
    type:
      - 'null'
      - int
    doc: controls size of k-mer subset. When checking subset of k-mers, check 
      every jth k-mer
    inputBinding:
      position: 101
      prefix: -j
  - id: mask_missing_kmers
    type:
      - 'null'
      - int
    doc: soft masks missing k-mer positions having no fix (-v 1 = yes, default =
      0, no)
    inputBinding:
      position: 101
      prefix: -a
  - id: max_deletion_bases
    type:
      - 'null'
      - int
    doc: maximum number of deletions bases to try, range 0-10
    inputBinding:
      position: 101
      prefix: -d
  - id: max_insertion_bases
    type:
      - 'null'
      - int
    doc: maximum number of insertion bases to try, range 0-5
    inputBinding:
      position: 101
      prefix: -i
  - id: max_kmer_coverage
    type:
      - 'null'
      - int
    doc: maximum k-mer coverage threshold (CBF only) [default=255, largest 
      possible value]
    inputBinding:
      position: 101
      prefix: -q
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length
    inputBinding:
      position: 101
      prefix: -z
  - id: min_kmer_coverage
    type:
      - 'null'
      - int
    doc: minimum k-mer coverage threshold (CBF only) [default=minimum of 
      counting Bloom filter counts, cannot be larger than 255]
    inputBinding:
      position: 101
      prefix: -p
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output file prefix, OPTIONAL
    inputBinding:
      position: 101
      prefix: -b
  - id: reject_kmers_bf
    type:
      - 'null'
      - File
    doc: secondary BF with k-mers to reject (generated from ntStat v1.0.0+), 
      OPTIONAL - NOT NEEDED with CBF
    inputBinding:
      position: 101
      prefix: -e
  - id: snv_mode
    type:
      - 'null'
      - int
    doc: SNV mode. Overrides draft k-mer checks, forcing reassessment at each 
      position (-s 1 = yes, default = 0, no)
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbose mode (-v 1 = yes, default = 0, no)
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntedit:2.1.1--pl5321h077b44d_0
stdout: ntedit.out
