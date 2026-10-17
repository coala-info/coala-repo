# pygtftk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pygtftk_gtftk_get_example | PASS |  |
| pygtftk_gtftk_get_tx_seq | PASS |  |

## pygtftk_gtftk_get_example

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


## pygtftk_gtftk_get_tx_seq

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


## Metadata
- **Skill**: generated
