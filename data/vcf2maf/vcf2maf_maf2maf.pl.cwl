cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl maf2maf.pl
label: vcf2maf_maf2maf.pl
doc: "Converts MAF files to a VEP-annotated MAF.\n\nTool homepage: https://github.com/mskcc/vcf2maf"
inputs:
  - id: any_allele
    type:
      - 'null'
      - boolean
    doc: When reporting co-located variants, allow mismatched variant alleles 
      too
    inputBinding:
      position: 101
      prefix: --any-allele
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Number of variants VEP loads at a time; Reduce this for low memory 
      systems
    default: 5000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: cache_version
    type:
      - 'null'
      - string
    doc: Version of offline cache to use with VEP (e.g. 75, 84, 91)
    default: Installed version
    inputBinding:
      position: 101
      prefix: --cache-version
  - id: custom_enst
    type:
      - 'null'
      - type: array
        items: string
    doc: List of custom ENST IDs that override canonical selection
    inputBinding:
      position: 101
      prefix: --custom-enst
  - id: input_maf
    type: File
    doc: Path to input file in MAF format
    inputBinding:
      position: 101
      prefix: --input-maf
  - id: max_subpop_af
    type:
      - 'null'
      - float
    doc: Add FILTER tag common_variant if gnomAD reports any subpopulation AFs 
      greater than this
    default: 0.0004
    inputBinding:
      position: 101
      prefix: --max-subpop-af
  - id: ncbi_build
    type:
      - 'null'
      - string
    doc: NCBI reference assembly of variants in MAF (e.g. GRCm38 for mouse)
    default: GRCh37
    inputBinding:
      position: 101
      prefix: --ncbi-build
  - id: nrm_depth_col
    type:
      - 'null'
      - string
    doc: Name of MAF column for read depth in normal BAM
    default: n_depth
    inputBinding:
      position: 101
      prefix: --nrm-depth-col
  - id: nrm_rad_col
    type:
      - 'null'
      - string
    doc: Name of MAF column for reference allele depth in normal BAM
    default: n_ref_count
    inputBinding:
      position: 101
      prefix: --nrm-rad-col
  - id: nrm_vad_col
    type:
      - 'null'
      - string
    doc: Name of MAF column for variant allele depth in normal BAM
    default: n_alt_count
    inputBinding:
      position: 101
      prefix: --nrm-vad-col
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA file
    default: 
      ~/.vep/homo_sapiens/112_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: retain_cols
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-delimited list of columns to retain from the input MAF
    default: 
      Center,Verification_Status,Validation_Status,Mutation_Status,Sequencing_Phase,Sequence_Source,Validation_Method,Score,BAM_file,Sequencer,Tumor_Sample_UUID,Matched_Norm_Sample_UUID
    inputBinding:
      position: 101
      prefix: --retain-cols
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
    doc: Folder to retain intermediate VCFs/MAFs after runtime
    default: usually /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: tum_depth_col
    type:
      - 'null'
      - string
    doc: Name of MAF column for read depth in tumor BAM
    default: t_depth
    inputBinding:
      position: 101
      prefix: --tum-depth-col
  - id: tum_rad_col
    type:
      - 'null'
      - string
    doc: Name of MAF column for reference allele depth in tumor BAM
    default: t_ref_count
    inputBinding:
      position: 101
      prefix: --tum-rad-col
  - id: tum_vad_col
    type:
      - 'null'
      - string
    doc: Name of MAF column for variant allele depth in tumor BAM
    default: t_alt_count
    inputBinding:
      position: 101
      prefix: --tum-vad-col
  - id: vep_data
    type:
      - 'null'
      - Directory
    doc: VEP's base cache/plugin directory
    default: ~/.vep
    inputBinding:
      position: 101
      prefix: --vep-data
  - id: vep_forks
    type:
      - 'null'
      - int
    doc: Number of forked processes to use when running VEP
    default: 4
    inputBinding:
      position: 101
      prefix: --vep-forks
  - id: vep_path
    type:
      - 'null'
      - Directory
    doc: Folder containing the vep script
    default: ~/miniconda3/bin
    inputBinding:
      position: 101
      prefix: --vep-path
outputs:
  - id: output_maf
    type:
      - 'null'
      - File
    doc: Path to output MAF file
    outputBinding:
      glob: $(inputs.output_maf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf:1.6.22--hdfd78af_2
