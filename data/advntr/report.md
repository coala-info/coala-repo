# advntr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| advntr_addmodel | Failed | image problem: pomegranate 0.6.1 cannot build HMMs with the bundled networkx 3.4.2 (KeyError 0 in HiddenMarkovModel.bake), so addmodel crashes on real hg38 chr22 data. |
| advntr_genotype | Failed | image problem: pomegranate 0.6.1 is incompatible with networkx 3.4.2 (topological_sort nbunch error), so every VNTR is skipped and the output is only 'Error'. |

## advntr_genotype

### Tool Description
Genotype VNTRs from sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
- **Homepage**: https://github.com/mehrdadbakhtiari/adVNTR
- **Package**: https://anaconda.org/channels/bioconda/packages/advntr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/advntr/overview
- **Total Downloads**: 68.2K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/mehrdadbakhtiari/adVNTR
- **Stars**: N/A
### Original Help Text
```text
usage: advntr genotype [options]

Input/output options:
  -a/--alignment_file <file>      alignment file in SAM/BAM/CRAM format
  -r/--reference_filename <file>  path to a FASTA-formatted reference file for CRAM files. It overrides
                                  filename specified in header, which is normally used to find the reference
  -f/--fasta <file>               Fasta file containing raw reads
  -p/--pacbio                     set this flag if input file contains PacBio reads instead of Illumina reads
  --log_pacbio_reads              set this flag to store the PacBio read information for genotyping in the log
                                  files. Note that it might lead to very large log files due to the length of
                                  the PacBio reads.
  -n/--nanopore                   set this flag if input file contains Nanopore MinION reads instead of
                                  Illumina
  -o/--outfile <file>             file to write results. adVNTR writes output to stdout if oufile is not
                                  specified.
  -of/--outfmt <format>           output format. Allowed values are {text, bed, vcf} [text]
  --disable_logging               set this flag to stop writing to log file except for critical errors.

Algorithm options:
  -fs/--frameshift                set this flag to search for frameshifts in VNTR instead of copy number.
                                  Supported VNTR IDs: [25561, 519759]
  -e/--expansion                  set this flag to determine long expansion from PCR-free data
  -c/--coverage <float>           average sequencing coverage in PCR-free sequencing
  --haploid                       set this flag if the organism is haploid
  -naive/--naive                  use naive approach for PacBio reads

Other options:
  -h/--help                       show this help message and exit
  --working_directory <path>      working directory for creating temporary files needed for computation
  -m/--models <file>              VNTR models file [vntr_data/hg19_selected_VNTRs_Illumina.db]
  -t/--threads <int>              number of threads [1]
  -u/--update                     set this flag to iteratively update the model
  -vid/--vntr_id <text>           comma-separated list of VNTR IDs
```

## advntr_addmodel

### Tool Description
Add a new VNTR model to the database

### Metadata
- **Docker Image**: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
- **Homepage**: https://github.com/mehrdadbakhtiari/adVNTR
- **Package**: https://anaconda.org/channels/bioconda/packages/advntr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: advntr addmodel [options]

Required arguments:
  -r/--reference <text>   Reference genome
  -c/--chromosome <text>  Chromosome (e.g. chr1)
  -p/--pattern <text>     First repeating pattern of VNTR in forward (5' to 3') direction
  -s/--start <int>        Start coordinate of VNTR in forward (5' to 3') direction
  -e/--end <int>          End coordinate of VNTR in forward (5' to 3') direction

Other options:
  -g/--gene <text>        Gene name
  -a/--annotation <text>  Annotation of VNTR region
  -m/--models <file>      VNTR models file [vntr_data/hg19_selected_VNTRs_Illumina.db]
  -h/--help               show this help message and exit
```

## Metadata
- **Skill**: generated
