# hairsplitter CWL Generation Report

## hairsplitter_hairsplitter.py

### Tool Description
Welcome!

### Metadata
- **Docker Image**: quay.io/biocontainers/hairsplitter:1.9.10--h8b7377a_1
- **Homepage**: https://github.com/RolandFaure/HairSplitter
- **Package**: https://anaconda.org/channels/bioconda/packages/hairsplitter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hairsplitter/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RolandFaure/HairSplitter
- **Stars**: N/A
### Original Help Text
```text
******************
	*                *
	*  Hairsplitter  *
	*    Welcome!    *
	*                *
	******************

usage: hairsplitter.py [-h] -i ASSEMBLY -f FASTQ [-c HAPLOID_COVERAGE]
                       [-x USE_CASE] [-p POLISHER] [--correct-assembly]
                       [-t THREADS] -o OUTPUT [--resume] [-s] [-P] [-F] [-l]
                       [--clean]
                       [--rarest-strain-abundance RAREST_STRAIN_ABUNDANCE]
                       [--minimap2-params MINIMAP2_PARAMS]
                       [--path_to_minimap2 PATH_TO_MINIMAP2]
                       [--path_to_minigraph PATH_TO_MINIGRAPH]
                       [--path_to_racon PATH_TO_RACON]
                       [--path_to_medaka PATH_TO_MEDAKA]
                       [--path_to_samtools PATH_TO_SAMTOOLS]
                       [--path_to_python PATH_TO_PYTHON]
                       [--path_to_raven PATH_TO_RAVEN] [-v] [-d]

options:
  -h, --help            show this help message and exit
  -i ASSEMBLY, --assembly ASSEMBLY
                        Original assembly in GFA or FASTA format (required)
  -f FASTQ, --fastq FASTQ
                        Sequencing reads fastq or fasta (required)
  -c HAPLOID_COVERAGE, --haploid-coverage HAPLOID_COVERAGE
                        Expected haploid coverage. 0 if does not apply [0]
  -x USE_CASE, --use-case USE_CASE
                        {ont, pacbio, hifi,amplicon} [ont]
  -p POLISHER, --polisher POLISHER
                        {racon,medaka} medaka is more accurate but much slower
                        [racon]
  --correct-assembly    Correct structural errors in the input assembly (time-
                        consuming)
  -t THREADS, --threads THREADS
                        Number of threads [1]
  -o OUTPUT, --output OUTPUT
                        Output directory
  --resume              Resume from a previous run
  -s, --dont_simplify   Don't merge the contig
  -P, --polish-everything
                        Polish every contig with racon, even those where there
                        is only one haplotype
  -F, --force           Force overwrite of output folder if it exists
  -l, --low-memory      Turn on the low-memory mode (at the expense of speed)
  --clean               Clean the temporary files
  --rarest-strain-abundance RAREST_STRAIN_ABUNDANCE
                        Limit on the relative abundance of the rarest strain
                        to detect (0 might be slow for some datasets) [0.01]
  --minimap2-params MINIMAP2_PARAMS
                        Parameters to pass to minimap2
  --path_to_minimap2 PATH_TO_MINIMAP2
                        Path to the executable minimap2 [minimap2]
  --path_to_minigraph PATH_TO_MINIGRAPH
                        Path to the executable minigraph [minigraph]
  --path_to_racon PATH_TO_RACON
                        Path to the executable racon [racon]
  --path_to_medaka PATH_TO_MEDAKA
                        Path to the executable medaka [medaka]
  --path_to_samtools PATH_TO_SAMTOOLS
                        Path to samtools [samtools]
  --path_to_python PATH_TO_PYTHON
                        Path to python [python]
  --path_to_raven PATH_TO_RAVEN
                        Path to raven [raven]
  -v, --version         Print version and exit
  -d, --debug           Debug mode
```

