# shiver CWL Generation Report

## shiver_shiver_init.sh

### Tool Description
Initialises shiver files.

### Metadata
- **Docker Image**: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
- **Homepage**: https://github.com/ChrisHIV/shiver
- **Package**: https://anaconda.org/channels/bioconda/packages/shiver/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shiver/overview
- **Total Downloads**: 30.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ChrisHIV/shiver
- **Stars**: N/A
### Original Help Text
```text
In normal usage this script requires 5 arguments:
 (1) an output directory for the initialisation files.
 (2) the configuration file, containing all your parameter choices etc.;
 (3) your chosen alignment of references;
 (4) a fasta file of the adapters used in sequencing;
 (5) a fasta file of the primers used in sequencing. 
Alternatively call this script with one argument - '--help' or '-h' - to see this message. Alternatively call this script with two arguments - '--test' then the configuration file - to just test whether the configuration file is OK (including whether this script can call the external programs it needs using commands given in the config file) and then exit.
```


## shiver_shiver_align_contigs.sh

### Tool Description
Aligns contigs to references based on blast hits. In normal usage this script requires 4 arguments: the initialisation directory, the configuration file, a fasta file of contigs, and a sample ID for naming output. Alternatively, it can be called with '--test' and a configuration file to test the configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
- **Homepage**: https://github.com/ChrisHIV/shiver
- **Package**: https://anaconda.org/channels/bioconda/packages/shiver/overview
- **Validation**: PASS

### Original Help Text
```text
In normal usage this script requires 4 arguments:
 (1) the initialisation directory you created using the shiver_init.sh command;
 (2) the configuration file, containing all your parameter choices etc.;
 (3) a fasta file of contigs (output from processing the short reads with an assembly program);
 (4) A sample ID ('SID') used for naming the output from this script (a sensible choice might be the contig file name minus its path and extension). 
Alternatively call this script with one argument - '--help' or '-h' - to see this message. Alternatively call this script with two arguments - '--test' then the configuration file - to just test whether the configuration file is OK (including whether this script can call the external programs it needs using commands given in the config file) and then exit.

In normal usage, if this script completes successfully it will produce a .blast file (detailing the contigs that have blast hits). If the .blast file is not empty it will produce a fasta file of those contigs with hits and another fasta file of these contigs aligned to the refereces; if cutting and/or reversing of contigs is necessary, two more fasta files are produced - the cut/reversed contigs on their own and also aligned to references (i.e. there will be two files of the contigs on their own and two files of the contigs aligned to references).
```


## shiver_shiver_map_reads.sh

### Tool Description
Maps reads to contigs, potentially using reference alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
- **Homepage**: https://github.com/ChrisHIV/shiver
- **Package**: https://anaconda.org/channels/bioconda/packages/shiver/overview
- **Validation**: PASS

### Original Help Text
```text
In normal usage this script requires either 8 or 7 arguments:
 (1) the initialisation directory you created using the shiver_init.sh command;
 (2) the configuration file, containing all your parameter choices etc.;
 (3) a fasta file of contigs (output from processing the short reads with an assembly program);
 (4) A sample ID (SID) used for naming the output from this script (a sensible choice might be the contig file name minus its path and extension);
 (5) the blast file created by the shiver_align_contigs.sh command;
 (6) either the alignment of contigs to refs produced by the shiver_align_contigs.sh command, or a fasta file containing a single reference to be used for mapping;
 (7) the forward reads when mapping paired reads, or the single reads file for unpaired;
 (8) the reverse reads for paired reads, or for unpaired reads omit this argument. 
Alternatively call this script with one argument - '--help' or '-h' - to see this message. Alternatively call this script with three arguments - '--test', then the configuration file, then either 'paired' or 'unpaired' - to just test whether the configuration file is OK (including whether this script can call the external programs it needs using commands given in the config file) and then exit. That third argument being 'paired' or 'unpaired' determines whether the config file is checked for suitability for use with paired or unpaired reads respectively.
```


## Metadata
- **Skill**: generated
