# vcf2maf-umccr CWL Generation Report

## vcf2maf-umccr_vcf2maf.pl

### Tool Description
Converts VCF files to MAF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf2maf-umccr:1.6.21.20230511--hdfd78af_0
- **Homepage**: https://github.com/umccr/vcf2maf/
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf2maf-umccr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf2maf-umccr/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/umccr/vcf2maf
- **Stars**: N/A
### Original Help Text
```text
Usage:
     perl vcf2maf.pl --help

     perl vcf2maf.pl --input-vcf INPUT.vcf --output-maf OUTPUT.maf --tumor-id TUMOR_ID --normal-id NORMAL_ID

Options:
    --help  Print a basic help message

    --verbose
            Print more things to STDERR to log progress

    --input-vcf=INPUT_VCF
            Path to input file in VCF format

    --output-maf=OUTPUT_VCF
            Path to output MAF file

    --tmp-dir=TMP_DIR
            Folder to retain intermediate VCFs after runtime [Default:
            Folder containing input VCF]

    --tumor-id=TUMOR_ID
            Tumor_Sample_Barcode to report in the MAF [TUMOR]

    --normal-id=NORMAL_ID
            Matched_Norm_Sample_Barcode to report in the MAF [NORMAL]

    --vcf-tumor-id=TUMOR_ID
            Tumor sample ID used in VCF's genotype columns [--tumor-id]

    --vcf-normal-id=NORMAL_ID
            Matched normal ID used in VCF's genotype columns [--normal-id]

    --online
            Use useastdb.ensembl.org instead of local cache (supports only
            GRCh38 VCFs listing <100 events)

    --ref-fasta=FASTA
            Reference FASTA file
            [~/.vep/homo_sapiens/102_GRCh37/Homo_sapiens.GRCh37.dna.toplevel
            .fa.gz]

    --species=SPECIES
            Ensembl-friendly name of species (e.g. mus_musculus for mouse)
            [homo_sapiens]

    --ncbi-build=ASSEMBLY
            NCBI reference assembly of variants MAF (e.g. GRCm38 for mouse)
            [GRCh37]

    --cache-version=N
            Version of offline cache to use with VEP (e.g. 75, 91, 102)
            [Default: Installed version]

    --remap-chain=REMAP_CHAIN
            Chain file to remap variants to a different assembly before
            running VEP

    --man   Print the detailed manual with advanced options
```


## vcf2maf-umccr_maf2maf.pl

### Tool Description
Converts MAF files to a VEP-compatible MAF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf2maf-umccr:1.6.21.20230511--hdfd78af_0
- **Homepage**: https://github.com/umccr/vcf2maf/
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf2maf-umccr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
     perl maf2maf.pl --help
     perl maf2maf.pl --input-maf test.maf --output-maf test.vep.maf

Options:
     --input-maf      Path to input file in MAF format
     --output-maf     Path to output MAF file [Default: STDOUT]
     --tmp-dir        Folder to retain intermediate VCFs/MAFs after runtime [Default: usually /tmp]
     --tum-depth-col  Name of MAF column for read depth in tumor BAM [t_depth]
     --tum-rad-col    Name of MAF column for reference allele depth in tumor BAM [t_ref_count]
     --tum-vad-col    Name of MAF column for variant allele depth in tumor BAM [t_alt_count]
     --nrm-depth-col  Name of MAF column for read depth in normal BAM [n_depth]
     --nrm-rad-col    Name of MAF column for reference allele depth in normal BAM [n_ref_count]
     --nrm-vad-col    Name of MAF column for variant allele depth in normal BAM [n_alt_count]
     --retain-cols    Comma-delimited list of columns to retain from the input MAF [Center,Verification_Status,Validation_Status,Mutation_Status,Sequencing_Phase,Sequence_Source,Validation_Method,Score,BAM_file,Sequencer,Tumor_Sample_UUID,Matched_Norm_Sample_UUID]
     --custom-enst    List of custom ENST IDs that override canonical selection
     --vep-path       Folder containing the vep script [~/miniconda3/bin]
     --vep-data       VEP's base cache/plugin directory [~/.vep]
     --vep-forks      Number of forked processes to use when running VEP [4]
     --buffer-size    Number of variants VEP loads at a time; Reduce this for low memory systems [5000]
     --any-allele     When reporting co-located variants, allow mismatched variant alleles too
     --max-subpop-af  Add FILTER tag common_variant if gnomAD reports any subpopulation AFs greater than this [0.0004]
     --species        Ensembl-friendly name of species (e.g. mus_musculus for mouse) [homo_sapiens]
     --ncbi-build     NCBI reference assembly of variants in MAF (e.g. GRCm38 for mouse) [GRCh37]
     --cache-version  Version of offline cache to use with VEP (e.g. 75, 84, 91) [Default: Installed version]
     --ref-fasta      Reference FASTA file [~/.vep/homo_sapiens/102_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz]
     --help           Print a brief help message and quit
     --man            Print the detailed manual
```

