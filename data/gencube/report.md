# gencube CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gencube_annotation | PASS | search and metadata mode checked on real NCBI records; downloads not tested because NCBI FTP times out inside the Docker bridge network on this machine. |
| gencube_crossgenome | PASS | search and metadata mode checked on real NCBI records; downloads not tested because NCBI FTP times out inside the Docker bridge network on this machine. |
| gencube_geneset | Not completed | needs NCBI FTP, which times out inside the Docker bridge network on this machine (works with host network) |
| gencube_genome | PASS | search and metadata mode checked on real NCBI records; downloads not tested because NCBI FTP times out inside the Docker bridge network on this machine. |
| gencube_seqmeta | PASS |  |
| gencube_sequence | Not completed | needs NCBI FTP, which times out inside the Docker bridge network on this machine (works with host network) |

## gencube_genome

### Tool Description
Search, download, and modify chromosome labels for genome assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
- **Homepage**: https://github.com/snu-cdrc/gencube
- **Package**: https://anaconda.org/channels/bioconda/packages/gencube/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gencube genome [-h] [-v level] [-r] [-u] [-l] [-m] [-d] [-db types]
                      [-c type] [-mk type] [-cl 1-9] [--recursive]
                      [keywords ...]

Search, download, and modify chromosome labels for genome assemblies

positional arguments:
  keywords              Taxonomic names to search for genomes
                        You can provide various forms such as species names or accession numbers
                        Examples: homo_sapiens, human, GCF_000001405.40, GCA_000001405.29, GRCh38, hg38
                        
                        Multiple names can be combined and will be merged in the search results
                        To specify multiple names, separate them with spaces

options:
  -h, --help            show this help message and exit
  -v level, --level level
                        Specify the genome assembly level (default: complete,chromosome)
                        complete   : Fully assembled genomes
                        chromosome : Assembled at the chromosome level
                        scaffold   : Assembled into scaffolds, but not to the chromosome level
                        contig     : Contiguous sequences without gaps
                        
  -r, --refseq          Show genomes that have RefSeq accession (GCF_* format)
  -u, --ucsc            Show genomes that have UCSC name
  -l, --latest          Show genomes corresponding to the latest version
  -m, --metadata        Save metadata for the searched genomes
  -d, --download        Download "fasta" formatted genome file
  -db types, --database types
                        Database where genome file is downloaded (default: refseq)
                        Default is from the RefSeq database
                        If not available, download from the GenBank database
                        genbank : by NCBI GenBank
                        refseq  : by NCBI RefSeq
                        genark  : by UCSC GenArk
                        ensembl : by Ensembl Beta
  -c type, --chr_style type
                        Chromosome label style used in the download file (default: ensembl)
                        ensembl : 1, 2, X, MT & unknowns (GenBank IDs)
                        gencode : chr1, chr2, chrX, chrM & unknowns (GenBank IDs)
                        ucsc    : chr1, chr2, chrX, chrM & unknowns (UCSC-specific IDs)
                                  !! Limited use if UCSC IDs are not issued
                        raw     : Uses raw file labels without modification
                                 - NCBI GenBank: CM_* or other-form IDs
                                 - NCBI RefSeq : NC_*, NW_* or other-form IDs
                                 - GenArk      : GenBank or RefSeq IDs
                                 - Ensembl     : Ensembl IDs
  -mk type, --masking type
                        Masking type for output data (default: soft)
                        soft : soft-masked
                        hard : hard-masked
                        none : unmasked
  -cl 1-9, --compresslevel 1-9
                        Compression level for output data (default: 6)
                        Lower numbers are faster but have lower compression
                         
  --recursive           Download files regardless of their presence only if integrity check is not possible
```

## gencube_geneset

### Tool Description
Search, download, and modify chromosome labels for genesets (gene annotations).

### Metadata
- **Docker Image**: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
- **Homepage**: https://github.com/snu-cdrc/gencube
- **Package**: https://anaconda.org/channels/bioconda/packages/gencube/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gencube geneset [-h] [-v level] [-r] [-u] [-l] [-m] [-d types]
                       [-c type] [--recursive]
                       [keywords ...]

Search, download, and modify chromosome labels for genesets (gene annotations)

positional arguments:
  keywords              Taxonomic names to search for genomes
                        You can provide various forms such as species names or accession numbers
                        Examples: homo_sapiens, human, GCF_000001405.40, GCA_000001405.29, GRCh38, hg38
                        
                        Multiple names can be combined and will be merged in the search results
                        To specify multiple names, separate them with spaces

options:
  -h, --help            show this help message and exit
  -v level, --level level
                        Specify the genome assembly level (default: complete,chromosome)
                        complete   : Fully assembled genomes
                        chromosome : Assembled at the chromosome level
                        scaffold   : Assembled into scaffolds, but not to the chromosome level
                        contig     : Contiguous sequences without gaps
                        
  -r, --refseq          Show genomes that have RefSeq accession (GCF_* format)
  -u, --ucsc            Show genomes that have UCSC name
  -l, --latest          Show genomes corresponding to the latest version
  -m, --metadata        Save metadata for the searched genesets
  -d types, --download types
                        Type of gene set
                        refseq_gtf    : RefSeq gene set (GTF format)
                        refseq_gff    : RefSeq gene set (GFF)
                        gnomon        : RefSeq Gnomon gene prediction (GFF)
                        cross         : RefSeq Cross-species alignments (GFF)
                        same          : RefSeq Same-species alignments (GFF)
                        augustus      : GenArk Augustus gene prediction (GFF)
                        xenoref       : GenArk XenoRefGene (GFF)
                        genark_ref    : GenArk RefSeq gene models (GFF)
                        ensembl_gtf   : Ensembl Beta gene set (GTF)
                        ensembl_gff   : Ensembl Beta gene set (GFF)
                        toga_gtf      : Zoonomia TOGA gene set (GTF)
                        toga_bed      : Zoonomia TOGA gene set (BED)
                        toga_pseudo   : Zoonomia TOGA processed pseudogenes (BED)
  -c type, --chr_style type
                        Chromosome label style used in the download file (default: ensembl)
                        ensembl : 1, 2, X, MT & unknowns (GenBank IDs)
                        gencode : chr1, chr2, chrX, chrM & unknowns (GenBank IDs)
                        ucsc    : chr1, chr2, chrX, chrM & unknowns (UCSC-specific IDs)
                                  !! Limited use if UCSC IDs are not issued
                        raw     : Uses raw file labels without modification
                                 - NCBI GenBank: CM_* or other-form IDs
                                 - NCBI RefSeq : NC_*, NW_* or other-form IDs
                                 - GenArk      : GenBank or RefSeq IDs
                                 - Ensembl     : Ensembl IDs
                         
  --recursive           Download files regardless of their presence only if integrity check is not possible
```

## gencube_annotation

### Tool Description
Search, download, and modify chromosome labels for various genome annotations, such as gaps and repeats.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
- **Homepage**: https://github.com/snu-cdrc/gencube
- **Package**: https://anaconda.org/channels/bioconda/packages/gencube/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gencube annotation [-h] [-v level] [-r] [-u] [-l] [-m] [-d types]
                          [-c type] [--recursive]
                          [keywords ...]

Search, download, and modify chromosome labels for various genome annotations, such as gaps and repeats

positional arguments:
  keywords              Taxonomic names to search for genomes
                        You can provide various forms such as species names or accession numbers
                        Examples: homo_sapiens, human, GCF_000001405.40, GCA_000001405.29, GRCh38, hg38
                        
                        Multiple names can be combined and will be merged in the search results
                        To specify multiple names, separate them with spaces

options:
  -h, --help            show this help message and exit
  -v level, --level level
                        Specify the genome assembly level (default: complete,chromosome)
                        complete   : Fully assembled genomes
                        chromosome : Assembled at the chromosome level
                        scaffold   : Assembled into scaffolds, but not to the chromosome level
                        contig     : Contiguous sequences without gaps
                        
  -r, --refseq          Show genomes that have RefSeq accession (GCF_* format)
  -u, --ucsc            Show genomes that have UCSC name
  -l, --latest          Show genomes corresponding to the latest version
  -m, --metadata        Save metadata for the searched annotations
  -d types, --download types
                        Download annotation file.
                        gap : Genomic gaps - AGP defined (bigBed format)
                        sr   : Simple tandem repeats by TRF (bigBed)
                        td   : Tandem duplications (bigBed)
                        wm   : Genomic intervals masked by WindowMasker + SDust (bigBed)
                        rmsk : Repeated elements annotated by RepeatMasker (bigBed)
                        cpg  : CpG Islands - Islands < 300 bases are light green (bigBed)
                        gc   : GC percent in 5-Base window (bigWig)
  -c type, --chr_style type
                        Chromosome label style used in the download file (default: ensembl)
                        ensembl : 1, 2, X, MT & unknowns (GenBank IDs)
                        gencode : chr1, chr2, chrX, chrM & unknowns (GenBank IDs)
                        ucsc    : chr1, chr2, chrX, chrM & unknowns (UCSC-specific IDs)
                                  !! Limited use if UCSC IDs are not issued
                        raw     : Uses raw file labels without modification
                                 - NCBI GenBank: CM_* or other-form IDs
                                 - NCBI RefSeq : NC_*, NW_* or other-form IDs
                                 - GenArk      : GenBank or RefSeq IDs
                                 - Ensembl     : Ensembl IDs
                         
  --recursive           Download files regardless of their presence only if integrity check is not possible
```

## gencube_sequence

### Tool Description
Search and download sequence data of genesets.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
- **Homepage**: https://github.com/snu-cdrc/gencube
- **Package**: https://anaconda.org/channels/bioconda/packages/gencube/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gencube sequence [-h] [-v level] [-r] [-u] [-l] [-m] [-d types]
                        [--recursive]
                        [keywords ...]

Search and download sequence data of genesets

positional arguments:
  keywords              Taxonomic names to search for genomes
                        You can provide various forms such as species names or accession numbers
                        Examples: homo_sapiens, human, GCF_000001405.40, GCA_000001405.29, GRCh38, hg38
                        
                        Multiple names can be combined and will be merged in the search results
                        To specify multiple names, separate them with spaces

options:
  -h, --help            show this help message and exit
  -v level, --level level
                        Specify the genome assembly level (default: complete,chromosome)
                        complete   : Fully assembled genomes
                        chromosome : Assembled at the chromosome level
                        scaffold   : Assembled into scaffolds, but not to the chromosome level
                        contig     : Contiguous sequences without gaps
                        
  -r, --refseq          Show genomes that have RefSeq accession (GCF_* format)
  -u, --ucsc            Show genomes that have UCSC name
  -l, --latest          Show genomes corresponding to the latest version
  -m, --metadata        Save metadata for the searched sequence data
  -d types, --download types
                        Download "fasta" formatted sequence file
                        1. Nucleotide sequences:
                           refseq_rna         : Accessioned RNA sequences annotated on the genome assembly
                           refseq_rna_genomic : RNA features based on the genome sequence
                           refseq_cds_genomic : CDS features based on the genome sequence
                           refseq_pseudo      : Pseudogene and other gene regions without transcribed RNA or translated protein products
                           ensembl_cdna       : Ensembl Beta cDNA sequences of transcripts
                        2. Protein sequences:
                           refseq_pep         : Accessioned protein sequences annotated on the genome assembly
                           refseq_pep_cds     : CDS features translated into protein sequences
                           ensembl_pep        : Ensembl Beta protein sequences
                         
  --recursive           Download files regardless of their presence only if integrity check is not possible
```

## gencube_crossgenome

### Tool Description
Search and download comparative genomics data, such as homology, and codon or protein alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
- **Homepage**: https://github.com/snu-cdrc/gencube
- **Package**: https://anaconda.org/channels/bioconda/packages/gencube/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gencube crossgenome [-h] [-v level] [-r] [-u] [-l] [-m] [-d types]
                           [--recursive]
                           [keywords ...]

Search and download comparative genomics data, such as homology, and codon or protein alignments

positional arguments:
  keywords              Taxonomic names to search for genomes
                        You can provide various forms such as species names or accession numbers
                        Examples: homo_sapiens, human, GCF_000001405.40, GCA_000001405.29, GRCh38, hg38
                        
                        Multiple names can be combined and will be merged in the search results
                        To specify multiple names, separate them with spaces

options:
  -h, --help            show this help message and exit
  -v level, --level level
                        Specify the genome assembly level (default: complete,chromosome)
                        complete   : Fully assembled genomes
                        chromosome : Assembled at the chromosome level
                        scaffold   : Assembled into scaffolds, but not to the chromosome level
                        contig     : Contiguous sequences without gaps
                        
  -r, --refseq          Show genomes that have RefSeq accession (GCF_* format)
  -u, --ucsc            Show genomes that have UCSC name
  -l, --latest          Show genomes corresponding to the latest version
  -m, --metadata        Save metadata for the searched comparative genomics data
  -d types, --download types
                        ensembl_homology   : Homology data from Ensembl Beta,
                                             detailing gene orthology relationships across species
                        toga_homology      : Homology data from TOGA, providing predictions of
                                             orthologous genes based on genome alignments
                        toga_align_codon   : Codon alignment data from TOGA, showing aligned codon
                                             sequences between reference and query species
                        toga_align_protein : Protein alignment data from TOGA, detailing aligned
                                             protein sequences between reference and query species
                        toga_inact_mut     : List of inactivating mutations from TOGA, identifying
                                             mutations that disrupt gene function
                         
  --recursive           Download files regardless of their presence only if integrity check is not possible
```

## gencube_seqmeta

### Tool Description
Search, retrieve, and integrate metadata of experimental sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
- **Homepage**: https://github.com/snu-cdrc/gencube
- **Package**: https://anaconda.org/channels/bioconda/packages/gencube/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gencube seqmeta [-h] [-o string] [-st string] [-sr string] [-pl string]
                       [-sl string] [-fi string] [-pr string] [-ly string]
                       [-ac string] [-bp string] [-bs string] [-as string]
                       [-ti string] [-at string] [-pd range] [-md range]
                       [-rl range] [-mb string] [-tw string] [-ex keywords]
                       [-d] [-m] [-u]
                       [keywords ...]

Search, retrive, and integrate metadata of experimental sequencing data

positional arguments:
  keywords              Keywords to search for sequencing-based experimental data. You can provide various forms
                        Examples: liver, k562, cancer, breast_cancer, etc
                        
                        Multiple keywords can be combined
                        Keywords separated by commas will combine their results
                        Keywords separated by spaces will intersect their results
                        Example: liver,lung cancer,tumor

options:
  -h, --help            show this help message and exit
  -o string, --organism string
                        Scientific name or common name (as found in the NCBI Taxonomy Browser)
                        Example: homo_sapiens or human
  -st string, --strategy string
                        Sequencing strategy:
                        16s_rrna_seq, amplicon, atac_seq, bisulfite_seq, chia_pet, chip, chip_seq, clone, cloneend, cts
                        dip_seq, dnase_hypersensitivity, est, faire_seq, finishing, fl_cdna, gbs, hi_c, inverse_rrna
                        mbd_seq, medip_seq, mirna_seq, mnase_seq, mre_seq, ncrna_seq, nome_seq, other, poolclone, rad_seq
                        ribo_seq, rip_seq, rna_seq, selex, ssrna_seq, synthetic_long_read, targeted_capture
                        tethered_chromatin_conformation_capture, tn_seq, validation, wcs, wga, wgs, wxs
  -sr string, --source string
                        Source of the biological data:
                        genomic, genomic_single_cell, metagenomic, metatranscriptomic, other, synthetic, transcriptomic
                        transcriptomic_single_cell, viral_rna
  -pl string, --platform string
                        Name of the sequencing platform:
                        abi_solid, amcare, bgiseq, capillary, complete_genomics, dnbseq, element, genapsys, genemind
                        geneus_tech, helicos, illumina, ion_torrent, ls454, oxford_nanopore, pacbio_smrt, qitan_tech, salus
                        singular_genomics, tapestri, ultima, vela_diagnostics
  -sl string, --selection string
                        Library selection methodology:
                        5_methylcytidine_antibody, cage, cdna, cdna_oligo_dt, cdna_randompriming, chip, chip_seq, dnase
                        hmpr, hybrid_selection, inverse_rrna, mbd2_protein_methyl_cpg_binding_domain, mda, mf, mnase, msll
                        oligo_dt, other, padlock_probes_capture_method, pcr, polya, race, random, random_pcr
                        reduced_representation, repeat_fractionation, restriction_digest, rt_pcr, size_fractionation
                        unspecified
  -fi string, --filter string
                        Option to find SRA records that are cross-referenced with other NCBI databases
                        (PubMed, PubMed Central (PMC), Nucleotide, Assembly, and others):
                        abi_solid, all, cloud_gs, cloud_s3, dna_data, filetype_bai, filetype_bam, filetype_crai
                        filetype_cram, filetype_fastq, filetype_illumina_native, filetype_pacbio_hdf5, filetype_sff
                        filetype_srf, genomic, library_layout_paired, library_layout_single, metagenomic, metatranscriptomic
                        other, platform_abi_solid, platform_bgiseq, platform_capillary, platform_complete_genomics
                        platform_helicos, platform_illumina, platform_ion_torrent, platform_ls454, platform_oxford_nanopore
                        platform_pacbio_smrt, rna_data, sra_all, sra_assembly, sra_bioproject, sra_bioproject_all
                        sra_biosample, sra_gap, sra_gap_all, sra_gds, sra_genome, sra_nuccore, sra_nuccore_alignment
                        sra_nuccore_wgs, sra_omim, sra_pmc, sra_public, sra_pubmed, sra_taxonomy, strategy_amplicon
                        strategy_atac_seq, strategy_bisulfite_seq, strategy_chia_pet, strategy_chip, strategy_chip_seq
                        strategy_chromosome_immunoprecipitation, strategy_clone, strategy_cloneend, strategy_cts
                        strategy_dnase_hypersensitivity, strategy_epigenomic, strategy_est, strategy_exome
                        strategy_faire_seq, strategy_finishing, strategy_fl_cdna, strategy_full_length_cdna, strategy_genome
                        strategy_hi_c, strategy_ip, strategy_medip_seq, strategy_mirna_seq, strategy_mnase_seq
                        strategy_mre_seq, strategy_ncrna_seq, strategy_other, strategy_other_other, strategy_poolclone
                        strategy_rad_seq, strategy_rip_seq, strategy_rna_seq, strategy_rnaseq, strategy_selex
                        strategy_synthetic_long_read, strategy_targeted_capture, strategy_tn_seq, strategy_validation
                        strategy_wcs, strategy_wes, strategy_wga, strategy_wgs, strategy_whole_exome_sequencing
                        strategy_whole_genome_amplification, strategy_whole_genome_sequencing, strategy_wxs, synthetic
                        transcriptomic, type_exome, type_genome, type_rnaseq, viral_rna
  -pr string, --properties string
                        Option to narrow search results by controlled-vocabulary library's annotations:
                        aligned_data, biomol_dna, biomol_rna, biomol_transcript, cloud_gs, cloud_s3, cluster_dbgap
                        cluster_public, filetype_10x_genomics_bam_file, filetype_ab1, filetype_activ_sars2_vcf
                        filetype_archive/gzip, filetype_assembled_contigs, filetype_assembly/realign_summary
                        filetype_assembly_of_undentified_reads, filetype_bai, filetype_bam, filetype_bam_header
                        filetype_basemodification, filetype_complete_genomics, filetype_covid19_variation_vcf, filetype_crai
                        filetype_cram, filetype_fasta, filetype_fastq, filetype_geo_feature_count, filetype_helicos
                        filetype_illumina_native, filetype_nanopore, filetype_pacbio_base_modification_report
                        filetype_pacbio_hdf5, filetype_pacbio_metadata, filetype_pacbio_native
                        filetype_realign_to_de_novo_assembly, filetype_reference_fasta, filetype_run, filetype_run_realign
                        filetype_run_zq, filetype_sff, filetype_solid_native, filetype_source, filetype_sra_lite
                        filetype_sra_normalized, filetype_srf, filetype_tar_archive_of_complete_genomics_tree, filetype_tenx
                        filetype_vcf, filetype_vcf_index, filetype_vdbcache, filetype_vdbcache_zq, filetype_wgmlst_sig
                        filetype_wgmlst_signature, has_data, instrument_454_gs, instrument_454_gs_20, instrument_454_gs_flx
                        instrument_454_gs_flx_titanium, instrument_454_gs_junior, instrument_ab_310_genetic_analyzer
                        instrument_ab_3130_genetic_analyzer, instrument_ab_3130xl_genetic_analyzer
                        instrument_ab_3500_genetic_analyzer, instrument_ab_3500xl_genetic_analyzer
                        instrument_ab_3730_genetic_analyzer, instrument_ab_3730xl_genetic_analyzer
                        instrument_ab_5500_genetic_analyzer, instrument_ab_5500xl_genetic_analyzer
                        instrument_ab_5500xl_w_genetic_analysis_system, instrument_ab_solid_3_plus_system
                        instrument_ab_solid_4_system, instrument_ab_solid_4hq_system, instrument_ab_solid_pi_system
                        instrument_ab_solid_system, instrument_ab_solid_system_2_0, instrument_ab_solid_system_3_0
                        instrument_amcareseq_2000, instrument_bgiseq_100, instrument_bgiseq_1000, instrument_bgiseq_2000
                        instrument_bgiseq_50, instrument_bgiseq_500, instrument_complete_genomics, instrument_cycloneseq
                        instrument_dnbseq_e25, instrument_dnbseq_g400, instrument_dnbseq_g400_fast, instrument_dnbseq_g50
                        instrument_dnbseq_g99, instrument_dnbseq_t1, instrument_dnbseq_t10x4, instrument_dnbseq_t10x4rs
                        instrument_dnbseq_t7, instrument_element_aviti, instrument_element_aviti24, instrument_fastaseq_300
                        instrument_g_seq500, instrument_g4, instrument_genexus, instrument_genocare_1600
                        instrument_genolab_m, instrument_gridion, instrument_gs111, instrument_helicos_heliscope
                        instrument_hiseq_x_five, instrument_hiseq_x_ten, instrument_illumina_genome_analyzer
                        instrument_illumina_genome_analyzer_ii, instrument_illumina_genome_analyzer_iix
                        instrument_illumina_hiscansq, instrument_illumina_hiseq_1000, instrument_illumina_hiseq_1500
                        instrument_illumina_hiseq_2000, instrument_illumina_hiseq_2500, instrument_illumina_hiseq_3000
                        instrument_illumina_hiseq_4000, instrument_illumina_hiseq_x, instrument_illumina_hiseq_x_ten
                        instrument_illumina_iseq_100, instrument_illumina_miniseq, instrument_illumina_miseq
                        instrument_illumina_novaseq_5000, instrument_illumina_novaseq_6000, instrument_illumina_novaseq_x
                        instrument_illumina_novaseq_x_plus, instrument_ion_genestudio_s5, instrument_ion_genestudio_s5_plus
                        instrument_ion_genestudio_s5_prime, instrument_ion_s5, instrument_ion_s5_xl
                        instrument_ion_torrent_genexus, instrument_ion_torrent_pgm, instrument_ion_torrent_proton
                        instrument_ion_torrent_s5, instrument_ion_torrent_s5_xl, instrument_mgiseq_200
                        instrument_mgiseq_2000, instrument_mgiseq_2000rs, instrument_minion, instrument_miseq_i100
                        instrument_miseq_i100_plus, instrument_nextseq_1000, instrument_nextseq_2000, instrument_nextseq_500
                        instrument_nextseq_550, instrument_onso, instrument_pacbio_rs, instrument_pacbio_rs_ii
                        instrument_promethion, instrument_qpursue_6k, instrument_revio, instrument_salus_evo
                        instrument_salus_pro, instrument_sentosa_sq301, instrument_sequel, instrument_sequel_ii
                        instrument_sequel_iie, instrument_surfseq_5000, instrument_surfseq_q, instrument_tapestri
                        instrument_ug_100, instrument_unspecified, library_layout_paired, library_layout_single
                        library_selection_5_methylcytidine_antibody, library_selection_cage, library_selection_cdna
                        library_selection_cdna_oligo_dt, library_selection_cdna_randompriming, library_selection_chip
                        library_selection_chip_seq, library_selection_dnase, library_selection_hmpr
                        library_selection_hybrid_selection, library_selection_inverse_rrna
                        library_selection_mbd2_protein_methyl_cpg_binding_domain, library_selection_mda
                        library_selection_mf, library_selection_mnase, library_selection_msll, library_selection_oligo_dt
                        library_selection_other, library_selection_padlock_probes_capture_method, library_selection_pcr
                        library_selection_polya, library_selection_race, library_selection_random
                        library_selection_random_pcr, library_selection_reduced_representation
                        library_selection_repeat_fractionation, library_selection_restriction_digest
                        library_selection_rt_pcr, library_selection_size_fractionation, library_selection_unspecified
                        location_gs_us, location_gs_us_central1, location_gs_us_east1, location_s3_us_east_1
                        platform_abi_solid, platform_amcare, platform_bgiseq
  -ly string, --layout string
                        Library layout of the sequencing data:
                        paired, single
  -ac string, --access string
                        Data accessibility:
                        public, controlled
  -bp string, --bioproject string
                        BioProject accession in the form of PRJNA#, PRJEB#, or PRJDB#
  -bs string, --biosample string
                        BioSample accession in the form of SAMN#, SAMEA#, or SAMD#
  -as string, --accession string
                        SRA/ENA/DDBJ accession
                        Study with accessions in the form of SRP#, ERP#, or DRP#
                        Sample with accessions in the form of SRS#, ERS#, or DRS#
                        Experiment with accessions in the form of SRX#, ERX#, or DRX#
                        Run with accessions in the form of SRR#, ERR#, or DRR#
  -ti string, --title string
                        Descriptive name of the dataset
  -at string, --author string
                        Researcher or group that submitted the data
                         Example: SON_KH
  -pd range, --publication range
                        Publication Date
                        YYYY.MM.DD : YYYY.MM.DD format
                        Example: 2016, 2016.07, 2016.07.01, 2016.07:2023.02
  -md range, --modification range
                        Modification Date
                        YYYY.MM.DD : YYYY.MM.DD format
                        Example: 2016, 2016.07, 2016.07.01, 2016.07:2023.02
  -rl range, --readlength range
                        Length of the sequencing readsExample: 100 or 100:500
  -mb string, --mbases string
                        Number of mega bases in the SRA Runs
  -tw string, --textword string
                        General search term for finding datasets by specific words in metadata
  -ex keywords, --exclude keywords
                        Exclude the results for the keywords used in this option
                        Example: cell_line,normal,crispr
                         
  -d, --detail          Show the number of searched results for each option and keyword
                         
  -m, --metadata        Save integrated metadata
                         
  -u, --url             Save the file, including the URL address of the raw data (.fastq).
```

## Metadata
- **Skill**: generated
