# cat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cat_add_names | PASS |  |
| cat_bins | PASS | Ran BAT on a bin made of the CAT_pack repository test contigs with a database built from the repository test proteins; the bin gets the expected class_3 lineage. |
| cat_contigs | PASS |  |
| cat_download | Not completed | Downloads and preprocesses the full NCBI nr or GTDB database (tens to hundreds of GB), too large for this test. |
| cat_prepare | PASS |  |
| cat_reads | PASS | Synthetic data: reads simulated from the CAT_pack repository test contigs; read counts per contig (300 and 591) match the simulated reads and lineages match CAT. |
| cat_summarise | PASS |  |

## cat_download

### Tool Description
Download and preprocess sequence and taxonomy information from NCBI nr or GTDB.

### Metadata
- **Docker Image**: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
- **Homepage**: https://github.com/MGXlab/CAT_pack
- **Package**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Total Downloads**: 58.2K
- **GitHub**: https://github.com/MGXlab/CAT_pack

### Original Help Text
```text
usage: CAT_pack download --db (nr | GTDB) -o DIR [options] [-h / --help]

Download and preprocess sequence and taxonomy information. Currently supports
the NCBI non-redundant (nr) database and the GTDB database.

Required arguments:
  --db               Either nr or GTDB.
  -o, --output_dir   Path to directory where data will be stored.

Optional arguments:
  --cleanup          Remove unnecessary files after all data have been
                     processed.
  -q, --quiet        Suppress verbosity.
  --no_log           Suppress log file.
  -h, --help         Show this help message and exit.
```

## cat_prepare

### Tool Description
Construct CAT/BAT/RAT database files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
- **Homepage**: https://github.com/MGXlab/CAT_pack
- **Package**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Total Downloads**: 58.2K
- **GitHub**: https://github.com/MGXlab/CAT_pack

### Original Help Text
```text
usage: CAT_pack prepare --db_fasta FILE --acc2tax FILE --names FILE --nodes FILE --db_dir DIR [options] [-h / --help]

Construct CAT/BAT/RAT database files.

Required arguments:
  --db_fasta          Path to fasta file containing all sequences.
  --names             Path to names.dmp
  --nodes             Path to nodes.dmp
  --acc2tax           Path to accession2taxid.txt file. Can be gzipped.
  --db_dir            Path to directory where CAT/BAT/RAT database files will
                      be created.

Optional arguments:
  --path_to_diamond   Path to DIAMOND binaries. Supply if CAT/BAT/RAT cannot
                      find DIAMOND.
  --common_prefix     Prefix for all files to be created.
  -q, --quiet         Suppress verbosity.
  --verbose           Increase verbosity.
  --no_log            Suppress log file.
  -h, --help          Show this help message and exit.

DIAMOND specific optional arguments:
  -n, --nproc         Number of cores to deploy by DIAMOND (default: maximum).
```

## cat_contigs

### Tool Description
Run Contig Annotation Tool (CAT).

### Metadata
- **Docker Image**: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
- **Homepage**: https://github.com/MGXlab/CAT_pack
- **Package**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Total Downloads**: 58.2K
- **GitHub**: https://github.com/MGXlab/CAT_pack

### Original Help Text
```text
usage: CAT_pack contigs -c FILE -d DIR -t DIR [options] [-h / --help]

Run Contig Annotation Tool (CAT).

Required arguments:
  -c, --contigs_fasta   Path to contigs fasta file.
  -d, --database_folder 
                        Path to directory that contains database files.
  -t, --taxonomy_folder 
                        Path to directory that contains taxonomy files.

Optional arguments:
  -r, --range           r parameter [0-100] (default: 10).
  -f, --fraction        f parameter [0-0.99] (default: 0.50).
  -o, --out_prefix      Prefix for output files (default: ./out.CAT).
  -p, --proteins_fasta 
                        Path to predicted proteins fasta file. If supplied,
                        the protein prediction step is skipped.
  -a, --diamond_alignment 
                        Path to alignment table. If supplied, the alignment
                        step is skipped and classification is carried out
                        directly. A predicted proteins fasta file should also
                        be supplied with argument [-p / --proteins].
  --path_to_prodigal    Path to Prodigal binaries. Supply if CAT/BAT/RAT
                        cannot find Prodigal
  --path_to_diamond     Path to DIAMOND binaries. Supply if CAT/BAT/RAT cannot
                        find DIAMOND.
  --no_stars            Suppress marking of suggestive taxonomic assignments.
  --force               Force overwrite existing files.
  -q, --quiet           Suppress verbosity.
  --verbose             Increase verbosity.
  --no_log              Suppress log file.
  -h, --help            Show this help message and exit.
  --I_know_what_Im_doing
                        Flag for experimental features.

DIAMOND specific optional arguments:
  -n, --nproc           Number of cores to deploy by DIAMOND (default:
                        maximum).
  --sensitive           Run DIAMOND in sensitive mode (default: not enabled).
  --no_self_hits        Do not report identical self hits by DIAMOND (default:
                        not enabled).
  --block_size          DIAMOND block-size parameter (default: 12.0). Lower
                        numbers will decrease memory and temporary disk space
                        usage.
  --index_chunks        DIAMOND index-chunks parameter (default: 1). Set to 4
                        on low memory machines. The parameter has no effect on
                        temporary disk space usage.
  --tmpdir              Directory for temporary DIAMOND files (default:
                        directory to which output files are written).
  --compress            Compress DIAMOND alignment file (default: not
                        enabled).
  --top                 DIAMOND top parameter [0-100] (default: 11). Governs
                        hits within range of best hit that are written to the
                        alignment file. This is not the [-r / --range]
                        parameter! See README.md.
```

## cat_bins

### Tool Description
Run Bin Annotation Tool (BAT).

### Metadata
- **Docker Image**: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
- **Homepage**: https://github.com/MGXlab/CAT_pack
- **Package**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Total Downloads**: 58.2K
- **GitHub**: https://github.com/MGXlab/CAT_pack

### Original Help Text
```text
usage: CAT_pack bins -b DIR / FILE -d DIR -t DIR [options] [-h / --help]

Run Bin Annotation Tool (BAT).

Required arguments:
  -b, --bin_fasta, --bin_folder 
                        Path to bin fasta file or to directory containing
                        bins.
  -d, --database_folder 
                        Path to directory that contains database files.
  -t, --taxonomy_folder 
                        Path to directory that contains taxonomy files.

Optional arguments:
  -s, --bin_suffix      Suffix of bins in bin directory (default: .fna).
  -r, --range           r parameter [0-100] (default: 5).
  -f, --fraction        f parameter [0-0.99] (default: 0.30).
  -o, --out_prefix      Prefix for output files (default: ./out.BAT).
  -p, --proteins_fasta 
                        Path to predicted proteins fasta file. If supplied,
                        the protein prediction step is skipped.
  -a, --diamond_alignment 
                        Path to alignment table. If supplied, the alignment
                        step is skipped and classification is carried out
                        directly. A predicted proteins fasta file should also
                        be supplied with argument [-p / --proteins].
  --path_to_prodigal    Path to Prodigal binaries. Supply if CAT/BAT/RAT
                        cannot find Prodigal
  --path_to_diamond     Path to DIAMOND binaries. Supply if CAT/BAT/RAT cannot
                        find DIAMOND.
  --no_stars            Suppress marking of suggestive taxonomic assignments.
  --force               Force overwrite existing files.
  -q, --quiet           Suppress verbosity.
  --verbose             Increase verbosity.
  --no_log              Suppress log file.
  -h, --help            Show this help message and exit.
  --I_know_what_Im_doing
                        Flag for experimental features.

DIAMOND specific optional arguments:
  -n, --nproc           Number of cores to deploy by DIAMOND (default:
                        maximum).
  --sensitive           Run DIAMOND in sensitive mode (default: not enabled).
  --no_self_hits        Do not report identical self hits by DIAMOND (default:
                        not enabled).
  --block_size          DIAMOND block-size parameter (default: 12.0). Lower
                        numbers will decrease memory and temporary disk space
                        usage.
  --index_chunks        DIAMOND index-chunks parameter (default: 1). Set to 4
                        on low memory machines. The parameter has no effect on
                        temporary disk space usage.
  --tmpdir              Directory for temporary DIAMOND files (default:
                        directory to which output files are written).
  --compress            Compress DIAMOND alignment file (default: not
                        enabled).
  --top                 DIAMOND top parameter [0-100] (default: 11). Governs
                        hits within range of best hit that are written to the
                        alignment file. This is not the [-r / --range]
                        parameter! See README.md.
```

## cat_reads

### Tool Description
Run Read Annotation Tool (RAT).

### Metadata
- **Docker Image**: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
- **Homepage**: https://github.com/MGXlab/CAT_pack
- **Package**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Total Downloads**: 58.2K
- **GitHub**: https://github.com/MGXlab/CAT_pack

### Original Help Text
```text
usage: CAT_pack reads -c -t [options] [-h / --help]

Complete RAT workflow (perform read mapping, run CAT, BAT, and RAT): Supply contigs, reads, database folder, taxonomy folder, and bin folder.

Partial workflows:
If you have already mapped your reads, you can supply the sorted mapping file and no read mapping will be performed.
If you have already run CAT and/or BAT, you can supply the output files (contig2classification, bin2classification) and the path to the taxonomy folder instead.
If you prefer not to use bin classification, do not supply the path to a bin folder.

Run Read Annotation Tool (RAT).

Required arguments:
  -c, --contigs_fasta   Path to contigs fasta file.
  -t, --taxonomy_folder 
                        Path to directory that contains taxonomy files.
  -m, --mode            classification mode. "mcr": integrate annotations from
                        MAGs, contigs, and reads; "cr": integrate annotations
                        from contigs and reads; "mr": integrate annotations
                        from MAGs and reads.

Optional arguments:
  -o, --out_prefix      Prefix for output files (default: ./out.RAT).
  -1, --read_file1      Path to (forward) read file. Please note that RAT does
                        not currently support interlaced read files. Please
                        supply a single read file or two files for paired-end
                        reads.
  -2, --read_file2      Path to reverse read file.
  --bam1                Path to sorted mapping file.
  --bam2                Path to second sorted mapping file (not recommended).
  --alignment_unmapped 
                        Path to alignment file of reads and contigs that
                        couldnot be classified by CAT/BAT.
  -b, --bin_fasta, --bin_folder 
                        Path to bin fasta file or to directory containing
                        bins.
  -s, --bin_suffix      Suffix of bins in bin directory (default: None).
  --c2c                 Path to contig2classification file.
  --b2c                 Path to bin2classification file.
  --read2classification
                        Includes read classification step.
  --u2c                 Path to bin2classification file.
  --mapping_quality     Minimum mapping quality phred score (default: 2)
  --path_to_bwa         Path to bwa binaries. Supply if RAT cannot find bwa.
  --path_to_samtools    Path to samtools binaries. Supply if RAT cannot find
                        samtools.
  --force               Force overwrite existing files.
  -q, --quiet           Suppress verbosity.
  --verbose             Increase verbosity.
  --no_log              Suppress log file.
  -h, --help            Show this help message and exit.
  -p, --proteins_fasta 
                        Path to predicted proteins fasta file. If supplied,
                        the protein prediction step is skipped.
  -a, --diamond_alignment 
                        Path to alignment table. If supplied, the alignment
                        step is skipped and classification is carried out
                        directly. A predicted proteins fasta file should also
                        be supplied with argument [-p / --proteins].

CAT/BAT-specific arguments:
  -d, --database_folder 
                        Path to directory that contains database files.
  -r, --range           r parameter [0-100] (default: 10).
  -f, --fraction        f parameter [0-0.99] (default: 0.50).
  --path_to_prodigal    Path to Prodigal binaries. Supply if CAT/BAT/RAT
                        cannot find Prodigal
  --path_to_diamond     Path to DIAMOND binaries. Supply if CAT/BAT/RAT cannot
                        find DIAMOND.
  --no_stars            Suppress marking of suggestive taxonomic assignments.
  --I_know_what_Im_doing
                        Flag for experimental features.

DIAMOND specific optional arguments:
  -n, --nproc           Number of cores to deploy by DIAMOND (default:
                        maximum).
  --sensitive           Run DIAMOND in sensitive mode (default: not enabled).
  --no_self_hits        Do not report identical self hits by DIAMOND (default:
                        not enabled).
  --block_size          DIAMOND block-size parameter (default: 12.0). Lower
                        numbers will decrease memory and temporary disk space
                        usage.
  --index_chunks        DIAMOND index-chunks parameter (default: 1). Set to 4
                        on low memory machines. The parameter has no effect on
                        temporary disk space usage.
  --tmpdir              Directory for temporary DIAMOND files (default:
                        directory to which output files are written).
  --compress            Compress DIAMOND alignment file (default: not
                        enabled).
  --top                 DIAMOND top parameter [0-100] (default: 11). Governs
                        hits within range of best hit that are written to the
                        alignment file. This is not the [-r / --range]
                        parameter! See README.md.
```

## cat_add_names

### Tool Description
Add taxonomic names to CAT, BAT, or RAT output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
- **Homepage**: https://github.com/MGXlab/CAT_pack
- **Package**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Total Downloads**: 58.2K
- **GitHub**: https://github.com/MGXlab/CAT_pack

### Original Help Text
```text
usage: CAT_pack add_names -i FILE -o FILE -t DIR [options] [-h / --help]

Add taxonomic names to CAT, BAT, or RAT output files.

Required arguments:
  -i, --input_file      Path to input file. Can be classification or ORF2LCA
                        output file from CAT, BAT or RAT.
  -o, --output_file     Path to output file.
  -t, --taxonomy_folder 
                        Path to directory that contains taxonomy files.

Optional arguments:
  --only_official       Only output official raxonomic ranks (superkingdom,
                        phylum, class, order, family, genus, species).
  --exclude_scores      Do not include bit-score support scores in the lineage
                        of a classification output file.
  --force               Force overwrite existing files.
  -q, --quiet           Suppress verbosity.
  -h, --help            Show this help message and exit.
```

## cat_summarise

### Tool Description
Summarise a named CAT or BAT classification file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
- **Homepage**: https://github.com/MGXlab/CAT_pack
- **Package**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cat/overview
- **Total Downloads**: 58.2K
- **GitHub**: https://github.com/MGXlab/CAT_pack

### Original Help Text
```text
usage: CAT_pack summarise -i FILE -o FILE (-c FILE) [options] [-h / --help]

Summarise a named CAT or BAT classification file.

Required arguments:
  -i, --input_file      Path to named CAT contig classification file or BAT
                        bin classification file. Currently only official ranks
                        are supported, and only classification files
                        containing a single classification per contig / bin.
                        If you want to summarise a contig classification file,
                        you have to supply the contigs fasta file with
                        argument [-c / --contigs_fasta].
  -o, --output_file     Path to output file.

Optional arguments:
  -c, --contigs_fasta   Path to contigs fasta file. Required if you want to
                        summarise a contig classification file.
  --force               Force overwrite existing files.
  -q, --quiet           Suppress verbosity.
  -h, --help            Show this help message and exit.
```

## Metadata
- **Skill**: generated

