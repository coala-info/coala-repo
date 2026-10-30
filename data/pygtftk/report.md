# pygtftk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pygtftk_add_exon_nb | PASS |  |
| pygtftk_add_prefix | PASS |  |
| pygtftk_apropos | PASS | stdout starts with 4 harmless tabulate warning lines from the image; related command list is correct |
| pygtftk_bed_to_gtf | PASS |  |
| pygtftk_bigwig_to_bed | Failed | tool bug: --outputfile is opened read-only so it always errors; stdout, the only working output, starts with 4 tabulate error lines from the image |
| pygtftk_closest_genes | PASS |  |
| pygtftk_col_from_tab | PASS |  |
| pygtftk_convergent | PASS |  |
| pygtftk_convert | PASS |  |
| pygtftk_convert_ensembl | PASS |  |
| pygtftk_count | PASS |  |
| pygtftk_count_key_values | PASS |  |
| pygtftk_coverage | PASS |  |
| pygtftk_del_attr | PASS |  |
| pygtftk_discretize_key | Failed | image problem: default mode (no --labels) crashes with pandas 2 "can't set attribute"; works only when --labels is given |
| pygtftk_divergent | PASS |  |
| pygtftk_exon_sizes | PASS |  |
| pygtftk_feature_size | PASS |  |
| pygtftk_get_5p_3p_coords | PASS |  |
| pygtftk_get_attr_list | PASS |  |
| pygtftk_get_attr_value_list | PASS |  |
| pygtftk_get_ceas_records | PASS | synthetic data: small CEAS-style sqlite built from simple.gtf (no real CEAS file available); GTF-like records written correctly |
| pygtftk_get_feat_seq | PASS |  |
| pygtftk_get_feature_list | PASS |  |
| pygtftk_great_reg_domains | PASS |  |
| pygtftk_get_example | PASS |  |
| pygtftk_get_tx_seq | PASS |  |
| pygtftk_intergenic | PASS |  |
| pygtftk_intron_sizes | PASS |  |
| pygtftk_intronic | PASS |  |
| pygtftk_join_attr | PASS |  |
| pygtftk_join_multi_file | PASS |  |
| pygtftk_merge_attr | PASS |  |
| pygtftk_midpoints | PASS |  |
| pygtftk_mk_matrix | Failed | image problem: gtftk crashes in the default mode (pandas 2.3.1 rejects the positional axis in DataFrame.drop in mk_matrix.py line 503). |
| pygtftk_nb_exons | PASS |  |
| pygtftk_nb_transcripts | PASS |  |
| pygtftk_ologram_merge_runs | PASS |  |
| pygtftk_ologram_modl_treeify | PASS |  |
| pygtftk_overlapping | PASS |  |
| pygtftk_random_list | PASS |  |
| pygtftk_random_tx | PASS |  |
| pygtftk_rm_dup_tss | PASS |  |
| pygtftk_select_by_go | PASS | needs network (Ensembl BioMart); tested on mini_real example GTF, 63 genes selected. |
| pygtftk_select_by_intron_size | PASS |  |
| pygtftk_select_by_key | PASS |  |
| pygtftk_select_by_loc | PASS |  |
| pygtftk_select_by_max_exon_nb | PASS |  |
| pygtftk_select_by_nb_exon | PASS |  |
| pygtftk_select_by_numeric_value | PASS |  |
| pygtftk_select_by_regexp | PASS |  |
| pygtftk_select_by_tx_size | PASS |  |
| pygtftk_select_most_5p_tx | PASS |  |
| pygtftk_seqid_list | PASS |  |
| pygtftk_shift | PASS |  |
| pygtftk_short_long | PASS |  |
| pygtftk_splicing_site | PASS |  |
| pygtftk_tabulate | PASS |  |
| pygtftk_tss_dist | PASS |  |
| pygtftk_tss_numbering | PASS |  |

## pygtftk_get_example

### Tool Description
Print example files including GTF.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
  Usage: gtftk get_example [-d {simple,mini_real,mini_real_noov_rnd_tx,tiny_real,hg38_chr1,simple_02,simple_03,simple_04,simple_05,simple_06,simple_07,mini_real_10M,control_list,ologram_1,ologram_2,mini_real_ens}] [-f {*,gtf,bed,bw,bam,join,join_mat,chromInfo,tsv,fa,fa.idx,genes,geneList,2.bw,genome}] [-o OUTPUT] [-l] [-a] [-q] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Print example files including GTF.

  Notes:
     *  Use format '*' to get all files from a dataset.

Arguments:
 -d, --dataset                Select a dataset. (default: simple)
 -f, --format                 The dataset format. (default: gtf)
 -o, --outputfile             Output file. (default: <stdout>)
 -l, --list                   Only list files of a dataset. (default: False)
 -a, --all-dataset            Get the list of all datasets. (default: False)
 -q, --quiet                  Don't write any message when copying files. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```


## pygtftk_get_tx_seq

### Tool Description
Get transcripts sequences in a flexible fasta format from a GTF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
  Usage: gtftk get_tx_seq [-i GTF] [-o FASTA] -g FASTA [-w] [-s SEP] [-l label] [-f] [-d] [-a assembly] [-c] [-n] [-e] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get transcripts sequences in a flexible fasta format from a GTF file.

  Notes:
     *  The sequences are returned in 5' to 3' orientation.
     *  If you want to use wildcards, use quotes :e.g. 'foo/bar*.fa'.
     *  The first time a genome is used, an index (*.fa.gtftk) will be created in ~/.gtftk.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output FASTA file. (default: <stdout>)
 -g, --genome                 The genome in fasta format. Accept path with wildcards (e.g. *.fa). (default: None)
 -w, --with-introns           Set to true to include intronic regions. (default: False)
 -s, --separator              To separate info in header. (default: |)
 -l, --label                  A set of key for the header. (default: feature,transcript_id,gene_id,seqid,start,end)
 -f, --sleuth-format          Produce output in sleuth format (still experimental). (default: False)
 -d, --delete-version         In case of --sleuth-format, delete gene_id or transcript_id version number (e.g '.2' in ENSG56765.2). (default: False)
 -a, --assembly               In case of --sleuth-format, an assembly version. (default: GRCm38)
 -c, --del-chr                When using --sleuth-format delete 'chr' in sequence id. (default: False)
 -n, --no-rev-comp            Don't reverse complement sequence corresponding to gene on minus strand. (default: False)
 -e, --explicit               Write explicitly the name of the keys in the header. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```


## pygtftk_add_exon_nb

### Tool Description
Add exon number transcript-wise (based on 5' to 3' orientation).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk add_exon_nb [-i GTF] [-o GTF] [-k exon_numbering_key] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Add exon number transcript-wise (based on 5' to 3' orientation).

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --exon-numbering-key     The name of the key containing the exon numbering. (default: exon_nbr)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_add_prefix

### Tool Description
Add a prefix to target values. By default add 'chr' to seqid/chromosome key.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk add_prefix [-i GTF] [-o GTF] [-k KEY] [-t TEXT] [-s] [-f target_feature] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Add a prefix to target values. By default add 'chr' to seqid/chromosome key.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key                    The name of the attribute for which a prefix/suffix is to be added to the corresponding values (e.g, gene_id, transcript_id...). (default: chrom)
 -t, --text                   The character string to add as a prefix to the values. (default: chr)
 -s, --suffix                 The character string to add as a prefix to the values. (default: False)
 -f, --target-feature         The name of the target feature. (default: *)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_apropos

### Tool Description
Search in all command description files those related to a user-defined keyword.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk apropos -k keyword [-n] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Search in all command description files those related to a user-defined keyword.

Arguments:
 -k, --keyword                The keyword (default: None)
 -n, --notes                  Look also for the keywords in notes associated to each command. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_bed_to_gtf

### Tool Description
Convert a bed file to a gtf. This will make the poor bed feel as if it was a big/fat gtf (but with lots of empty fields...sniff). May be helpful sometimes...

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk bed_to_gtf [-i BED] [-o GTF] [-t ft_type] [-s source] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Convert a bed file to a gtf. This will make the poor bed feel as if it was a big/fat gtf (but with
     lots of empty fields...sniff). May be helpful sometimes...

Arguments:
 -i, --inputfile              Path to the poor BED file to would like to behave as if it was a GTF. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -t, --ft-type                The type of features you are trying to mimic... (default: transcript)
 -s, --source                 The source of annotation. (default: Unknown)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_bigwig_to_bed

### Tool Description
Convert a bigwig to a BED3 format by selecting regions based on a boolean expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk bigwig_to_bed [-i inputfile] [-o outputfile] [-c [chrom_list ...]] -e expression [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Convert a bigwig to a BED3 format by selecting regions based on a boolean expression.

Arguments:
 -i, --inputfile              Path to the bigwig file (default: None)
 -o, --outputfile             The output BED file. (default: <stdout>)
 -c, --chrom-list             The list of chromosomes of interest. (default: None)
 -e, --expression             A boolean expression where s is the signal (e.g; s > 0 and s < 0.5). (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_closest_genes

### Tool Description
Find the n closest genes for each genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk closest_genes [-i GTF] [-o GTF/TXT] [-r {tss,tts,gene}] [-nb nb_neighbors] [-t {tss,tts,gene}] [-s] [-S] [-f] [-H] [-k] [-id {gene_id,gene_name}] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Find the n closest genes for each genes.

  Notes:
     *  The reference region for each gene can be the TSS (the most 5'), the TTS (The most 3') or
     the whole gene.
     *  The reference region for each closest gene can be the TSS, the whole gene or the TTS.
     *  The closest genes can be searched in a stranded or unstranded fashion.

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)

Arguments:
 -r, --from-region-type       What is region to consider for each gene. (default: tss)
 -nb, --nb-neighbors          The size of the neighborhood. (default: 1)
 -t, --to-region-type         What is region to consider for each closest gene. (default: tss)
 -s, --same-strandedness      Require same strandedness (default: False)
 -S, --diff-strandedness      Require different strandedness (default: False)
 -f, --text-format            Return a text format. (default: False)
 -H, --no-header              Don't print the header line. (default: False)
 -k, --collapse               Unwrap. Don't use comma. Print closest genes line by line. (default: False)
 -id, --identifier            The key used as gene identifier. (default: gene_id)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_col_from_tab

### Tool Description
Select columns from a tabulated file based on their names.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk col_from_tab [-i TXT] [-o TXT] -c columns [-n] [-u] [-s SEP] [-r OUT_SEP] [-m MORE_COL] [-H] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select columns from a tabulated file based on their names.

Arguments:
 -i, --inputfile              The tabulated file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -c, --columns                The list (csv) of column names. (default: None)
 -n, --invert-match           Not/invert match. (default: False)
 -u, --unique                 Write non redondant lines. (default: False)
 -s, --separator              The separator of input columns. (default: )
 -r, --output-separator       The separator to be used for separating output columns. (default: )
 -m, --more-col               Add a named (last) column with a given value (e.g. -m col_name:value). (default: None)
 -H, --no-header              Don't print the header line. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_convergent

### Tool Description
Find transcripts with convergent tts. These transcripts will be defined here as those whose tts region (defined by -u/-d) overlaps with the tts of another gene in reverse/antisens orientation. The output is a GTF with an additional key ('convergent') whose value is set to '.' if the gene has no convergent transcript in its tts region. If the gene has an antisens transcript in its tts region the 'convergent' key is set to the identifier of the transcript whose tts is the closest relative to the considered tts. The tts to tts distance is also provided as an additional key (dist_to_convergent).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk convergent [-i GTF] [-o GTF] -c CHROMINFO [-u UPSTREAM] [-d DOWNSTREAM] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Find transcripts with convergent tts. These transcripts will be defined here as those whose tts
     region (defined by -u/-d) overlaps with the tts of another gene in reverse/antisens
     orientation. The output is a GTF with an additional key ('convergent') whose value is set to
     '.' if the gene has no convergent transcript in its tts region. If the gene has an antisens
     transcript in its tts region the 'convergent' key is set to the identifier of the transcript
     whose tts is the closest relative to the considered tts. The tts to tts distance is also
     provided as an additional key (dist_to_convergent).

  Notes:
     *  chrom-info may also accept 'mm8', 'mm9', 'mm10', 'hg19', 'hg38', 'rn3' or 'rn4'. In this
     case the  corresponding size of conventional chromosomes are used. To get the size of  the
     chromosome in ensembl format (whithout chr prefix), use 'mm8_ens', 'mm9_ens',  'mm10_ens',
     'hg19_ens', 'hg38_ens', 'rn3_ens' or 'rn4_ens'. ChrM is not used.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -c, --chrom-info             Tabulated two-columns file. Chromosomes as column 1 and sizes as column 2 (default: None)
 -u, --upstream               Extends the tts in 5' by a given value (int). Defines the region around the tts. (default: 1500)
 -d, --downstream             Extends the region in 3' by a given value (int). Defines the region around the tts. (default: 1500)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_convert

### Tool Description
Convert a GTF to various format (still limited).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk convert [-i GTF] [-o BED/BED3/BED6] [-n NAME] [-s SEP] [-m more_names] [-f {bed,bed3,bed6}] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Convert a GTF to various format (still limited).

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -n, --names                  The key(s) that should be used as name. (default: gene_id,transcript_id)
 -s, --separator              The separator to be used for separating name elements (see -n). (default: |)
 -m, --more-names             Add this information to the 'name' column of the BED file. (default: )
 -f, --format                 Currently one of bed3, bed6 (default: bed6)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_convert_ensembl

### Tool Description
Convert the GTF file to ensembl format. It will essentially add a 'transcript' feature and 'gene' feature when required. This command can be viewed as a 'groomer' command for those starting with a non ensembl GTF.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk convert_ensembl [-i GTF] [-o GTF] [-n] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Convert the GTF file to ensembl format. It will essentially add a 'transcript' feature and 'gene'
     feature when required. This command can be viewed as a 'groomer' command for those starting
     with a non ensembl GTF.

  Notes:
     *  The gtftk program is designed to handle files in ensembl GTF format. This means that the GTF
     file provided to gtftk must contain transcript and gene feature/lines. They will be used to get
     access to transcript and gene coordinates whenever needed. This solution was chosen to define a
     reference GTF file format for gtftk (since Ensembl format is probably the most widely used).
     *  Almost all commands of gtftk use transcript_id or gene_id as keys to perform operation on
     genomic coordinates. One of the most common issue when working with  gene coordinates is the
     lack  of non ambiguous gene or transcript names For instance, a refSeq sequence ID used as
     transcript_id can be associated to  several chromosomal locations as a sequence may be
     duplicated. These identifiers are ambiguous and thus should be avoid. Use UCSC or ensembl IDs
     instead.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -n, --no-check-gene-chr      By default the command raise an error if several chromosomes are associated with the same gene_id. Disable this behaviour (but you should better think about what it means...). (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_count

### Tool Description
Count the number of each features in the gtf file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk count [-i GTF] [-o TXT] [-d header] [-t TEXT] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Count the number of each features in the gtf file.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -d, --header                 A comma-separated list of string to use as header. (default: None)
 -t, --additional-text        A facultative text to be printed in the third column (e.g species name). (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_count_key_values

### Tool Description
Count the number of values/levels for a set of keys.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk count_key_values [-i GTF] [-o TXT] [-k keys] [-t TEXT] [-u] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Count the number of values/levels for a set of keys.

  Notes:
     *  Use --uniq to get the count of non-redondant values.
     *  Not available values ('.') are not taken into account.
     *  Use "*" as the key to get the counts for all keys.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --keys                   The set of keys of interest. (default: *)
 -t, --additional-text        A facultative text to be printed in the third column (e.g species name). (default: None)
 -u, --uniq                   Ask for the count of non redondant values. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_coverage

### Tool Description
Takes a GTF as input to compute bigwig coverage in regions of interest (promoter, transcript body, intron, intron_by_tx, tts...) or a BED6 to focus on user-defined regions. If --n-highest is used the program will compute the coverage of each bigwig based on the average value of the n windows (--nb-window) with the highest coverage values.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk coverage [-i GTF/BED] [-o TXT] -c CHROMINFO [-u UPSTREAM] [-d DOWNSTREAM] [-w nb_window] [-k nb_proc] [-f ft_type] [-l labels] [-m name_column] [-p pseudo_count] [-n n_highest] [-x] [-zn] [-a key_name] [-s {mean,sum}] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file] bw_list [bw_list ...]

  Description: 

     Takes a GTF as input to compute bigwig coverage in regions of interest (promoter, transcript body,
     intron, intron_by_tx, tts...) or a BED6 to focus on user-defined regions. If --n-highest is
     used the program will compute the coverage of each bigwig based on the average value of the n
     windows (--nb-window) with the highest coverage values.

  Notes:
     *  chrom-info may also accept 'mm8', 'mm9', 'mm10', 'hg19', 'hg38', 'rn3' or 'rn4'. In this
     case the  corresponding size of conventional chromosomes are used. To get the size of  the
     chromosome in ensembl format (whithout chr prefix), use 'mm8_ens', 'mm9_ens',  'mm10_ens',
     'hg19_ens', 'hg38_ens', 'rn3_ens' or 'rn4_ens'. ChrM is not used.
     *  Regions were signal can be computed (if GTF file as input): promoter/tss, tts, introns,
     intron_by_tx, intergenic regions or any feature available in the GTF file (transcript, exon,
     gene...).
     *  If --matrix-out is selected, the signal for each bigwig will be provided in a dedicated
     column. Otherwise, signal for each bigwig is provided through a dedicated line.
     *  If bed is used as input, each region should have its own name (column 4).

Arguments:
 bw_list                      A list of Bigwig file (last argument).
 -i, --inputfile              The input GTF/BED file. Only GTF file if <stdin> is used. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -c, --chrom-info             Tabulated two-columns file. Chromosomes as column 1 and sizes as column 2 (default: None)
 -u, --upstream               Extend the regions in 5' by a given value (int). (default: 0)
 -d, --downstream             Extend the regions in 3' by a given value (int). (default: 0)
 -w, --nb-window              Split the region into w bins (see -n). (default: 1)
 -k, --nb-proc                Use this many threads to compute coverage. (default: 1)
 -f, --ft-type                Region in which coverage is to be computed (promoter, intron, intergenic, tts or any feature defined in the column 3 of the GTF). (default: promoter)
 -l, --labels                 Bigwig labels. (default: None)
 -m, --name-column            Use this ids to compute the name (4th column in bed output). (default: transcript_id)
 -p, --pseudo-count           A pseudo-count to add in case count is equal to 0. (default: 1)
 -n, --n-highest              For each bigwig, use the n windows with higher values to compute coverage. (default: None)
 -x, --matrix-out             Matrix output format. Bigwigs as column names and features as rows. (default: False)
 -zn, --zero-to-na            Use NA not zero when region is undefined in bigwig or below window size. (default: False)
 -a, --key-name               If gtf format is requested, the name of the key. (default: cov)
 -s, --stat                   The statistics to be computed for each region. (default: mean)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_del_attr

### Tool Description
Delete one or several attributes from the gtf file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk del_attr [-i GTF] [-o GTF] -k KEY [-r] [-v] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Delete one or several attributes from the gtf file.

  Notes:
     *  You may also use 'complex' regexp such as : "(_id)|(_b.*pe)"
     *  Example: gtftk get_example -d mini_real | gtftk del_attr -k "(^.*_id$|^.*_biotype$)" -r -v
     *  TODO: currently a segfault is thrown when no keys are left after deletion (libgtftk issue
     #98).

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key                    comma-separated list of attribute names or a regular expression (see -r). (default: None)
 -r, --reg-exp                The key name is a regular expression. (default: False)
 -v, --invert-match           Delected keys are those not matching any of the specified key. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_discretize_key

### Tool Description
Create a new key by discretizing a numeric key. This can be helpful to create new classes on the fly that can be used subsequently.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk discretize_key [-i GTF] [-o GTF] -k src_key -d dest_key -n KEY [-l labels] [-p] [-g] [-u] [-r precision] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Create a new key by discretizing a numeric key. This can be helpful to create new classes on the
     fly that can be used subsequently.

  Notes:
     *  if --ft-type is not set the destination key will be assigned to all feature containing the
     source key.
     *  Non-numeric value for source key will be translated into 'NA'.
     *  The default is to create equally spaced interval. The interval can also be created by
     computing the percentiles (-p).

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --src-key                The name of the source key (default: None)
 -d, --dest-key               The name of the target key. (default: None)
 -n, --nb-levels              The number of levels/classes to create. (default: 2)
 -l, --labels                 A comma-separated list of labels of size --nb-levels. (default: None)
 -p, --percentiles            Compute --nb-levels classes using percentiles. (default: False)
 -g, --log                    Compute breaks based on log-scale. (default: False)
 -u, --percentiles-of-uniq    Compute percentiles based on non-redondant values. (default: False)
 -r, --precision              The precision used in naming intervals. (default: 2)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_divergent

### Tool Description
Find transcripts with divergent promoters. These transcripts will be defined here as those whose promoter region (defined by -u/-d) overlaps with the tss of another gene in reverse/antisens orientation. This may be useful to select coding genes in head-to-head orientation or LUAT as described in "Divergent transcription is associated with promoters of transcriptional regulators" (Lepoivre C, BMC Genomics, 2013). The output is a GTF with an additional key ('divergent') whose value is set to '.' if the gene has no antisens transcript in its promoter region. If the gene has an antisens transcript in its promoter region the 'divergent' key is set to the identifier of the transcript whose tss is the closest relative to the considered promoter. The tss to tss distance is also provided as an additional key (dist_to_divergent).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk divergent [-i GTF] [-o GTF] -c CHROMINFO [-u UPSTREAM] [-d DOWNSTREAM] [-n] [-S] [-a key_name] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Find transcripts with divergent promoters. These transcripts will be defined here as those whose
     promoter region (defined by -u/-d) overlaps with the tss of another gene in reverse/antisens
     orientation. This may be useful to select coding genes in head-to-head orientation or LUAT as
     described in "Divergent transcription is associated with promoters of transcriptional
     regulators" (Lepoivre C, BMC Genomics, 2013). The output is a GTF with an additional key
     ('divergent') whose value is set to '.' if the gene has no antisens transcript in its promoter
     region. If the gene has an antisens transcript in its promoter region the 'divergent' key is
     set to the identifier of the transcript whose tss is the closest relative to the considered
     promoter. The tss to tss distance is also provided as an additional key (dist_to_divergent).

  Notes:
     *  chrom-info may also accept 'mm8', 'mm9', 'mm10', 'hg19', 'hg38', 'rn3' or 'rn4'. In this
     case the  corresponding size of conventional chromosomes are used. To get the size of  the
     chromosome in ensembl format (whithout chr prefix), use 'mm8_ens', 'mm9_ens',  'mm10_ens',
     'hg19_ens', 'hg38_ens', 'rn3_ens' or 'rn4_ens'. ChrM is not used.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -c, --chrom-info             Tabulated two-columns file. Chromosomes as column 1 and their sizes as column 2 (default: None)
 -u, --upstream               Extend the promoter in 5' by a given value (int). Defines the region around the tss. (default: 1500)
 -d, --downstream             Extend the region in 3' by a given value (int). Defines the region around the tss. (default: 1500)
 -n, --no-annotation          Do not annotate the GTF. Just select the divergent transcripts. (default: False)
 -S, --no-strandness          Do not consider strandness (only look whether the promoter from a transcript overlaps with the promoter from another gene). (default: False)
 -a, --key-name               The name of the key. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_exon_sizes

### Tool Description
Add a new key to transcript features containing a comma-separated list of exon sizes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk exon_sizes [-i GTF] [-o TXT] [-a key_name] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Add a new key to transcript features containing a comma-separated list of exon sizes.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN. (default: <stdin>)
 -o, --outputfile             Output GTF file. (default: <stdout>)
 -a, --key-name               The name of the key. (default: exon_sizes)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_feature_size

### Tool Description
Get the size and limits (start/end) of features enclosed in the GTF. The feature can be of any type (as found in the 3rd column of the GTF) or 'mature_rna' to get transcript size (i.e without introns). If bed format is requested returns the limits in bed format and the size as a score. Otherwise output GTF file with 'feat_size' as a new key and size as value.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk feature_size [-i GTF] [-o GTF/BED] [-t ft_type] [-n NAME] [-k KEY_NAME] [-s SEP] [-b] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get the size and limits (start/end) of features enclosed in the GTF. The feature can be of any
     type (as found in the 3rd column of the GTF) or 'mature_rna' to get transcript size (i.e
     without introns). If bed format is requested returns the limits in bed format and the size as a
     score. Otherwise output GTF file with 'feat_size' as a new key and size as value.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file (BED). (default: <stdout>)
 -t, --ft-type                A target feature (as found in the 3rd column of the GTF) or 'mature_rna' to get transcript size (without introns). (default: transcript)
 -n, --names                  The key(s) that should be used as name if bed is requested. (default: transcript_id)
 -k, --key-name               Name for the new key if GTF format is requested. (default: feat_size)
 -s, --separator              The separator to be used for separating name elements (see -n). (default: |)
 -b, --bed                    Output bed format. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_get_5p_3p_coords

### Tool Description
Get the 5p or 3p coordinate for each feature (e.g TSS or TTS for a transcript).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk get_5p_3p_coords [-i GTF] [-o BED] [-t ft_type] [-v] [-p transpose] [-n NAME] [-m more_names] [-s SEP] [-e] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get the 5p or 3p coordinate for each feature (e.g TSS or TTS for a transcript).

  Notes:
     *  Output is in BED format.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file (BED). (default: <stdout>)
 -t, --ft-type                The target feature (as found in the 3rd column of the GTF). (default: transcript)
 -v, --invert                 Get 3' coordinate. (default: False)
 -p, --transpose              Transpose coordinate in 5' (use negative value) or in 3' (use positive values). (default: 0)
 -n, --names                  The key(s) that should be used as name. (default: gene_id,transcript_id)
 -m, --more-names             A comma-separated list of information to be added to the 'name' column of the bed file. (default: None)
 -s, --separator              The separator to be used for separating name elements (see -n). (default: |)
 -e, --explicit               Write explicitly the name of the keys in the header. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_get_attr_list

### Tool Description
Get the list of attributes from a GTF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk get_attr_list [-i GTF] [-o TXT] [-s SEP] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get the list of attributes from a GTF file.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -s, --separator              The separator to be used for separating key names. (default: )

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_get_attr_value_list

### Tool Description
Get the list of values observed for an attributes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk get_attr_value_list [-i GTF] [-o TXT] -k key_name [-s separator] [-c] [-p] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get the list of values observed for an attributes.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key-name               The comma separated list of key name. (default: None)
 -s, --separator              The separator used if -c or -p are true. (default: )
 -c, --count                  Add the counts for each key (separator will be set to ' ' by default). (default: False)
 -p, --print-key-name         Also print the key name in the first column. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_get_ceas_records

### Tool Description
Convert a CEAS sqlite file back into a GTF.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk get_ceas_records -i inputfile [-o outputfile] [-t target_table] [-s] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Convert a CEAS sqlite file back into a GTF.

Arguments:
 -i, --inputfile              Path to the CEAS file. (default: None)
 -o, --outputfile             Output file. (default: <stdout>)
 -t, --target-table           The target table. (default: GeneTable)
 -s, --show-tables            Only list tables and exit. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_get_feat_seq

### Tool Description
Get feature sequences (i.e. column 3) in a flexible fasta format from a GTF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk get_feat_seq [-i GTF] [-o FASTA] -g FASTA [-s separator] [-l label] [-t feature_type] [-n] [-r] [-u] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get feature sequences (i.e. column 3) in a flexible fasta format from a GTF file.

  Notes:
     *  The sequences are returned in 5' to 3' orientation.
     *  If you want to use wildcards, use quotes: e.g. 'foo/bar*.fa'.
     *  See get_tx_seq for mature RNA sequence.
     *  If --unique is used if a header was already encountered the record won't be print.  Take
     care to use unambiguous identifiers in the header.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output FASTA file. (default: <stdout>)
 -g, --genome                 The genome in fasta format. (default: None)
 -s, --separator              To separate info in header. (default: |)
 -l, --label                  A set of key for the header that will be extracted from the transcript line. (default: feature,transcript_id,gene_id,seqid,start,end)
 -t, --feature-type           The feature type (one defined in column 3). (default: exon)
 -n, --no-rev-comp            Don't reverse complement sequence corresponding to gene on minus strand. (default: False)
 -r, --rev-comp-to-header     Indicate in the header whether sequence was rev-complemented. (default: False)
 -u, --unique                 Don't write redondant IDS. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_get_feature_list

### Tool Description
Get the list of features enclosed in the GTF.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk get_feature_list [-i GTF] [-o TXT] [-s SEP] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get the list of features enclosed in the GTF.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -s, --separator              The separator to be used for separating key names. (default: )

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_great_reg_domains

### Tool Description
Given a GTF and a GO term computes labeled regions using GREAT 'association rule'.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk great_reg_domains [-i GTF] [-o GTF] [-g go_id] [-s species] [-u upstream] [-d downstream] [-t distal] -c TXT [-m TXT] [-p1 http_proxy] [-p2 https_proxy] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Given a GTF and a GO term computes labeled regions using GREAT 'association rule'.

  Notes:
     *  This tool represents an attempt to process genomic annotations in GTF format in order to
     produced  a set of 'labeled' regions with the same rules as those described in GREAT (Genomic
     Regions Enrichment of Annotations Tool) documentation. We can not warrant that the procedure is
     exactly the same.
     *  The tool only currently supports 'basal_plus_extension' association rule.
     *  Operations are performed on a transcript TSS basis rather than a gene TSS basis. To our
     knowledge, the way  representative TSS are selected for each gene is not described in GREAT
     paper nor documentation. As a consequence  the output contains several regulatory domain for a
     given gene (one per TSS).
     *  The tool does not include 'curated regulatory domains' as proposed by GREAT.
     *  The tool does not allow background regions to be imported.
     *  The resulting BED file can be used for instance as OLOGRAM input (using -z/
     *  no-gtf and -b/
     *  more-bed) to check the GREAT results by assessing whether the enrichment is also significant
     regarding the number of overlapping nucleotides.

Argument:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -g, --go-id                  The GO ID (e.g GO:0003700). Default is to return all genes. (default: None)
 -s, --species                The dataset/species. Use select_by_go to get the list of species (default: hsapiens)
 -u, --upstream               Extend the TSS in 5' by a given value. (default: 5000)
 -d, --downstream             Extend the TSS 3' by a given value. (default: 1000)
 -t, --distal                 Maximum extension in one direction (default: 1000000)
 -c, --chrom-info             Tabulated two-columns file. Chromosomes as column 1, sizes as column 2 (default: None)
 -m, --mode                   The type of 'association rule'. (default: basal_plus_extension)
 -p1, --http-proxy            Use this http proxy (not tested/experimental). (default: )
 -p2, --https-proxy           Use this https proxy (not tested/experimental). (default: )

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_intergenic

### Tool Description
Extract intergenic regions. This command requires a chromInfo file to compute the bed file boundaries. The command will print the coordinates of genomic regions without any transcript features.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk intergenic [-i GTF] [-o BED] -c CHROMINFO [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Extract intergenic regions. This command requires a chromInfo file to compute the bed file
     boundaries. The command will print the coordinates of genomic regions without any transcript
     features.

  Notes:
     *  chrom-info may also accept 'mm8', 'mm9', 'mm10', 'hg19', 'hg38', 'rn3' or 'rn4'. In this
     case the  corresponding size of conventional chromosomes are used. To get the size of  the
     chromosome in ensembl format (whithout chr prefix), use 'mm8_ens', 'mm9_ens',  'mm10_ens',
     'hg19_ens', 'hg38_ens', 'rn3_ens' or 'rn4_ens'. ChrM is not used.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file (BED). (default: <stdout>)
 -c, --chrom-info             Tabulated two-columns file. Chromosomes as column 1 and their sizes as column 2 (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_intron_sizes

### Tool Description
Add a new key to transcript features containing a comma-separated list of intron-size.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk intron_sizes [-i GTF] [-o GTF] [-a key_name] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Add a new key to transcript features containing a comma-separated list of intron-size.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -a, --key-name               The name of the key. (default: intron_sizes)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_intronic

### Tool Description
Returns a bed file containing the intronic regions. If by_transcript is false (default), returns merged genic regions with no exonic overlap ("strict" mode). Otherwise, the intronic regions corresponding to each transcript are returned (may contain exonic overlap and redundancy).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk intronic [-i GTF] [-o BED] [-b] [-n NAME] [-s SEP] [-w] [-F] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Returns a bed file containing the intronic regions. If by_transcript is false (default), returns
     merged genic regions with no exonic overlap ("strict" mode). Otherwise, the intronic regions
     corresponding to each transcript are returned (may contain exonic overlap and redundancy).

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file (BED). (default: <stdout>)
 -b, --by-transcript          The intronic regions are returned for each transcript. (default: False)
 -n, --names                  The key(s) that should be used as name (if -b is used). (default: gene_id,transcript_id)
 -s, --separator              The separator to be used for separating name elements (if -b is used). (default: |)
 -w, --intron-nb-in-name      By default intron number is written in 'score' column. Force it to be written in 'name' column. (default: False)
 -F, --no-feature-name        Don't add the feature name ('intron') in the name column. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_join_attr

### Tool Description
Join attributes from a tabulated file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk join_attr [-i GTF] [-o GTF] -k KEY -j JOIN_FILE [-H] [-m] [-n NEW_KEY] [-t target_feature] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Join attributes from a tabulated file.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key-to-join            The name of the key used to join (e.g transcript_id). (default: None)
 -j, --join-file              A two columns file with (i) the value for joining (e.g value for transcript_id), (ii) the value for novel key (e.g the coding potential computed value). (default: None)
 -H, --has-header             Indicates that the 'join-file' has a header. (default: False)
 -m, --matrix                 'join-file' expect a matrix with row names as target keys column names as novel key and each cell as value. (default: False)
 -n, --new-key                The name of the novel key. Mutually exclusive with --matrix. (default: None)
 -t, --target-feature         The name(s) of the target feature(s). comma-separated. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_join_multi_file

### Tool Description
Join attributes from mutiple files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk join_multi_file [-i GTF] [-o GTF] -k KEY [-t target_feature] [-m matrix_files [matrix_files ...]] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Join attributes from mutiple files.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key-to-join            The name of the key used to join (e.g transcript_id). (default: None)
 -t, --target-feature         The name(s) of the target feature(s). Comma-separated. (default: None)
 -m, --matrix-files           A set of matrix files with row names as target keys column names as novel key and each cell as value. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_merge_attr

### Tool Description
Merge a set of attributes into a destination attribute.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk merge_attr [-i GTF] [-o GTF] -k KEY -d KEY [-s SEP] [-f target_feature] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Merge a set of attributes into a destination attribute. Can be useful, for instance, to merge
     gene_name and gene_id values into a new key to prepare the GTF for RNA-seq quantification.

  Notes:
     *  The destination key can be one of the source key, leading to an update of that key.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --src-key                comma-separated list of keys to join. (default: None)
 -d, --dest-key               The target key name. (default: None)
 -s, --separator              The separator for the concatenated values. (default: |)
 -f, --target-feature         The name of the target feature. (default: *)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_midpoints

### Tool Description
Get the midpoint coordinates for the requested feature.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk midpoints [-i GTF/BED] [-o BED] [-t ft_type] [-n NAME] [-s SEP] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Get the midpoint coordinates for the requested feature. Output is bed format.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file (BED). (default: <stdout>)
 -t, --ft-type                The target feature (as found in the 3rd column of the GTF). (default: transcript)
 -n, --names                  The key(s) that should be used as name. (default: transcript_id)
 -s, --separator              The separator to be used for separating name elements (see -n). (default: |)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_mk_matrix

### Tool Description
Compute a coverage matrix (see profile).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk mk_matrix [-i GTF/BED] -y bigwiglist [bigwiglist ...] -o GTF/TXT [-l labels] [-t {promoter,tts,transcript,user_regions,single_nuc}] [-p pseudo_count] [-u upstream] [-d downstream] -c chrom_info [-w bin_nb] [-k nb_proc] [-b bin_around_frac] [-zn] [-nst] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Create a matrix storing the bigwig coverage computed from binned regions.

  Notes:
     *  chrom-info may also accept 'mm8', 'mm9', 'mm10', 'hg19', 'hg38', 'rn3' or 'rn4'. In this
     case the  corresponding size of conventional chromosomes are used. To get the size of  the
     chromosome in ensembl format (whithout chr prefix), use 'mm8_ens', 'mm9_ens',  'mm10_ens',
     'hg19_ens', 'hg38_ens', 'rn3_ens' or 'rn4_ens'. ChrM is not used.

Arguments:
 -i, --inputfile              A GTF file or bed file. A GTF if <stdin>. (default: <stdin>)
 -y, --bigwiglist             A list of Bigwig files (last argument). (default: None)
 -o, --outputfile             Output file name (.zip extension will be added). (default: <stdout>)
 -l, --labels                 Bigwig labels (i.e short name version for plotting). (default: None)
 -t, --ft-type                If input is a GTF, the region to analyse. (default: promoter)
 -p, --pseudo-count           Pseudo-count to add to all values. (default: 0)
 -u, --upstream               Extend the region of interest in 5' by a given value. (default: 1000)
 -d, --downstream             Extend the region of interest in 3' by a given value. (default: 1000)
 -c, --chrom-info             Tabulated file (chr as column 1, sizes as column 2.) (default: None)
 -w, --bin-nb                 Split the region into w bins. (default: 100)
 -k, --nb-proc                Use this many threads to compute coverage. (default: 1)
 -b, --bin-around-frac        Fraction of bins used in 5' and 3' regions. (default: 0.1)
 -zn, --zero-to-na            Use NA not zero when region is undefined in bigwig. (default: False)
 -nst, --no-stranded          The bins should not be oriented relative to strand. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_nb_exons

### Tool Description
Count the number of exons by transcript.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk nb_exons [-i GTF] [-o TXT/GTF] [-f] [-a key_name] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Returns the transcript name and number of exons with nb_exons as a novel key for each transcript
     feature.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -f, --text-format            Return a text format. (default: False)
 -a, --key-name               The name of the key. (default: nb_exons)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_nb_transcripts

### Tool Description
Count the number of transcript per gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk nb_transcripts [-i GTF] [-o GTF/TXT] [-f] [-a key_name] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Compute the number of transcript per gene.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -f, --text-format            Return a text format. (default: False)
 -a, --key-name               If gtf format is requested, the name of the key. (default: nb_tx)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_ologram_merge_runs

### Tool Description
Merge ologram runs, treating each as a superbatch.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk ologram_merge_runs [-i inputfiles [inputfiles ...]] [-os ori_shuffles] -o output [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Merge a set of OLOGRAM runs into a single run and recalculates statistics based on it.

     This treats each run as a "superbatch". The command takes as input the list of  paths of all the
     results' TSV you wish to merge. It also takes as input the number of shuffles originally
     performed in the  individual runs (by default, is assumed to be 200).

     Example of command line: gtftk ologram_merge_runs --inputfiles `ls output/ologram_results/*.tsv`
     --ori-shuffles 200 -o final_result.tsv

  Notes:
     *  This implicitly assumes you are combining runs with the *same number* of shuffles in each.
     *  The fit quality for the Neg. Binoms. will be indicated as "-1" since it cannot be evaluated
     here.
     *  On the technical side, statistics are recalculated by conflating the distributions with a
     weighting  based on the number of runs. See the source code for the precise formula.

Arguments:
 -i, --inputfiles             Complete paths to the OLOGRAM output text files (default: None)
 -os, --ori-shuffles          How many shuffles were performed in the individual runs that will be merged? (default: 200)
 -o, --output                 Destination path for the merged output file. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_ologram_modl_treeify

### Tool Description
Build a tree representation from an OLOGRAM-MODL multiple combinations result files (tsv).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk ologram_modl_treeify -i inputfile -o output [-l query_label] [-t top_s] [-mh min_inheritance] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Turns a result of OLOGRAM-MODL multiple overlap (tsv file) in a tree for easier visualisation

     See the /pygtftk/plugins/ologram.py file, as well as the documentation, for more information about
     OLOGRAM.

  Notes:
     *  Turns a result of OLOGRAM-MODL multiple overlap (tsv file) in a tree for easier
     visualisation.
     *  This is the preferred representation for OLOGRAM-MODL results. Each node represents  a
     combination, with its number of overlapping basepairs in true data (S) and the corresponding
     fold change and p-value compared to the shuffles.
     *  Result tsv files can be manually edited (ie. removing combinations) before passing them to
     this plugin
     *  For a quick filtering, it is possible to show only the top T combinations sorted by total
     basepairs in real data.

Arguments:
 -i, --inputfile              Complete path to the OLOGRAM output file (default: None)
 -o, --output                 Pdf file name (default: None)
 -l, --query-label            Name of the query for display (default: Query)
 -t, --top-s                  Optional. Only the top t combinations sorted by total basepairs in real data will be displayed. (default: -1)
 -mh, --min_inheritance       Optional. A combination will be added to a shorter parent in the tree only if it represents at least a proportion MH of its true base pairs (between 0 and 1). (default: -1)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_overlapping

### Tool Description
Find (non)overlapping transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk overlapping [-i GTF] [-o GTF] -c CHROMINFO [-u UPSTREAM] [-d DOWNSTREAM] [-t {transcript,promoter,tts}] [-s] [-S] [-n] [-a] [-k key_name] [-b] [-@] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Find transcripts whose body/TSS/TTS region extended in 5' and 3' (-u/-d) overlaps with any
     transcript from another gene. Strandness is not considered by default. Used --invert-match to
     find those that do not overlap. If --annotate-gtf is used, all lines of the input GTF file will
     be printed and a new key containing the list of overlapping transcripts will be added to the
     transcript features/lines (key will be 'overlapping_*' with * one of body/TSS/TTS). The
     --annotate-gtf and --invert-match arguments are mutually exclusive.

  Notes:
     *  --chrom-info may also accept 'mm8', 'mm9', 'mm10', 'hg19', 'hg38', 'rn3' or 'rn4'. In this
     case the  corresponding size of conventional chromosomes are used. ChrM is not used.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -c, --chrom-info             Chromosome information. A tabulated two-columns file with chromosomes as column 1 and sizes as column 2 (default: None)
 -u, --upstream               Extend the region in 5'. Used to define the region around the TSS/TTS. (default: 1500)
 -d, --downstream             Extend the region in 3'. Used to define the region around the TSS/TTS. (default: 1500)
 -t, --feature-type           The feature of interest. (default: transcript)
 -s, --same-strandedness      Require same strandedness (default: False)
 -S, --diff-strandedness      Require different strandedness (default: False)
 -n, --invert-match           Not/Invert match. (default: False)
 -a, --annotate-gtf           All lines of the original GTF will be printed. (default: False)
 -k, --key-name               The name of the key. (default: None)
 -b, --bool                   When --annotate-gtf is used use 0 or 1 as key values (instead of overlapping transcripts id). (default: False)
 -@, --annotate-all           When --annotate-gtf annotate all transcripts (default value would be '0'). (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_random_list

### Tool Description
Select a random list of genes or transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk random_list [-i GTF] [-o GTF] [-n NUMBER] [-t {gene,transcript}] [-s SEED] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select a random list of genes or transcripts. Note that if transcripts are requested the 'gene'
     feature is not returned.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -n, --number                 The number of transcripts or gene to select. (default: 1)
 -t, --ft-type                The type of feature. (default: transcript)
 -s, --seed-value             Seed value for the random number generator. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_random_tx

### Tool Description
Select randomly up to m transcript for each gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk random_tx [-i GTF] [-o GTF] [-m MAX] [-s SEED] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select randomly up to m transcript for each gene.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -m, --max-transcript         The maximum number of transcripts to select for each gene. (default: 1)
 -s, --seed-value             Seed value for the random number generator. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_rm_dup_tss

### Tool Description
If several transcripts of a gene share the same TSS, select only one representative.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk rm_dup_tss [-i GTF] [-o GTF] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     If several transcripts of a gene share the same TSS, select one transcript per TSS.

  Notes:
     *  The alphanumeric order of transcript_id is used to select the representative of a TSS.

Argument:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_go

### Tool Description
Select lines from a GTF file using a Gene Ontology ID.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_go [-i GTF] [-o GTF] [-g go_id] (-l | -s species) [-n] [-p1 http_proxy] [-p2 https_proxy] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select lines/genes from a GTF file using a Gene Ontology ID (e.g GO:0097194).

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -g, --go-id                  The GO ID (with or without "GO:" prefix). (default: GO:0003700)
 -l, --list-datasets          Do not select lines. Only get a list of available datasets/species. (default: False)
 -s, --species                The dataset/species. (default: None)
 -n, --invert-match           Not/invert match. (default: False)
 -p1, --http-proxy            Use this http proxy (not tested/experimental). (default: )
 -p2, --https-proxy           Use this https proxy (not tested/experimental). (default: )

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_intron_size

### Tool Description
Select transcripts by intron size.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_intron_size [-i GTF] [-o GTF] -s intron_size [-m] [-d] [-a] [-v] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Delete transcripts containing an intron whose size is below s.

  Notes:
     *  By default delete transcripts containing an intron (or a sum intronic nucleotides, see -m)
     whose size is below s.
     *  If --invert-match is selected delete transcripts containing an intron (or a sum intronic
     nucleotides, see -m) whose size is greater or equal to s.
     *  Mono-exonic transcripts are not tested for intron size. They can be kept or deleted based on
     -d.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -s, --intron-size            The minimum intron size. (default: 100)
 -m, --merged                 If selected, the sum of all intron lengths for a gene should be higher than s. (default: False)
 -d, --delete-monoexonic      Delete mono-exonic transcripts. (default: False)
 -a, --add-intron-size        Add a new key containing intron_size (comma-separated in order of apppearance) or the sum of intron size (see -m). (default: False)
 -v, --invert-match           Keep genes with an intron whose size is above s and delete others. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_key

### Tool Description
Select lines from a GTF based on attributes and values.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_key [-i GTF] [-o GTF] [-k KEY] [-v VALUE] [-f FILE] [-c COL] [-n] [-b] [-m NAME] [-s SEP] [-l] [-t] [-g] [-e] [-d] [-a] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select lines from a GTF file based on attributes and associated values.

optional arguments:
 -v, --value                  A comma-separated list of values. (default: None)
 -f, --file-with-values       A file containing values as a single column. (default: None)
 -t, --select-transcripts     A shortcuts for "-k feature -v transcript". (default: False)
 -g, --select-genes           A shortcuts for "-k feature -v gene". (default: False)
 -e, --select-exons           A shortcuts for "-k feature -v exon". (default: False)
 -d, --select-cds             A shortcuts for "-k feature -v CDS". (default: False)
 -a, --select-start-codon     A shortcuts for "-k feature -v start_codon". (default: False)

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key                    The key name. (default: None)
 -c, --col                    The column number (one-based) that contains the values in the file. File is tab-delimited. (default: 1)
 -n, --invert-match           Not/invert match. Select lines whose selected key is not associated with the selected values. (default: False)
 -b, --bed-format             Ask for bed format output. (default: False)
 -m, --names                  If Bed output. The key(s) that should be used as name. (default: gene_id,transcript_id)
 -s, --separator              If Bed output. The separator to be used for separating name elements (see -n). (default: |)
 -l, --log                    Print some statistics about selected features. To be used in conjunction with -V 1/2. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_loc

### Tool Description
Select transcript/gene overlapping a genomic feature.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_loc [-i GTF] [-o GTF] (-l LOC | -f BEDFILE) [-t {transcript,gene}] [-n] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select transcripts/gene overlapping a given locations.

  Notes:
     *  A transcript is defined here as the genomic region from TSS to TTS including introns.
     *  This function will return the transcript and all its associated elements (exons, utr...)
     even if only a fraction (e.g intron) of the transcript is overlapping the feature.
     *  If -/-ft-type is set to 'gene' returns the gene and all its associated elements.

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -l, --location               List of chromosomal locations (chr:start-end[,chr:start-end]). 0-based (default: None)
 -f, --location-file          Bed file with chromosomal location. (default: None)
 -t, --ft-type                The feature of interest. (default: transcript)
 -n, --invert-match           Not/invert match. Select transcript not overlapping. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_max_exon_nb

### Tool Description
For each gene select the transcript with the highest number of exons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_max_exon_nb [-i GTF] [-o GTF] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     For each gene select the transcript with the highest number of exons. If ties, select the first
     encountered.

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_nb_exon

### Tool Description
Select transcripts based on the number of exons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_nb_exon [-i GTF] [-o GTF] [-m min_exon_number] [-M max_exon_number] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select transcripts based on the number of exons.

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -m, --min-exon-number        Minimum number of exons. (default: 0)
 -M, --max-exon-number        Maximum number of exons. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_numeric_value

### Tool Description
Select lines from a GTF file based on a boolean test on numeric values.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_numeric_value [-i GTF] [-o GTF] -t test [-n na_omit] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select lines from a GTF file based on a boolean test on numeric values.

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -t, --test                   The test to be applied. (default: None)
 -n, --na-omit                If one of the evaluated values is enclosed in this list (csv), line is skipped. (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_regexp

### Tool Description
Select lines from a GTF file based on a regexp.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_regexp [-i GTF] [-o GTF] [-k KEY] [-r regexp] [-n] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select lines from a GTF file based on a regexp.

  Notes:
     *  The default is to try to select feature from conventional human chromosome (chr1..chr22,
     chrX and chrY) with --key set to chrom and --regexp set to "^chr[0-9XY]+$".

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key                    The key name (default: chrom)
 -r, --regexp                 The regular expression. (default: ^chr[0-9XY]+$)
 -n, --invert-match           Not/invert match. Selected lines whose requested key do not match the regexp. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_by_tx_size

### Tool Description
Select transcript based on their size (i.e size of mature/spliced transcript).

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_by_tx_size [-i GTF] [-o GTF] [-m min_size] [-M max_size] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select transcript based on their size (i.e size of mature/spliced transcript).

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -m, --min-size               Minimum size. (default: 0)
 -M, --max-size               Maximum size. (default: 1000000000)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_select_most_5p_tx

### Tool Description
Select the most 5' transcript of each gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk select_most_5p_tx [-i GTF] [-o GTF] [-g] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select the most 5' transcript of each gene.

  Notes:
     *  If several transcript share the samemost 5' TSS, only one transcript is selected.

optional arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -g, --keep-gene-lines        Add gene lines to the output (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_seqid_list

### Tool Description
Returns the chromosome list.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk seqid_list [-i GTF] [-o TXT] [-s SEP] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select the seqid/chromosomes

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -s, --separator              The separator to be used for separating key names. (default: )

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_shift

### Tool Description
Transpose coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk shift [-i GTF] [-o GTF] -s shift_value [-d] [-a] -c CHROMINFO [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Transpose coordinates in 3' or 5' direction.

  Notes:
     *  chrom-info may also accept 'mm8', 'mm9', 'mm10', 'hg19', 'hg38', 'rn3' or 'rn4'. In this
     case the  corresponding size of conventional chromosomes are used. To get the size of  the
     chromosome in ensembl format (whithout chr prefix), use 'mm8_ens', 'mm9_ens',  'mm10_ens',
     'hg19_ens', 'hg38_ens', 'rn3_ens' or 'rn4_ens'. ChrM is not used.
     *  By default shift is not strand specific. Meaning that if -\shift-value is set to 10, all
     coordinates will be moved 10 bases in 5' direction relative to the forward/watson/plus/top
     strand.
     *  Use a negative value to shift in 3' direction, a positive value to shift in 5' direction.
     *  If --stranded is true, features are transposed in 5' direction relative to their associated
     strand.
     *  By default, features are not allowed to go outside the genome coordinates. In the current
     implementation, in case this would happen (using a very large -\shift-value), feature would
     accumulate at the ends of chromosomes irrespectively of gene or transcript structures giving
     rise, ultimately, to several exons from the same transcript having the same starts or ends.
     *  One can forced features to go outside the genome and ultimatly dissapear with large
     --shift-value by using -a.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -s, --shift-value            Shift coordinate by s nucleotides. (default: 0)
 -d, --stranded               By default shift not . (default: False)
 -a, --allow-outside          Accept the partial or total disappearance of a feature upon shifting. (default: False)
 -c, --chrom-info             Tabulated two-columns file. Chromosomes as column 1 and sizes as column 2 (default: None)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_short_long

### Tool Description
Get the shortest or longest transcript of each gene

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk short_long [-i GTF] [-o GTF] [-l] [-g] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Select the shortest mature transcript (i.e without introns) for each gene or the longest if the -l
     arguments is used.

  Notes:
     *

Argument:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -l, --longs                  Take the longest transcript of each gene (default: False)
 -g, --keep-gene-lines        Add gene lines to the output (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_splicing_site

### Tool Description
Compute the locations of donor and acceptor splice sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk splicing_site [-i GTF] [-o BED] [-k exon_numbering_key] [-n NAME] [-s SEP] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Compute the locations of donor and acceptor splice sites.

  Notes:
     *  This will return a single position, which corresponds to the most 5' and/or the most 3'
     intronic region. If the gtf file does not contain exon numbering you can compute it using the
     add_exon_nb command. The score column of the bed file contains the number of the closest exon
     relative to the splice site.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --exon-numbering-key     The name of the key containing the exon numbering (exon_number in ensembl) (default: exon_number)
 -n, --names                  The key(s) that should be used as name. (default: exon_id,transcript_id,gene_id)
 -s, --separator              The separator to be used for separating name elements (see -n). (default: |)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_tabulate

### Tool Description
Convert a GTF to tabulated format.
Convert a GTF to tabulated format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk tabulate [-i GTF] [-o TXT] [-s SEPARATOR] [-k KEY,KEY...] [-u] [-H] [-n] [-x] [-b] [-t | -g | -a | -e] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Convert a GTF to tabulated format.

  Notes:
     *  Warning: by default tabulate will discard any line for which one of the selected key is not
     defined. Use -x (--accept-undef) to print them.
     *  To refer to default keys use: seqid,source,feature,start,end,frame,gene_id...
     *  Note that 'all' or '*' are special keys that can be used to convert the whole GTF into a
     tabulated file. Thanks @fafa13.

optional arguments:
 -t, --select-transcript-ids  A shortcuts for "-k transcript_id". (default: False)
 -g, --select-gene_ids        A shortcuts for "-k gene_id". (default: False)
 -a, --select-gene-names      A shortcuts for "-k gene_name". (default: False)
 -e, --select-exon-ids        A shortcuts for "-k exon_ids". (default: False)

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -s, --separator              The output field separator. (default: )
 -k, --key                    A comma-separated list of key names. (default: *)
 -u, --unique                 Print a non redondant list of lines. (default: False)
 -H, --no-header              Don't print the header line. (default: False)
 -n, --no-unset               Don't print lines containing '.' (unset values) (default: False)
 -x, --accept-undef           Print line for which the key is undefined (i.e, '?', does not exists). (default: False)
 -b, --no-basic               In case key is set to 'all' or '*', don't write basic attributes. (default: False)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_tss_dist

### Tool Description
Computes the distance between TSS of gene transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk tss_dist [-i GTF] [-o TXT] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Computes the distance between TSSs of pairs of gene transcripts.

  Notes:
     *  The tss_num_1/tss_num_1 columns contains the numbering of TSSs (transcript_id_1 and
     transcript_id_2 respectively) for each gene.
     *  Numering starts from 1 (most 5' TSS) to the number of different TSS coordinates.
     *  Thus two or more transcripts will have the same tss_num if they share a TSS.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## pygtftk_tss_numbering

### Tool Description
Add the tss number to each transcript (5'->3').

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

### Original Help Text
```text
  Usage: gtftk tss_numbering [-i GTF] [-o TXT] [-k key_name] [-c] [-d key_name_dist] [-g] [-l gene_key] [-h] [-V [verbosity]] [-D] [-C] [-K tmp_dir] [-A] [-L logger_file] [-W write_message_to_file]

  Description: 

     Add the tss number to each transcript (5'->3').

  Notes:
     *  For each transcript feature add a key containing its tss number relative to the most 5'. -
     See --add-nb-tss-to-gene to add the number of different tss to each gene feature.

Arguments:
 -i, --inputfile              Path to the GTF file. Default to STDIN. (default: <stdin>)
 -o, --outputfile             Output file. (default: <stdout>)
 -k, --key-name               The name of the new key. (default: tss_number)
 -c, --compute-dist           Add a key indicating the distance to the first tss (the most 5'). (default: False)
 -d, --key-name-dist          If --compute-dist is true a name for that key. (default: dist_to_first_tss)
 -g, --add-nb-tss-to-gene     Add the number of different tss to each gene (default: False)
 -l, --gene-key               The name of the key if --add-nb-tss-to-gene is selected. (default: nb_tss)

Command-wise optional arguments:
 -h, --help                   Show this help message and exit.
 -V, --verbosity              Set output verbosity ([0-3]). (default: 0)
 -D, --no-date                Do not add date to output file names. (default: False)
 -C, --add-chr                Add 'chr' to chromosome names before printing output. (default: False)
 -K, --tmp-dir                Keep all temporary files into this folder. (default: None)
 -A, --keep-all               Try to keep all temporary files even if process does not terminate normally. (default: False)
 -L, --logger-file            Stores the arguments passed to the command into a file. (default: None)
 -W, --write-message-to-file  Store all message into a file. (default: None)
```

## Metadata
- **Skill**: generated
