cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntroot
label: ntroot
doc: "Ancestry inference from genomic data\n\nTool homepage: https://github.com/bcgsc/ntroot"
inputs:
  - id: custom_vcf
    type:
      - 'null'
      - File
    doc: Input VCF for computing ancestry. When specified, ntRoot will skip the 
      ntEdit step, and predict ancestry from the provided VCF.
    inputBinding:
      position: 101
      prefix: --custom_vcf
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Print out the commands that will be executed
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: force
    type:
      - 'null'
      - boolean
    doc: Run all ntRoot steps, regardless of existing output files
    inputBinding:
      position: 101
      prefix: --force
  - id: genome
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome assembly file(s) for detecting SNVs compared to --reference
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_vcf
    type: File
    doc: input VCF file with annotated variants (e.g., clinvar.vcf, 
      1000GP_integrated_snv_v2a_27022019.GRCh38.phased_gt1.vcf.gz)
    inputBinding:
      position: 101
      prefix: -l
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 101
      prefix: -k
  - id: kmer_subset_ratio
    type:
      - 'null'
      - float
    doc: Ratio of number of k-mers in the k subset that should be present to 
      accept an edit (higher=stringent)
    inputBinding:
      position: 101
      prefix: -Y
  - id: kmer_subset_size
    type:
      - 'null'
      - int
    doc: controls size of k-mer subset. When checking subset of k-mers, check 
      every jth k-mer
    inputBinding:
      position: 101
      prefix: -j
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimum contig length
    inputBinding:
      position: 101
      prefix: -z
  - id: output_ancestry_per_tile
    type:
      - 'null'
      - boolean
    doc: Output ancestry predictons per tile in a separate output file
    inputBinding:
      position: 101
      prefix: --lai
  - id: reads
    type:
      - 'null'
      - string
    doc: Prefix of input reads file(s) for detecting SNVs. All files in the 
      working directory with the specified prefix will be used. (fastq, fasta, 
      gz, bz, zip)
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome (FASTA, Multi-FASTA, and/or gzipped compatible)
    inputBinding:
      position: 101
      prefix: --reference
  - id: strip_info
    type:
      - 'null'
      - boolean
    doc: When using --custom_vcf, strip the existing INFO field from the input 
      VCF.
    inputBinding:
      position: 101
      prefix: --strip_info
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Tile size for ancestry fraction inference (bp)
    inputBinding:
      position: 101
      prefix: --tile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntroot:1.1.6--py313pl5321hdfd78af_0
stdout: ntroot.out
