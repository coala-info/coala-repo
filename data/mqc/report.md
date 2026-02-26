# mqc CWL Generation Report

## mqc_mQC.pl

### Tool Description
MappingQC is a tool to easily generate some figures which give a nice overview of the quality of the mapping of ribosome profiling data. More specific, it gives an overview of the P site offset calculation, the gene distribution and the metagenic classification. Furthermore, MappingQC does a thorough analysis of the triplet periodicity and the linked triplet phase (typical for ribosome profiling) in the canonical transcript of your data. Especially, the link between the phase distribution and the RPF length, the relative sequence position and the triplet identity are taken into account.

### Metadata
- **Docker Image**: quay.io/biocontainers/mqc:1.10--py27pl5.22.0r3.4.1_0
- **Homepage**: https://github.com/Biobix/mQC
- **Package**: https://anaconda.org/channels/bioconda/packages/mqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mqc/overview
- **Total Downloads**: 53.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Biobix/mQC
- **Stars**: N/A
### Original Help Text
```text
Working directory                                        : /
The following tmpfolder is used                          : //tmp


MappingQC (Stand-alone version)

    MappingQC is a tool to easily generate some figures which give a nice overview of the quality of the mapping of ribosome profiling data. More specific, it gives an overview of the P site offset calculation, the gene distribution and the metagenic classification. Furthermore, MappingQC does a thorough analysis of the triplet periodicity and the linked triplet phase (typical for ribosome profiling) in the canonical transcript of your data. Especially, the link between the phase distribution and the RPF length, the relative sequence position and the triplet identity are taken into account.
        
    Input parameters:
    --help                  this helpful screen
    --work_dir              working directory to run the scripts in (default: current working directory)
    --experiment_name       customly chosen experiment name for the mappingQC run (mandatory)
    --samfile               path to the SAM/BAM file that comes out of the mapping script of PROTEOFORMER (mandatory)
    --cores                 the amount of cores to run the script on (integer, default: 5)
    --species               the studied species (mandatory)
    --ens_v                 the version of the Ensembl database you want to use
    --tmp                   temporary folder for storing temporary files of mappingQC (default: work_dir/tmp)
    --unique                whether to use only the unique alignments.
    Possible options: Y, N (default Y)
    --mapper                the mapper you used to generate the SAM file (STAR, TopHat2, HiSat2) (default: STAR)
    --maxmultimap           the maximum amount of multimapped positions used for filtering the reads (default: 16)
    --ens_db                path to the Ensembl SQLite database with annotation info. If you want mappingQC to download the right Ensembl database automatically for you, put in 'get' for this parameter (mandatory)
    --offset                the offset determination method.
                                Possible options:
                                - plastid: calculate the offsets with Plastid (Dunn et al. 2016)
                                - standard: use the standard offsets from the paper of Ingolia et al. (2012) (default option)
                                - from_file: use offsets from an input file
    --plastid_bam           the mapping bam file for Plastid offset generation (default: convert)
    --min_length_plastid    the minimum RPF length for Plastid offset generation (default 22)
    --max_length_plastid    the maximum RPF length for Plastid offset generation (default 34)
    --offset_file           the offsets input file
    --min_length_gd         minimum RPF length used for gene distributions and metagenic classification (default: 26).
    --max_length_gd         maximum RPF length used for gene distributions and metagenic classification (default: 34).
    --outfolder             the folder to store the output files (default: work_dir/mQC_output)
    --tool_dir              folder with necessary additional mappingQC tools. More information below in the dependencies section. (default: search for the default tool directory location in the active conda environment)
    --plotrpftool           the module that will be used for plotting the RPF-phase figure
                                Possible options:
                                - grouped2D: use Seaborn to plot a grouped 2D bar chart (default)
                                - pyplot3D: use mplot3d to plot a 3D bar chart. This tool can suffer sometimes from Escher effects, as it tries to plot a 3D plot with the 2D software of pyplot and matplotlib.
                                - mayavi: use the mayavi package to plot a 3D bar chart. This tool only works on local systems with graphical cards.
    --outhtml               custom name for the output HTML file (default: work_dir/mQC_experiment_name.html)
    --outzip                custom name for output ZIP file (default: work_dir/mQC_experiment_name.zip)
```

