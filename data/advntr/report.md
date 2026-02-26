# advntr CWL Generation Report

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


## advntr_viewmodel

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
- **Homepage**: https://github.com/mehrdadbakhtiari/adVNTR
- **Package**: https://anaconda.org/channels/bioconda/packages/advntr/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
2026-02-24 14:59:39.202173: I tensorflow/core/util/port.cc:153] oneDNN custom operations are on. You may see slightly different numerical results due to floating-point round-off errors from different computation orders. To turn them off, set the environment variable `TF_ENABLE_ONEDNN_OPTS=0`.
2026-02-24 14:59:39.231478: I tensorflow/core/platform/cpu_feature_guard.cc:210] This TensorFlow binary is optimized to use available CPU instructions in performance-critical operations.
To enable the following instructions: AVX_VNNI, in other operations, rebuild TensorFlow with the appropriate compiler flags.
/usr/local/lib/python3.10/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
/usr/local/lib/python3.10/site-packages/Bio/Application/__init__.py:39: BiopythonDeprecationWarning: The Bio.Application modules and modules relying on it have been deprecated.

Due to the on going maintenance burden of keeping command line application
wrappers up to date, we have decided to deprecate and eventually remove these
modules.

We instead now recommend building your command line and invoking it directly
with the subprocess module.
  warnings.warn(
usage: advntr viewmodel [options]
=======================================================
adVNTR 1.5.0: Genopyting tool for VNTRs
=======================================================
Source code: https://github.com/mehrdadbakhtiari/adVNTR
Instructions: http://advntr.readthedocs.io
-------------------------------------------------------

usage: advntr <command> [options]


Command: genotype	find RU counts and mutations in VNTRs
         viewmodel	view existing models in database
         addmodel	add custom VNTR to the database
         delmodel	remove a model from database viewmodel: error: argument -h/--help: ignored explicit argument 'elp'
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


## advntr_delmodel

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1
- **Homepage**: https://github.com/mehrdadbakhtiari/adVNTR
- **Package**: https://anaconda.org/channels/bioconda/packages/advntr/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
2026-02-24 15:01:31.566998: I tensorflow/core/util/port.cc:153] oneDNN custom operations are on. You may see slightly different numerical results due to floating-point round-off errors from different computation orders. To turn them off, set the environment variable `TF_ENABLE_ONEDNN_OPTS=0`.
2026-02-24 15:01:31.588735: I tensorflow/core/platform/cpu_feature_guard.cc:210] This TensorFlow binary is optimized to use available CPU instructions in performance-critical operations.
To enable the following instructions: AVX_VNNI, in other operations, rebuild TensorFlow with the appropriate compiler flags.
/usr/local/lib/python3.10/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
/usr/local/lib/python3.10/site-packages/Bio/Application/__init__.py:39: BiopythonDeprecationWarning: The Bio.Application modules and modules relying on it have been deprecated.

Due to the on going maintenance burden of keeping command line application
wrappers up to date, we have decided to deprecate and eventually remove these
modules.

We instead now recommend building your command line and invoking it directly
with the subprocess module.
  warnings.warn(
usage: advntr delmodel [options]
=======================================================
adVNTR 1.5.0: Genopyting tool for VNTRs
=======================================================
Source code: https://github.com/mehrdadbakhtiari/adVNTR
Instructions: http://advntr.readthedocs.io
-------------------------------------------------------

usage: advntr <command> [options]


Command: genotype	find RU counts and mutations in VNTRs
         viewmodel	view existing models in database
         addmodel	add custom VNTR to the database
         delmodel	remove a model from database delmodel: error: argument -h/--help: ignored explicit argument 'elp'
```

