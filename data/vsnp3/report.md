# vsnp3 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vsnp3_vsnp3_alignment_vcf.py | PASS | synthetic data: reads simulated from the real lambda phage genome with 10 planted SNPs; all 10 SNPs are called, 99.99% coverage |
| vsnp3_vsnp3_annotation.py | PASS | lambda phage position 3745 gives portal protein R304W, same as the VCF annotation |
| vsnp3_vsnp3_assembly.py | PASS | simulated lambda phage reads assemble into one 48,499 bp contig (genome is 48,502 bp) |
| vsnp3_vsnp3_best_reference_sourmash.py | PASS | real SARS-CoV-2 reads: top sourmash hit is NC_045512.2 (Wuhan-Hu-1) |
| vsnp3_vsnp3_bruc_mlst.py | Failed | image problem: picard is not in the image (exit code 127), so no BAM or VCF is made and the script ends with KeyError POS |
| vsnp3_vsnp3_download_GCA_fasta_get_metadata.py | Failed | image problem: the NCBI datasets program is not in the image (datasets: command not found) |
| vsnp3_vsnp3_download_fasta_gbk_gff_by_acc.py | PASS | downloaded phage lambda NC_001416 FASTA, GenBank and GFF (48,502 bp) |
| vsnp3_vsnp3_excel_merge_defining_snps.py | Failed | tool bug: the output file name format string has a stray { so the script always ends with ValueError after reading both files |
| vsnp3_vsnp3_excel_merge_files.py | PASS | merged a seqkit statistics workbook and an alignment statistics workbook into one with both rows |
| vsnp3_vsnp3_fasta_to_fastq.py | PASS | lambda phage FASTA gives 9,700 read pairs of 100 bp at 20X, matching the log |
| vsnp3_vsnp3_fasta_to_snps_table.py | PASS | synthetic data: aligned FASTA of simulated strains with planted SNPs; the tree groups the planted clades |
| vsnp3_vsnp3_fastq_stats_seqkit.py | PASS | simulated lambda phage reads: 9,700 reads of 100 bp in each file |
| vsnp3_vsnp3_group_on_defining_snps.py | PASS | synthetic data: step 2 pickle of 7 lambda strains; group on one SNP gives the 4 strains that carry it with a tree and tables |
| vsnp3_vsnp3_group_reporter.py | Failed | image problem: the image bundles no reference option directory, so the defining SNP file is missing (ValueError: path is None) |
| vsnp3_vsnp3_html_tree.py | Failed | tool bug: the -o output file name is ignored; the page is always written as <input>_position_tree.html (main mode works) |
| vsnp3_vsnp3_kernel_plots.py | Failed | image problem: seaborn is not installed (ModuleNotFoundError) |
| vsnp3_vsnp3_kraken2_wrapper.py | Failed | image problem: the kraken2 program is not in the image (No such file or directory: kraken2) |
| vsnp3_vsnp3_path_adder.py | Failed | image problem: --cwd must write /usr/local/dependencies/reference_options_paths.txt inside the image, which is read-only, so the path is not added (exit code 0); base command also fixed |
| vsnp3_vsnp3_remove_from_analysis.py | PASS | two listed strains (S1b, S3) are removed; the other VCF files stay |
| vsnp3_vsnp3_spoligotype.py | PASS | synthetic data: reads built from the tool's spacer table give SB0001, octal 477777777413071 |
| vsnp3_vsnp3_step1.py | PASS |  |
| vsnp3_vsnp3_step2.py | PASS |  |
| vsnp3_vsnp3_table_compare.py | PASS | all-strain table against a one-clade table lists the 3 samples and 26 positions found only in the first table |
| vsnp3_vsnp3_vcf_annotation.py | PASS | 13 annotated records written, for example portal protein at position 3745 |
| vsnp3_vsnp3_vcf_merge_to_fasta.py | PASS | merged FASTA equals the original strain FASTA (10 planted SNPs applied) |
| vsnp3_vsnp3_zero_coverage.py | PASS | 3 zero coverage positions added; 10 quality SNPs kept |

## vsnp3_vsnp3_path_adder.py

### Tool Description
vsnp3_path_adder.py is used to add reference types.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Total Downloads**: 41.4K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/USDA-VS/vsnp3
- **Stars**: N/A
### Original Help Text
```text
usage: PROG [-h] [-d DIRECTORY] [-s] [-v]

---------------------------------------------------------

vsnp3_path_adder.py is used to add reference types.
Usage:
    Change working diretory to directory one up from directory containing dependencies.
    For example if AF2122 and H37 need to be added and are located here
    ~/Mycobacterium/AF2122
    ~/Mycobacterium/H37
    Change to ~/Mycobacterium and run
    vsnp3_path_adder.py -d $(pwd)
    This will add both AF2122 and H37 as reference types.
To see all available paths/reference:
    vsnp3_path_adder.py -s

Files to have in each reference type:
- FASTA (required)
- GBK (optional)
- define_filter.xlsx (required)
- remove_from_analysis.xlsx (optional)

See vsnp3_download_fasta_gbk_gff_by_acc.py to download FASTA and GBK
define_filter.xls and remove_from_analysis.xlsx templates are found in vsnp3 dependencies directory

---------------------------------------------------------

options:
  -h, --help            show this help message and exit
  -d DIRECTORY, --cwd DIRECTORY
                        Absolute directory path to be added to find reference
                        option files.
  -s, --show            Show available directories.
  -v, --version         show program's version number and exit

---------------------------------------------------------
```


## vsnp3_vsnp3_step1.py

### Tool Description
When running samples through step1 and 2 of vSNP, or when running a routine analysis, set up dependencies using vsnp3_path_adder.py

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vsnp3_step1.py [-h] [-n SAMPLE_NAME] [-r1 FASTQ_R1] [-r2 FASTQ_R2]
                      [-f FASTATOFASTQ] [-r [FASTA ...]] [-b [GBK ...]]
                      [-t REFERENCE_TYPE] [-p] [-o OUTPUT_DIR]
                      [-assemble_unmap] [-spoligo] [-d] [-v]

---------------------------------------------------------
Conda:
conda install vsnp3=3.13 -c conda-forge -c bioconda
---------------------------------------------------------

When running samples through step1 and 2 of vSNP, or when running a routine analysis, 
set up dependencies using vsnp3_path_adder.py

See vsnp3_path_adder.py -h for adding a reference type and for more information

Usage example:
vsnp3_step1.py -r1 *_R1*.fastq.gz -r2 *_R2*.fastq.gz -t NC_045512_wuhan-hu-1

For a few reference types (not all) sourmash can be used to find the best reference.  
See vsnp3_best_reference_sourmash.py -h for list of references.

If working or suspect one of these reference types the dependencies will automatically be found

Usage example:
vsnp3_step1.py -r1 *_R1*.fastq.gz -r2 *_R2*.fastq.gz

When running a one-off dependencies can be provided explicitly.

Usage example:
vsnp3_step1.py -r1 *_R1*.fastq.gz -r2 *_R2*.fastq.gz -f *fasta -b *gbk
or
vsnp3_step1.py -r1 ../myfastqs/*_R1*.fastq.gz -r2 ../myfastqs/*_R2*.fastq.gz -f ../myreference/*fasta -b ../myreference/*gbk

At completion of running script it is recommended to store sample folders by reference.  
For each reference there should be a "step1" and "step2" subfolder.  These sample folders 
should go into step1 subfolders for the reference type used to generate SNPs stored in the VCF file.
---------------------------------------------------------

options:
  -h, --help            show this help message and exit
  -n SAMPLE_NAME, --SAMPLE_NAME SAMPLE_NAME
                        Force output files to this sample name
  -r1 FASTQ_R1, --FASTQ_R1 FASTQ_R1
                        Provide R1 FASTQ gz file. A single read file can also
                        be supplied to this option
  -r2 FASTQ_R2, --FASTQ_R2 FASTQ_R2
                        Optional: provide R2 FASTQ gz file
  -f FASTATOFASTQ, --FASTAtoFASTQ FASTATOFASTQ
                        Input a FASTA file, convert to paired FASTQ files, and
                        run.
  -r [FASTA ...], --FASTA [FASTA ...]
                        FASTA file to be used as reference. Multiple can be
                        specified with wildcard
  -b [GBK ...], --gbk [GBK ...]
                        Optional: gbk to annotate VCF file. Multiple can be
                        specified with wildcard
  -t REFERENCE_TYPE, --reference_type REFERENCE_TYPE
                        Optional: Provide directory name with FASTA and GBK
                        file/s
  -p, --nanopore        if true run alignment optimized for nanopore reads
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Optional: Provide a name. This name will be a
                        directory output files are written to. Name can be a
                        directory path, but doesn't have to be.
  -assemble_unmap, --assemble_unmap
                        Optional: skip assembly of unmapped reads. See also
                        vsnp3_assembly.py
  -spoligo, --spoligo   Optional: get spoligotype if TB complex. See also
                        vsnp3_spoligotype.py
  -d, --debug           keep spades output directory
  -v, --version         show program's version number and exit

---------------------------------------------------------
```


## vsnp3_vsnp3_step2.py

### Tool Description
Store VCF files from vSNP step1 to step 2 directory. VCF files must be stored by reference type. Make a VCF file directory database that will build over time as samples are ran in step 1

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-wd WD] [-o OUTPUT_DIR] [-t REFERENCE_TYPE] [-b [GBK ...]]
            [-s DEFINING_SNPS] [-m METADATA] [-remove_by_name REMOVE_BY_NAME]
            [-n] [-w QUAL_THRESHOLD] [-x N_THRESHOLD] [-y MQ_THRESHOLD] [-f]
            [-k] [-a] [-i] [-abs_pos ABS_POS] [-group GROUP] [-hash]
            [--show_groups] [-html_tree] [-dp]
            [--density_threshold [DENSITY_THRESHOLD]]
            [--density_window [DENSITY_WINDOW]] [-d] [-v]

---------------------------------------------------------
Store VCF files from vSNP step1 to step 2 directory.  VCF files must be stored by reference type.  Make a VCF file directory database that will build over time as samples are ran in step 1

For example...
<path/to/files>
    referenceA_dir
        step1_dir
            sample1_dir
                <alignemnt_files>
            sample2_dir
                <alignemnt_files>
        step2_dir
            vcf_source_dir
                sample1.vcf
                sample2.vcf
            comparison1_dir
            comparison2_dir

<path/to/dependencies> (added path using vsnp3_path_adder.py)
    referenceA_dir
        defining_snps_for_referenceA.xlsx
        metadata_for_referenceA.xlsx
        FASTA/s for referenceA
        GBK/s for referenceA

When running samples through step 1 and 2 of vSNP, or when running a routine analysis, set up dependencies using vsnp3_path_adder.py.  See vsnp3_path_adder.py -h for adding a reference type and for more information

Usage:

vsnp3_step2.py -a -d -t ASFV_Georgia_2007

vsnp3_step2.py -wd <path/to/vcf_directory> -abs_pos chrom1:123456 -group test_group -m <path/to/metadata.xlsx>

vsnp3_step2.py -wd ../vcf_source

vsnp3_step2.py -a --remove

---------------------------------------------------------

options:
  -h, --help            show this help message and exit
  -wd WD, --wd WD       Optional: path to VCF files. By default .vcf in
                        current working directory are used.
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Optional: Provide a name. This name will be a
                        directory output files are writen to. Name can be a
                        directory path, but doesn't have to be. By default VCF
                        files are worked on in your current working directory
  -t REFERENCE_TYPE, --reference_type REFERENCE_TYPE
                        Optional: A valid reference_type name will be
                        automatically found, but a valid reference_type name
                        can be supplied. See vsnp3_path_adder.py -s
  -b [GBK ...], --gbk [GBK ...]
                        Optional: gbk to annotate VCF file. Multiple gbk files
                        can be specified with wildcard
  -s DEFINING_SNPS, --defining_snps DEFINING_SNPS
                        Optional: Defining SNPs with positions to filter. See
                        template_define_filter.xlsx in vsnp dependency folder.
                        Recommended having this file in reference type folder
  -m METADATA, --metadata METADATA
                        Optional: Two column Excel file, Column One: full VCF
                        file name, Column Two: Updated name. Recommended
                        having this file in reference type folder
  -remove_by_name REMOVE_BY_NAME, --remove_by_name REMOVE_BY_NAME
                        Optional: Excel file containing samples to remove from
                        analysis Column 1: to match sample name minus
                        extension. No header allowed. Recommended having this
                        file in reference type folder
  -n, --no_filters      Optional: turn off filters
  -w QUAL_THRESHOLD, --qual_threshold QUAL_THRESHOLD
                        Optional: Minimum QUAL threshold for calling a SNP
  -x N_THRESHOLD, --n_threshold N_THRESHOLD
                        Optional: Minimum N threshold. SNPs between this and
                        qual_threshold are reported as N
  -y MQ_THRESHOLD, --mq_threshold MQ_THRESHOLD
                        Optional: At least one position per group must have
                        this minimum MQ threshold to be called.
  -f, --fix_vcfs        Optional: Just fix VCF files and exit
  -k, --keep_ind_vcfs   Optional: Keep VCF files in current working directory
                        when VCF files in current working director are used,
                        VCF files are always saved and zipped in
                        "vcf_starting_files.zip".
  -a, --all_vcf         Optional: create table with all isolates
  -i, --find_new_filters
                        Optional: find new positions to apply to the filter
                        file. Positions must be manually added to filter file.
                        They are not added by running this command. Only text
                        files are output showing position detail. Curant
                        before adding filters
  -abs_pos ABS_POS, --abs_pos ABS_POS
                        Optional: Make a group on defining SNP. Must be
                        supplied with --group option. Format as chrom in VCF,
                        chrom:10000.
  -group GROUP, --group GROUP
                        Optional: Name a group on defining SNP. Must be
                        supplied with --abs_pos option
  -hash, --hash_groups  Optional: The option will run defining snps marked
                        with a # in the defining snps file. The # is removed
                        and the defining snps are run.
  --show_groups         Show group names in SNP table
  -html_tree, --html_tree
                        Optional: Generate HTML tree visualization
                        (automatically enables -dp)
  -dp, --dp             Optional: Include average depth of coverage in tables
  --density_threshold [DENSITY_THRESHOLD]
                        Optional: Minimum number of SNPs required to trigger
                        density filtering (default: 3)
  --density_window [DENSITY_WINDOW]
                        Optional: Window size in base pairs for density
                        filtering (default: 20)
  -d, --debug           Optional: Keep debugging files and run without
                        pooling. A pickle file will be kept for
                        troubleshooting to be used directly in
                        vsnp3_group_on_defining_snps.py. This saves processing
                        time
  -v, --version         show program's version number and exit

---------------------------------------------------------
```


## vsnp3_vsnp3_alignment_vcf.py

### Tool Description
Align reads to reference FASTA files, call variants, add zero coverage and write VCF, BAM and statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-n SAMPLE_NAME] -r1 FASTQ_R1 [-r2 FASTQ_R2] [-r [FASTA ...]]
            [-o] [-b [GBK ...]] [-assemble_unmap] [-d] [-v]

---------------------------------------------------------
Usage:
alignment_vcf.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz -r *fasta
alignment_vcf.py -r1 *fastq.gz -r *fasta
alignment_vcf.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz -r *fasta -g *gbk

options:
  -h, --help            show this help message and exit
  -n SAMPLE_NAME, --SAMPLE_NAME SAMPLE_NAME
                        Force output files to this sample name
  -r1 FASTQ_R1, --read1 FASTQ_R1
                        Required: single read, R1 when Illumina read
  -r2 FASTQ_R2, --read2 FASTQ_R2
                        Optional: R2 Illumina read
  -r [FASTA ...], --reference [FASTA ...]
                        FASTA file to be used as reference. Multiple can be
                        specified with wildcard
  -o, --nanopore        Beta, if true run alignment with minimap2 map-ont
                        option
  -b [GBK ...], --gbk [GBK ...]
                        Optional: gbk to annotate VCF file. Multiple can be
                        specified with wildcard
  -assemble_unmap, --assemble_unmap
                        skip assembly of unmapped reads
  -d, --debug           keep temp file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_annotation.py

### Tool Description
Annotate one SNP position from GenBank files; used by vSNP to annotate VCF files and SNP tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -g [GBK ...] -p ABS_POS [-s SNP_NT] [-v]

---------------------------------------------------------

Used by vSNP to annotate VCF files and SNP tables

options:
  -h, --help            show this help message and exit
  -g [GBK ...], --gbk [GBK ...]
                        Full path to .gbk files. Wildcard can be used
  -p ABS_POS, --abs_pos ABS_POS
                        Absolute position, example NC_017250.1:264518
  -s SNP_NT, --snp_nt SNP_NT
                        Position alt call, example T
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_assembly.py

### Tool Description
Wrapper script for SPAdes assembly with an Excel statistics summary.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-r1 FASTQ_R1] [-r2 FASTQ_R2] [-f FASTA] [-d] [-v]

---------------------------------------------------------
Wrapper script for SPAdes assembly.

Usage:

Single read:
vsnp3_assmbly.py -r1 *.fastq.gz

Paired reads:
vsnp3_assmbly.py -r1 *_R1*.fastq.gz -r2 *_R2*.fastq.gz

If just stats is needed:
vsnp3_assembly.py -f *fasta

Output:  pdf report and excel stat summary

options:
  -h, --help            show this help message and exit
  -r1 FASTQ_R1, --read1 FASTQ_R1
                        Required: single read, R1 when Illumina read
  -r2 FASTQ_R2, --read2 FASTQ_R2
                        Optional: R2 Illumina read
  -f FASTA, --fasta FASTA
                        provide assembly if just stats are needed. Assumed
                        SPAdes assembly
  -d, --debug           keep temp file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_best_reference_sourmash.py

### Tool Description
Find the best reference genome for reads with sourmash.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-n SAMPLE_NAME] [-r1 FASTQ_R1] [-d] [-v]

---------------------------------------------------------
Usage:
vsnp3_best_reference_sourmash.py -r1 *_R1*.fastq.gz

# Validation Notes:
 * Genomes that will automatically be found as best reference *
2021-05-06 Sourmash testing.
Brucella_abortus1 checked good
Brucella_abortus3 checked good
Brucella_canis checked good
Brucella_ceti1 checked good
Brucella_ceti2 checked good
Brucella_melitensis-bv1 checked good
Brucella_melitensis-bv1b checked good
Brucella_melitensis-bv2 checked good
Brucella_melitensis-bv3 checked good
Brucella_neotomae: Finds NC_017251 (suis1), Bceti1Cudo and neotomae at various same or wrong similarity
Brucella_ovis checked good
Brucella_suis1 checked good
Brucella_suis2 checked good
Brucella_suis3 checked good
Brucella_suis4: Finds canis and suis4 at the same similarity, sometimes canis more.

Mycobacterium_AF2122 checked
    # 2021-05-06 Current database does not have caprae, orygis, these were test as what-ifs.
    before adding caprae just barely fell into AF2122, orygis was a tie
    adding caprae finds caprae and still bovis and h37 correct
    adding orygis finds orygis and still bovis and h37 correct
Mycobacterium_H37 checked good
para-CP033688 checked good
para-NC002944 checked good

NC_045512_wuhan-hu-1 checked good

# Build database
for i in *fasta; do sourmash sketch dna $i --name-from-first; done
sourmash index ref_db.sbt.zip ./*.sig # this .zip will be placed as a dependency file, cp ref_db.sbt.zip ~/git/gitlab/dev_stuber/dependencies
# Prepare read
sourmash sketch dna *_R1*.fastq.gz
# Search 
sourmash search *_R1*.fastq.gz.sig ../sourmash/ref_db.sbt.zip -o sourmash_findings.csv --threshold=0.001

# Isolates used to build 2021-08-04 database
# Isolates saved to /Users/tstuber/OneDrive\ -\ USDA/vSNP/vsnp3/validation/sourmash_vsnp_2021-08-04_genomes

# TB complex lineage information
# Best reference will direct to either AF2122 or H37
NZ_CP041790 Lineage 1
NZ_CP022014 Lineage 2
NZ_CP041869 Lineage 2
NZ_CP041875 Lineage 3
CP023623 Lineage 4
CP023635 Lineage 4
NZ_CP041803 Lineage 7

options:
  -h, --help            show this help message and exit
  -n SAMPLE_NAME, --SAMPLE_NAME SAMPLE_NAME
                        Force output files to this sample name
  -r1 FASTQ_R1, --read1 FASTQ_R1
                        Required: single read, R1 when Illumina read
  -d, --debug           keep temp file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_bruc_mlst.py

### Tool Description
Find the Brucella MLST type from WGS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r1 READ1 [-r2 READ2] [-v]

---------------------------------------------------------
Based on https://bmcmicrobiol.biomedcentral.com/articles/10.1186/1471-2180-7-34

Brucella MLST from WGS sequence

options:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Required: single read
  -r2 READ2, --read2 READ2
                        Optional: paired read
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_download_GCA_fasta_get_metadata.py

### Tool Description
Use NCBI datasets to download GCF and GCA genomes with metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -a ACCESSION [-g] [-r] [-v] [-d]

---------------------------------------------------------
Uses NCBI's datasets v14 tool to download GCF and GCA genomes. 
This tool is considered alpha and will undergo changes.  As Feb 2023 it seems to work well for bacteria genomes, but seemed unpredictable for downloads not consistent with the GCA format.

GCA for GenBank assemblies and GCF for RefSeq assemblies.

https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/

GCA_000195835 # this is the type of number to feed script.
NC_002945.4 # will NOT work, see vsnp3_download_fasta_gbk_gff_by_acc.py

Usage:  module load datasets-14.12.0-gcc-9.2.0-46pggay
        vsnp3_download_GCA_fasta_get_metadata.py -a GCA_000195835 -gr

Metadata will be downloaded along with the genome.  Metadata will be placed into an Excel file to be manipulated and used later.  Files can be immediately renamed with metadata info using --rename option.

options:
  -h, --help            show this help message and exit
  -a ACCESSION, --accession ACCESSION
                        NCBI chromosome number -- GCA NUMBER, FASTA downloaded
  -g, --gfiles          download gff3 and gbk files
  -r, --rename          rename file with metadata
  -v, --version         show program's version number and exit
  -d, --debug           keep temp file

---------------------------------------------------------
```

## vsnp3_vsnp3_download_fasta_gbk_gff_by_acc.py

### Tool Description
Download a FASTA, GenBank or GFF file for a complete NCBI chromosome accession.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-a ACCESSION] [-f] [-b] [-g] [-v]

---------------------------------------------------------

Usage:
    fasta_gbk_gff_by_acc.py -a NC_002945 -f
    fasta_gbk_gff_by_acc.py -a NC_006932 -fg
    fasta_gbk_gff_by_acc.py -a NC_006933 -fbg
    fasta_gbk_gff_by_acc.py -a CP023243 -fbg
    fasta_gbk_gff_by_acc.py -a NZ_CP023243 -fbg
    **bad request: fasta_gbk_gff_by_acc.py -a NZ_AQME0000000 -fbg # must be complete chromosome

Search genomes: https://www.ncbi.nlm.nih.gov/genome

options:
  -h, --help            show this help message and exit
  -a ACCESSION, --accession ACCESSION
                        NCBI chromosome number
  -f, --fasta           get FASTA file
  -b, --gbk             get gbk file
  -g, --gff             get gff file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_excel_merge_defining_snps.py

### Tool Description
Merge two defining SNP Excel files and report the differences.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-f1 FILE1] [-f2 FILE2] [-v]

---------------------------------------------------------
Place description

options:
  -h, --help            show this help message and exit
  -f1 FILE1, --file1 FILE1
                        merge 1 file
  -f2 FILE2, --file2 FILE2
                        merge 2 file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_excel_merge_files.py

### Tool Description
Merge multiple Excel files into a single file in the same directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vsnp3_excel_merge_files.py [-h] [-i INPUT_DIR] [-p PATTERN]
                                  [--index-col INDEX_COL]
                                  [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Merge multiple Excel files into a single file in the same directory

options:
  -h, --help            show this help message and exit
  -i INPUT_DIR, --input-dir INPUT_DIR
                        Directory containing input Excel files (default: .)
  -p PATTERN, --pattern PATTERN
                        File pattern to match Excel files (e.g., '*.xlsx',
                        'data_*.xls') (default: *.xlsx)
  --index-col INDEX_COL
                        Column to use as index (use 'None' for no index)
                        (default: sample)
  --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging level (default: INFO)
```

## vsnp3_vsnp3_fasta_to_fastq.py

### Tool Description
Convert a FASTA file into paired-end FASTQ files with fake quality scores and set coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vsnp3_fasta_to_fastq.py [-h] -i INPUT [-c COVERAGE] [-l READ_LENGTH]
                               [-v]

Convert a FASTA file into paired-end FASTQ files with fake quality scores and
specific coverage. If FASTA is reporting ambiguity codes, they will be
replaced with representative mix of nucleotides.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input FASTA file
  -c COVERAGE, --coverage COVERAGE
                        Desired coverage (default: 100X)
  -l READ_LENGTH, --read_length READ_LENGTH
                        Read length (default: 150)
  -v, --version         show program's version number and exit
```

## vsnp3_vsnp3_fasta_to_snps_table.py

### Tool Description
Build a SNP table and RAxML tree from an aligned FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -f FASTA [-p] [--show_groups] [-n] [-d] [-v]

---------------------------------------------------------
Usage:
vsnp3_fasta_to_snps_table.py -f *fasta -pn
---------------------------------------------------------

options:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        Provide an alignment file in FASTA format
  -p, --parsimonious    Only keep parsimonious SNPs from FASTA alignment file.
                        This is different than the uninformative SNPs removed
                        via vSNP pipeline. This is to be used when just
                        working with an aligned FASTA file.
  --show_groups         Show group names in SNP table
  -n, --hash_names      Hash FASTA names to rid of any RAxML illegal
                        characters
  -d, --debug           Optional: Keep debugging files and run without pooling
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_fastq_stats_seqkit.py

### Tool Description
Calculate FASTQ statistics with seqkit.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vsnp3_fastq_stats_seqkit.py [-h] [-n SAMPLE_NAME] [-r1 FASTQ_R1]
                                   [-r2 FASTQ_R2] [-d] [-v]

---------------------------------------------------------
seqkit used to calculate FASTQ stats
https://bioinf.shenwei.me/seqkit/

Usage:
vsnp3_fastq_stats_seqkit.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz #paired
vsnp3_fastq_stats_seqkit.py -r1 *fastq.gz #single

options:
  -h, --help            show this help message and exit
  -n SAMPLE_NAME, --SAMPLE_NAME SAMPLE_NAME
                        Force output files to this sample name
  -r1 FASTQ_R1, --read1 FASTQ_R1
                        Required: single read, R1 when Illumina read
  -r2 FASTQ_R2, --read2 FASTQ_R2
                        Optional: R2 Illumina read
  -d, --debug           keep temp files
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_group_on_defining_snps.py

### Tool Description
Group samples on a defining SNP position and build tables and trees for the group.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-p PICKLE_FILE] [-b [GBK ...]] [-m METADATA]
            [-s DEFINING_SNPS] [-abs_pos ABS_POS] [-group GROUP]
            [-w QUAL_THRESHOLD] [-x N_THRESHOLD] [-y MQ_THRESHOLD]
            [-t REFERENCE_TYPE] [--filter_density]
            [--density_threshold DENSITY_THRESHOLD]
            [--density_window DENSITY_WINDOW] [-d] [-v]

---------------------------------------------------------
Usage:
vsnp3_group_on_defining_snps.py -p dictionary_of_dataframes.pickle -abs_pos NC_002945.4:1295549 -group test_group -m path/to/metadata.xlsx -b /path/to/*gbk

options:
  -h, --help            show this help message and exit
  -p PICKLE_FILE, --pickle_file PICKLE_FILE
                        Pickle file: dictionary of dataframes
  -b [GBK ...], --gbk [GBK ...]
                        Optional: gbk to annotate VCF file. Multiple can be
                        specified with wildcard
  -m METADATA, --metadata METADATA
                        Explicit metadata file. Two column Excel file -->
                        Column One: VCF file name, Column Two: Updated name
  -s DEFINING_SNPS, --defining_snps DEFINING_SNPS
                        Defining SNPs with positions to filter. See
                        template_define_filter.xlsx
  -abs_pos ABS_POS, --abs_pos ABS_POS
                        Must be supplied with --group option. Format as chrom
                        in VCF, likely chrom:10000... NC_002945.4:2138896.
                        Run: `vsnp3_step2.py --wd ../original -da` to obtain
                        pickle for entire set, isolate pickle file and run
                        `vsnp3_group_on_defining_snps.py -p
                        dictionary_of_dataframes.pickle -a
                        NC_002945.4:1295549`
  -group GROUP, --group GROUP
                        Must be supplied with --abs_pos option
  -w QUAL_THRESHOLD, --qual_threshold QUAL_THRESHOLD
                        Optional: Minimum QUAL threshold for calling a SNP
  -x N_THRESHOLD, --n_threshold N_THRESHOLD
                        Optional: Minimum N threshold. SNPs between this and
                        qual_threshold are reported as N
  -y MQ_THRESHOLD, --mq_threshold MQ_THRESHOLD
                        Optional: At least one position per group must have
                        this minimum MQ threshold to be called.
  -t REFERENCE_TYPE, --reference_type REFERENCE_TYPE
                        Reference type group/directory with dependencies
  --filter_density      Optional: Remove SNPs when density threshold is
                        exceeded within specified window size
  --density_threshold DENSITY_THRESHOLD
                        Optional: Minimum number of SNPs required to trigger
                        density filtering (default: 3)
  --density_window DENSITY_WINDOW
                        Optional: Window size in base pairs for density
                        filtering (default: 20)
  -d, --debug           Optional: Keep debugging files and run without pooling
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_group_reporter.py

### Tool Description
Report the defining-SNP groups of a VCF file (used by vsnp3 step 1).

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -vcf VCF -r REFERENCE_TYPE [-v]

---------------------------------------------------------

Used by vsnp3 step 1 to report on group

options:
  -h, --help            show this help message and exit
  -vcf VCF, --vcf VCF   Required: vcf file
  -r REFERENCE_TYPE, --reference_type REFERENCE_TYPE
                        Provide reference option. See vsnp3_path_adder.py -s
                        for options
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_html_tree.py

### Tool Description
Create an interactive phylogenetic tree from an SNP alignment Excel file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vsnp3_html_tree.py [-h] -f FILE [-o OUTPUT] [-b BOOTSTRAP]

Create interactive phylogenetic tree from SNP alignment

options:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Input Excel file containing SNP alignment
  -o OUTPUT, --output OUTPUT
                        Output HTML file name (default: phylo_tree.html)
  -b BOOTSTRAP, --bootstrap BOOTSTRAP
                        Number of bootstrap replicates (default: 100)
```

## vsnp3_vsnp3_kernel_plots.py

### Tool Description
Make a SNP distance kernel density plot or histogram from an alignment FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
The script cannot start in this image (ModuleNotFoundError: No module named 'seaborn'), so no help text can be printed.
Options read from the script source (argparse):
  -f FASTA, --fasta FASTA            Alignment FASTA (required)
  -n SAMPLE_NAME, --sample_name      Force a sample name
  -xh XLIM_LOW, --xlim_low           Lower limit of the x-axis
  -yh XLIM_HIGH, --xlim_high         Upper limit of the x-axis
  -bm BIN_MAX, --bin_max             Max y length
  -bi BIN_INCREMENT, --bin_increment Bin increment for histogram
  -c COLOR, --color                  Color of the kernel density plot
  -g, --histogram                    Generate histogram instead of kernel density plot
  -d, --debug                        Keep temp files for debugging
```

## vsnp3_vsnp3_kraken2_wrapper.py

### Tool Description
Run kraken2 on a FASTA, single FASTQ or paired FASTQ files and make a Krona chart.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-f FASTA] [-r1 FASTQ_R1] [-r2 FASTQ_R2] [-d DIRECTORY] [-c]
            --database DATABASE

---------------------------------------------------------
Provide either a single FASTA file, single FASTQ or Paired files.
Usage:
    kraken2_run.py -r1 *_R1*fastg.gz
    kraken2_run.py -r1 *_R1*fastg.gz -r2 *_R2*fastq.gz -d
    kraken2_run.py -f *fasta

options:
  -h, --help            show this help message and exit
  -f FASTA, --FASTA FASTA
                        Provide FASTA file
  -r1 FASTQ_R1, --FASTQ_R1 FASTQ_R1
                        Provide R1 FASTQ gz file, or single read
  -r2 FASTQ_R2, --FASTQ_R2 FASTQ_R2
                        Provide R2 FASTQ gz file
  -d DIRECTORY, --directory DIRECTORY
                        Put output to directory
  -c, --db_contents     Show contents of DB by printing README
  --database DATABASE   Absolute path to database directory

---------------------------------------------------------
```

## vsnp3_vsnp3_remove_from_analysis.py

### Tool Description
Delete the VCF files listed in an Excel file from the working directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r EXCEL_REMOVE [-w WORKING_DIRECTORY] [-e EXTENSION] [-v]

---------------------------------------------------------

Script is called by vSNP step 2

Provide an Excel file with single column listing VCF file to remove from analysis.  This is convenient for controlling samples that may or may not be helpful in a comparison.  See it as a way to add or remove isolates without disrupting your VCF file database directory

File names listed in the first column of the remove_from_analysis.xlsx can have extension, or the extension will be added (default .vcf).  Also _zc.vcf will be looked for and removed.

options:
  -h, --help            show this help message and exit
  -r EXCEL_REMOVE, --excel_remove EXCEL_REMOVE
                        Excel file containing samples to remove from analysis.
                        Column 1: to match sample name minus extension. No
                        header allowed
  -w WORKING_DIRECTORY, --cwd WORKING_DIRECTORY
                        Optional: path to VCF files
  -e EXTENSION, --extension EXTENSION
                        File extension type to be renamed
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_spoligotype.py

### Tool Description
Find the Mycobacterium bovis spoligotype from WGS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-n SAMPLE_NAME] -r1 FASTQ_R1 [-r2 FASTQ_R2] [-d] [-v]

---------------------------------------------------------

Mycobacterium bovis spoligotype from WGS

options:
  -h, --help            show this help message and exit
  -n SAMPLE_NAME, --SAMPLE_NAME SAMPLE_NAME
                        Force output files to this sample name
  -r1 FASTQ_R1, --FASTQ_R1 FASTQ_R1
                        Required: single read
  -r2 FASTQ_R2, --FASTQ_R2 FASTQ_R2
                        Optional: paired read
  -d, --debug           turn off map.pooling of samples
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_table_compare.py

### Tool Description
Compare two vSNP SNP tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -t1 TABLE1 -t2 TABLE2 [-v]

---------------------------------------------------------
Place description

options:
  -h, --help            show this help message and exit
  -t1 TABLE1, --table1 TABLE1
                        Provide a vSNP SNP Table
  -t2 TABLE2, --table2 TABLE2
                        Provide a vSNP SNP Table
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_vcf_annotation.py

### Tool Description
Annotate a VCF file with GenBank gene information.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-b [GBK_LIST ...]] -c VCF [-v]

---------------------------------------------------------
Annotate VCF file

Usage:
vsnp3_vcf_annotation.py -b *.gbk -c *.vcf

Give wildcard when more than one *.gbk

options:
  -h, --help            show this help message and exit
  -b [GBK_LIST ...], --gbk_list [GBK_LIST ...]
                        Optional: gbk to annotate VCF file. Multiple can be
                        specified with wildcard
  -c VCF, --vcf VCF     Provide VCF file, Return VCF annotated
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_vcf_merge_to_fasta.py

### Tool Description
Merge VCF SNPs into the FASTA reference sequence the VCF was made from.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -v VCF -f FASTA [-x QUAL_THRESHOLD] [-y MQ_THRESHOLD]
            [-z AC_THRESHOLD] [-i] [--version]

---------------------------------------------------------
Merge VCF SNPs into a FASTA reference sequence
This script takes a VCF file and the FASTA file that was used
to generate it, and creates a new FASTA file with the variants
from the VCF incorporated into the reference sequence.

options:
  -h, --help            show this help message and exit
  -v VCF, --vcf VCF     Required: VCF file will be merged into FASTA file it
                        was made from
  -f FASTA, --fasta FASTA
                        Required: FASTA used to build the VCF file
  -x QUAL_THRESHOLD, --qual_threshold QUAL_THRESHOLD
                        Optional: Minimum QUAL threshold for using a SNP
                        (default: 300)
  -y MQ_THRESHOLD, --mq_threshold MQ_THRESHOLD
                        Optional: Minimum MQ threshold for using a SNP
                        (default: 56)
  -z AC_THRESHOLD, --ac AC_THRESHOLD
                        Optional: Minimum AC threshold for using a SNP
                        (default: 1)
  -i, --indels          Optional: Include indels
  --version             show program's version number and exit

---------------------------------------------------------
```

## vsnp3_vsnp3_zero_coverage.py

### Tool Description
Add zero coverage positions to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
- **Homepage**: https://github.com/USDA-VS/vsnp3
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r FASTA [-b BAM] [-c VCF] [-d] [-v]

---------------------------------------------------------
Add zero coverage positions to VCF file

Usage:
vsnp3_zero_coverage.py -r *fasta -b *_nodup.bam -c *vcf

If multiple FASTAs were used the concatenated FASTA to build alignment is needed

options:
  -h, --help            show this help message and exit
  -r FASTA, --reference FASTA
                        Reference used to build alignment
  -b BAM, --bam BAM     bam file used to make VCF
  -c VCF, --vcf VCF     VCF file
  -d, --debug           keep temp file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## Metadata
- **Skill**: generated
