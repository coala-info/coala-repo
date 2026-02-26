# mmlong2 CWL Generation Report

## mmlong2

### Tool Description
bioinformatics pipeline for microbial genome recovery and analysis using long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/mmlong2:1.2.1--hdfd78af_1
- **Homepage**: https://github.com/Serka-M/mmlong2
- **Package**: https://anaconda.org/channels/bioconda/packages/mmlong2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mmlong2/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-10-29
- **GitHub**: https://github.com/Serka-M/mmlong2
- **Stars**: N/A
### Original Help Text
```text
mmlong2: bioinformatics pipeline for microbial genome recovery and analysis using long reads
For issues or feedback please use https://github.com/Serka-M/mmlong2/issues or e-mail to mase@bio.aau.dk 

MAIN INPUTS:
-np	--nanopore_reads	Path to Nanopore reads (default: none)
-pb	--pacbio_reads		Path to PacBio HiFi reads (default: none)
-o	--output_dir		Output directory name (default: mmlong2)
-p	--processes		Number of processes/multi-threading (default: 3)
-bin	--binning_mode		Run pipeline with a specified binning mode (e.g. fast default extended)
 
OPTIONAL SETTINGS:
-db 	--install_databases	Install missing databases used by the workflow
-dbd 	--database_dir		Output directory for database installation (default: /)
-cov 	--coverage		CSV dataframe for differential coverage binning (e.g. NP/PB/IL,/path/to/reads.fastq)
-run	--run_until		Run pipeline until a specified stage completes (e.g.  assembly curation filtering singletons coverage binning taxonomy annotation extraqc stats)
-tmp	--temporary_dir		Directory for temporary files (default: )
-fly	--use_metaflye		Use metaFlye for metagenomic assembly (default: use metaflye)
-dbg	--use_metamdbg		Use metaMDBG for metagenomic assembly (default: use metaflye)
-myl	--use_myloasm		Use myloasm for metagenomic assembly (default: use metaflye)
-ca	--custom_assembly	Use a custom assembly (default: use metaflye)
-cai	--custom_assembly_info	Optional assembly information file (metaFlye format) for custom assembly
-med	--use_medaka		Use Medaka for polishing Nanopore assemblies (default: skip Medaka)
-mm	--medaka_model		Medaka polishing model (default: r1041_e82_400bps_sup_v5.0.0)
-scr	--skip_curation		Skip assembly curation and removal of misassemblies (default: run curation)
-who	--use_whokaryote	Use Whokaryote for identifying eukaryotic contigs (default: use Tiara)
-sem	--semibin_model		Binning model for SemiBin (default: global)
-mcl	--min_contig_len	Minimum assembly contig length for binning (default: 3000)
-mcc	--min_contig_cov	Minimum assembly contig coverage for binning (default: 0)
-mlb	--min_len_bin		Minimum genomic bin size (default: 250000)
-scl	--skip_cleanup		Skip cleanup of workflow intermediate files
-rrna	--database_rrna		16S rRNA database to use (default: /path/to/rrna/database_file.udb)
-gunc	--database_gunc		Gunc database to use (default: /path/to/gunc/database_file.dmnd)
-bkt	--database_bakta	Bakta database to use (default: /path/to/bakta/database_dir)
-mtb	--database_metabuli	Metabuli database to use (default: /path/to/metabuli/database_dir)
-gtdb	--database_gtdb		GTDB-tk database to use (default: /path/to/gtdb/database_dir)
-env	--conda_envs_only	Use conda environments instead of container (default: use container)
-h	--help			Print help information
-v	--version		Print workflow version number

ADVANCED SETTINGS:
-mmo	--myloasm_min_ovlp	Minimum overlap between reads used by myloasm assembler (default: 500)
-mmc	--myloasm_min_cov	Minimum contig coverage used by myloasm assembler (default: 1)
-xm	--extra_myloasm		Extra inputs for myloasm assembler (default: none)
-fmo	--flye_min_ovlp		Minimum overlap between reads used by Flye assembler (default: auto)
-fmc	--flye_min_cov		Minimum initial contig coverage used by Flye assembler (default: 3)
-re	--rerun-production	Rerun MAG production workflow
-n	--dryrun		Print summary of jobs for the Snakemake workflow
-t	--touch			Touch Snakemake output files
-r1	--rule1			Run specified Snakemake rule for the MAG production part of the workflow
-r2	--rule2			Run specified Snakemake rule for the MAG processing part of the workflow
-x1	--extra_inputs1		Extra inputs for the MAG production part of the Snakemake workflow (default: none)
-x2	--extra_inputs2		Extra inputs for the MAG processing part of the Snakemake workflow (default: none)
-xb	--extra_bakta		Extra inputs for MAG annotation with Bakta (default: none)

Aalborg University, Denmark, 2025

ERROR: Sequencing reads not provided
```

