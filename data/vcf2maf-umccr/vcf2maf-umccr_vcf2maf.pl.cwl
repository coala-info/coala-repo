cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl vcf2maf-umccr_vcf2maf.pl
label: vcf2maf-umccr_vcf2maf.pl
doc: "Converts VCF files to MAF format.\n\nTool homepage: https://github.com/umccr/vcf2maf/"
inputs:
  - id: cache_version
    type:
      - 'null'
      - int
    doc: Version of offline cache to use with VEP (e.g. 75, 91, 102)
    inputBinding:
      position: 101
      prefix: --cache-version
  - id: input_vcf
    type: File
    doc: Path to input file in VCF format
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: ncbi_build
    type:
      - 'null'
      - string
    doc: NCBI reference assembly of variants MAF (e.g. GRCm38 for mouse)
    default: GRCh37
    inputBinding:
      position: 101
      prefix: --ncbi-build
  - id: normal_id
    type: string
    doc: Matched_Norm_Sample_Barcode to report in the MAF
    default: NORMAL
    inputBinding:
      position: 101
      prefix: --normal-id
  - id: online
    type:
      - 'null'
      - boolean
    doc: Use useastdb.ensembl.org instead of local cache (supports only GRCh38 
      VCFs listing <100 events)
    inputBinding:
      position: 101
      prefix: --online
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA file
    default: 
      ~/.vep/homo_sapiens/102_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: remap_chain
    type:
      - 'null'
      - File
    doc: Chain file to remap variants to a different assembly before running VEP
    inputBinding:
      position: 101
      prefix: --remap-chain
  - id: species
    type:
      - 'null'
      - string
    doc: Ensembl-friendly name of species (e.g. mus_musculus for mouse)
    default: homo_sapiens
    inputBinding:
      position: 101
      prefix: --species
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Folder to retain intermediate VCFs after runtime
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: tumor_id
    type: string
    doc: Tumor_Sample_Barcode to report in the MAF
    default: TUMOR
    inputBinding:
      position: 101
      prefix: --tumor-id
  - id: vcf_normal_id
    type:
      - 'null'
      - string
    doc: Matched normal ID used in VCF's genotype columns
    inputBinding:
      position: 101
      prefix: --vcf-normal-id
  - id: vcf_tumor_id
    type:
      - 'null'
      - string
    doc: Tumor sample ID used in VCF's genotype columns
    inputBinding:
      position: 101
      prefix: --vcf-tumor-id
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more things to STDERR to log progress
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_maf
    type: File
    doc: Path to output MAF file
    outputBinding:
      glob: $(inputs.output_maf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf-umccr:1.6.21.20230511--hdfd78af_0
