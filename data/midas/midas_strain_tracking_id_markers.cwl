cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strain_tracking.py
  - id_markers
label: midas_strain_tracking_id_markers
doc: "Identify rare SNPs that discriminate individual strains.\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs:
  - id: indir
    type: Directory
    doc: Path to input snps directory for one species (contains files 'snps_*.txt'); requires having run
      merge_midas.py snps.
    inputBinding:
      position: 101
      prefix: --indir
  - id: out
    type: string
    doc: Path to output file.
    inputBinding:
      position: 101
      prefix: --out
  - id: samples
    type:
      - 'null'
      - string
    doc: Comma-separated list of training samples; by default, all samples are used.
    inputBinding:
      position: 101
      prefix: --samples
  - id: min_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency (proportion of reads) per site for SNP calling (0.10).
    inputBinding:
      position: 101
      prefix: --min_freq
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads supporting allele per site for SNP calling (3).
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: allele_prev
    type:
      - 'null'
      - int
    doc: Maximum occurrences of allele across samples (1).
    inputBinding:
      position: 101
      prefix: --allele_prev
  - id: max_sites
    type:
      - 'null'
      - int
    doc: Maximum number of genomic sites to process (use all). Useful for quick tests.
    inputBinding:
      position: 101
      prefix: --max_sites
outputs:
  - id: out_file
    type: File
    doc: List of marker alleles.
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
