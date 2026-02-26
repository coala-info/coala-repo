cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmlong2
label: mmlong2
doc: "bioinformatics pipeline for microbial genome recovery and analysis using long
  reads\n\nTool homepage: https://github.com/Serka-M/mmlong2"
inputs:
  - id: binning_mode
    type:
      - 'null'
      - string
    doc: Run pipeline with a specified binning mode (e.g. fast default extended)
    inputBinding:
      position: 101
      prefix: --binning_mode
  - id: conda_envs_only
    type:
      - 'null'
      - boolean
    doc: Use conda environments instead of container
    default: use container
    inputBinding:
      position: 101
      prefix: --conda_envs_only
  - id: coverage
    type:
      - 'null'
      - string
    doc: CSV dataframe for differential coverage binning (e.g. 
      NP/PB/IL,/path/to/reads.fastq)
    inputBinding:
      position: 101
      prefix: --coverage
  - id: custom_assembly
    type:
      - 'null'
      - boolean
    doc: Use a custom assembly
    default: use metaflye
    inputBinding:
      position: 101
      prefix: --custom_assembly
  - id: custom_assembly_info
    type:
      - 'null'
      - File
    doc: Optional assembly information file (metaFlye format) for custom 
      assembly
    inputBinding:
      position: 101
      prefix: --custom_assembly_info
  - id: database_bakta
    type:
      - 'null'
      - Directory
    doc: Bakta database to use
    default: /path/to/bakta/database_dir
    inputBinding:
      position: 101
      prefix: --database_bakta
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for database installation
    default: /
    inputBinding:
      position: 101
      prefix: --database_dir
  - id: database_gtdb
    type:
      - 'null'
      - Directory
    doc: GTDB-tk database to use
    default: /path/to/gtdb/database_dir
    inputBinding:
      position: 101
      prefix: --database_gtdb
  - id: database_gunc
    type:
      - 'null'
      - File
    doc: Gunc database to use
    default: /path/to/gunc/database_file.dmnd
    inputBinding:
      position: 101
      prefix: --database_gunc
  - id: database_metabuli
    type:
      - 'null'
      - Directory
    doc: Metabuli database to use
    default: /path/to/metabuli/database_dir
    inputBinding:
      position: 101
      prefix: --database_metabuli
  - id: database_rrna
    type:
      - 'null'
      - File
    doc: 16S rRNA database to use
    default: /path/to/rrna/database_file.udb
    inputBinding:
      position: 101
      prefix: --database_rrna
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Print summary of jobs for the Snakemake workflow
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: extra_bakta
    type:
      - 'null'
      - string
    doc: Extra inputs for MAG annotation with Bakta
    default: none
    inputBinding:
      position: 101
      prefix: --extra_bakta
  - id: extra_inputs1
    type:
      - 'null'
      - string
    doc: Extra inputs for the MAG production part of the Snakemake workflow
    default: none
    inputBinding:
      position: 101
      prefix: --extra_inputs1
  - id: extra_inputs2
    type:
      - 'null'
      - string
    doc: Extra inputs for the MAG processing part of the Snakemake workflow
    default: none
    inputBinding:
      position: 101
      prefix: --extra_inputs2
  - id: extra_myloasm
    type:
      - 'null'
      - string
    doc: Extra inputs for myloasm assembler
    default: none
    inputBinding:
      position: 101
      prefix: --extra_myloasm
  - id: flye_min_cov
    type:
      - 'null'
      - int
    doc: Minimum initial contig coverage used by Flye assembler
    default: 3
    inputBinding:
      position: 101
      prefix: --flye_min_cov
  - id: flye_min_ovlp
    type:
      - 'null'
      - string
    doc: Minimum overlap between reads used by Flye assembler
    default: auto
    inputBinding:
      position: 101
      prefix: --flye_min_ovlp
  - id: install_databases
    type:
      - 'null'
      - boolean
    doc: Install missing databases used by the workflow
    inputBinding:
      position: 101
      prefix: --install_databases
  - id: medaka_model
    type:
      - 'null'
      - string
    doc: Medaka polishing model
    default: r1041_e82_400bps_sup_v5.0.0
    inputBinding:
      position: 101
      prefix: --medaka_model
  - id: min_contig_cov
    type:
      - 'null'
      - float
    doc: Minimum assembly contig coverage for binning
    default: 0
    inputBinding:
      position: 101
      prefix: --min_contig_cov
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Minimum assembly contig length for binning
    default: 3000
    inputBinding:
      position: 101
      prefix: --min_contig_len
  - id: min_len_bin
    type:
      - 'null'
      - int
    doc: Minimum genomic bin size
    default: 250000
    inputBinding:
      position: 101
      prefix: --min_len_bin
  - id: myloasm_min_cov
    type:
      - 'null'
      - float
    doc: Minimum contig coverage used by myloasm assembler
    default: 1
    inputBinding:
      position: 101
      prefix: --myloasm_min_cov
  - id: myloasm_min_ovlp
    type:
      - 'null'
      - int
    doc: Minimum overlap between reads used by myloasm assembler
    default: 500
    inputBinding:
      position: 101
      prefix: --myloasm_min_ovlp
  - id: nanopore_reads
    type:
      - 'null'
      - File
    doc: Path to Nanopore reads
    inputBinding:
      position: 101
      prefix: --nanopore_reads
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory name
    default: mmlong2
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: pacbio_reads
    type:
      - 'null'
      - File
    doc: Path to PacBio HiFi reads
    inputBinding:
      position: 101
      prefix: --pacbio_reads
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes/multi-threading
    default: 3
    inputBinding:
      position: 101
      prefix: --processes
  - id: rerun_production
    type:
      - 'null'
      - boolean
    doc: Rerun MAG production workflow
    inputBinding:
      position: 101
      prefix: --rerun-production
  - id: rule1
    type:
      - 'null'
      - string
    doc: Run specified Snakemake rule for the MAG production part of the 
      workflow
    inputBinding:
      position: 101
      prefix: --rule1
  - id: rule2
    type:
      - 'null'
      - string
    doc: Run specified Snakemake rule for the MAG processing part of the 
      workflow
    inputBinding:
      position: 101
      prefix: --rule2
  - id: run_until
    type:
      - 'null'
      - string
    doc: Run pipeline until a specified stage completes (e.g.  assembly curation
      filtering singletons coverage binning taxonomy annotation extraqc stats)
    inputBinding:
      position: 101
      prefix: --run_until
  - id: semibin_model
    type:
      - 'null'
      - string
    doc: Binning model for SemiBin
    default: global
    inputBinding:
      position: 101
      prefix: --semibin_model
  - id: skip_cleanup
    type:
      - 'null'
      - boolean
    doc: Skip cleanup of workflow intermediate files
    inputBinding:
      position: 101
      prefix: --skip_cleanup
  - id: skip_curation
    type:
      - 'null'
      - boolean
    doc: Skip assembly curation and removal of misassemblies
    default: run curation
    inputBinding:
      position: 101
      prefix: --skip_curation
  - id: temporary_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files
    default: ''
    inputBinding:
      position: 101
      prefix: --temporary_dir
  - id: touch
    type:
      - 'null'
      - boolean
    doc: Touch Snakemake output files
    inputBinding:
      position: 101
      prefix: --touch
  - id: use_medaka
    type:
      - 'null'
      - boolean
    doc: Use Medaka for polishing Nanopore assemblies
    default: skip Medaka
    inputBinding:
      position: 101
      prefix: --use_medaka
  - id: use_metaflye
    type:
      - 'null'
      - boolean
    doc: Use metaFlye for metagenomic assembly
    default: use metaflye
    inputBinding:
      position: 101
      prefix: --use_metaflye
  - id: use_metamdbg
    type:
      - 'null'
      - boolean
    doc: Use metaMDBG for metagenomic assembly
    default: use metaflye
    inputBinding:
      position: 101
      prefix: --use_metamdbg
  - id: use_myloasm
    type:
      - 'null'
      - boolean
    doc: Use myloasm for metagenomic assembly
    default: use metaflye
    inputBinding:
      position: 101
      prefix: --use_myloasm
  - id: use_whokaryote
    type:
      - 'null'
      - boolean
    doc: Use Whokaryote for identifying eukaryotic contigs
    default: use Tiara
    inputBinding:
      position: 101
      prefix: --use_whokaryote
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmlong2:1.2.1--hdfd78af_1
stdout: mmlong2.out
