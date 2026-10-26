cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2maf.pl
label: vcf2maf_vcf2maf.pl
doc: "Converts VCF files to MAF format.\n\nTool homepage: https://github.com/mskcc/vcf2maf"
inputs:
  - id: cache_version
    type:
      - 'null'
      - int
    doc: Version of offline cache to use with VEP (e.g. 75, 91, 112)
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
    inputBinding:
      position: 101
      prefix: --ncbi-build
  - id: normal_id
    type: string
    doc: Matched_Norm_Sample_Barcode to report in the MAF
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
      ~/.vep/homo_sapiens/112_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz
    secondaryFiles:
      - .fai
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
  - id: any_allele
    type:
      - 'null'
      - boolean
    doc: When reporting co-located variants, allow mismatched variant alleles too
    inputBinding:
      position: 101
      prefix: --any-allele
  - id: min_hom_vaf
    type:
      - 'null'
      - float
    doc: If GT undefined in VCF, minimum allele fraction to call a variant homozygous
    inputBinding:
      position: 101
      prefix: --min-hom-vaf
  - id: maf_center
    type:
      - 'null'
      - string
    doc: Variant calling center to report in MAF
    inputBinding:
      position: 101
      prefix: --maf-center
  - id: custom_enst
    type:
      - 'null'
      - string
    doc: Comma-delimited list of custom ENST IDs that override canonical selection
    inputBinding:
      position: 101
      prefix: --custom-enst
  - id: retain_info
    type:
      - 'null'
      - string
    doc: Comma-delimited names of INFO fields to retain as extra columns in MAF
    inputBinding:
      position: 101
      prefix: --retain-info
  - id: retain_fmt
    type:
      - 'null'
      - string
    doc: Comma-delimited names of FORMAT fields to retain as extra columns in MAF
    inputBinding:
      position: 101
      prefix: --retain-fmt
  - id: retain_ann
    type:
      - 'null'
      - string
    doc: Comma-delimited names of VEP annotations (within the VEP CSQ/ANN) to retain as extra columns in MAF
    inputBinding:
      position: 101
      prefix: --retain-ann
  - id: vep_custom
    type:
      - 'null'
      - string
    doc: String to pass into VEP's --custom option
    inputBinding:
      position: 101
      prefix: --vep-custom
  - id: vep_config
    type:
      - 'null'
      - File
    doc: VEP config file to pass into vep's --config option
    inputBinding:
      position: 101
      prefix: --vep-config
  - id: inhibit_vep
    type:
      - 'null'
      - boolean
    doc: Skip running VEP, but extract VEP annotation in VCF if found
    inputBinding:
      position: 101
      prefix: --inhibit-vep
  - id: vep_path
    type:
      - 'null'
      - string
    doc: Folder containing the vep script
    inputBinding:
      position: 101
      prefix: --vep-path
  - id: vep_data
    type:
      - 'null'
      - Directory
    doc: VEP's base cache/plugin directory
    inputBinding:
      position: 101
      prefix: --vep-data
  - id: vep_forks
    type:
      - 'null'
      - int
    doc: Number of forked processes to use when running VEP
    inputBinding:
      position: 101
      prefix: --vep-forks
  - id: vep_overwrite
    type:
      - 'null'
      - boolean
    doc: Allow VEP to overwrite annotated output (if it exists)
    inputBinding:
      position: 101
      prefix: --vep-overwrite
  - id: vep_stats
    type:
      - 'null'
      - boolean
    doc: Allow VEP to generate stats (slower, disabled by default)
    inputBinding:
      position: 101
      prefix: --vep-stats
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Number of variants VEP loads at a time; reduce this for low memory systems
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: samtools_exec
    type:
      - 'null'
      - string
    doc: Path to the samtools executable
    inputBinding:
      position: 101
      prefix: --samtools-exec
  - id: tabix_exec
    type:
      - 'null'
      - string
    doc: Path to the tabix executable
    inputBinding:
      position: 101
      prefix: --tabix-exec
  - id: liftover_exec
    type:
      - 'null'
      - string
    doc: Path to the liftover executable
    inputBinding:
      position: 101
      prefix: --liftover-exec
  - id: output_maf_path
    type: string
    inputBinding:
      position: 102
      prefix: --output-maf
outputs:
  - id: output_maf
    type: File
    doc: Path to output MAF file
    outputBinding:
      glob: $(inputs.output_maf_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input_vcf.basename)
        entry: $(inputs.input_vcf)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf:1.6.22--hdfd78af_2
