# vsnp3 CWL Generation Report

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

