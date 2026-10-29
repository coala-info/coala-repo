cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - intrahost.py
  - merge_to_vcf
label: viral-ngs_intrahost_merge_to_vcf
doc: "Combine and convert vPhaser2 parsed filtered output text files into VCF format. Assumption: consensus assemblies used in creating alignments do not extend beyond ends of reference. the number of alignment files equals the number of chromosomes / segments\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: ref_fasta
    type: File
    doc: "The target reference genome. outVcf will use these chromosome names, coordinate spaces, and reference alleles"
    inputBinding:
      position: 1
  - id: out_vcf
    type: string
    doc: "Output VCF file containing all variants"
    inputBinding:
      position: 2
  - id: samples
    type:
      type: array
      items: string
    doc: "A list of sample names"
    inputBinding:
      position: 30
      prefix: --samples
  - id: isnvs
    type:
      type: array
      items: File
    doc: "A list of file names from the output of vphaser_one_sample These must be in the SAME ORDER as samples."
    inputBinding:
      position: 30
      prefix: --isnvs
  - id: alignments
    type:
      type: array
      items: File
    doc: "a list of fasta files containing multialignment of input assemblies, with one file per chromosome/segment. Each alignment file will contain a line for each sample, as well as the reference genome to which they were aligned."
    inputBinding:
      position: 30
      prefix: --alignments
  - id: strip_chr_version
    type:
      - 'null'
      - boolean
    doc: "If set, strip any trailing version numbers from the chromosome names. If the chromosome name ends with a period followed by integers, this is interepreted as a version number to be removed. This is because Genbank accession numbers are often used by SnpEff databases downstream, but without the corresponding version number. Default is false (leave chromosome names untouched)."
    inputBinding:
      position: 20
      prefix: --strip_chr_version
  - id: naive_filter
    type:
      - 'null'
      - boolean
    doc: "If set, keep only the alleles that have at least two independent libraries of support and allele freq > 0.005. Default is false (do not filter at this stage)."
    inputBinding:
      position: 20
      prefix: --naive_filter
  - id: parse_accession
    type:
      - 'null'
      - boolean
    doc: "If set, parse only the accession for the chromosome name. Helpful if snpEff has to create its own database"
    inputBinding:
      position: 20
      prefix: --parse_accession
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: out_vcf_file
    type: File
    doc: "Output file written to out_vcf"
    outputBinding:
      glob: $(inputs.out_vcf)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
