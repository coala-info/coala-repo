# pygtftk CWL Generation Report

## pygtftk_gtftk

### Tool Description
A toolbox to handle GTF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
- **Homepage**: http://github.com/dputhier/pygtftk
- **Package**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pygtftk/overview
- **Total Downloads**: 95.7K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/dputhier/pygtftk
- **Stars**: N/A
### Original Help Text
```text
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
tabulate() got an unexpected keyword argument 'headers'
  Usage: gtftk [-h] [-b] [-p] [-u] [-s] [-d] [-v] [-l] [-i]  ...

  A toolbox to handle GTF files.

  Example:

  gtftk get_example -f chromInfo -o simple.chromInfo ;
  gtftk get_example  | gtftk feature_size -t mature_rna | gtftk nb_exons |\
  gtftk intron_sizes | gtftk exon_sizes | gtftk convergent -u 24 -d 24  -c simple.chromInfo | \
  gtftk divergent -u 101 -d 10  -c simple.chromInfo  | \
  gtftk overlapping -u 0 -d 0 -t transcript -c simple.chromInfo -a |  \
  gtftk select_by_key -k feature -v transcript |   gtftk tabulate -k "*" -b -x

  Type 'gtftk sub-command -h' for more information.

    

Main command arguments:
 -h, --help                   show this help message and exit
 -b, --bash-comp              Get a script to activate bash completion. (default: False)
 -p, --plugin-tests           Display bats tests for all plugin. (default: False)
 -u, --plugin-tests-no-conn   Display bats tests for plugins not relying on server conn. (default: False)
 -s, --system-info            Display some info about the system. (default: False)
 -d, --plugin-path            Print plugin path (default: False)
 -v, --version                show program's version number and exit
 -l, --list-plugins           Get the list of plugins. (default: False)
 -i, --update-plugins         Read the ~/.gtftk folder and update the plugin list. (default: False)

Available sub-commands/plugins:
 
  
------- editing --------

   add_prefix                 Add a prefix or suffix to target values.
   del_attr                   Delete attributes in the target gtf file.
   discretize_key             Create a new key through discretization of a numeric key.
   join_attr                  Join attributes from a tabulated file.
   join_multi_file            Join attributes from mutiple files.
   merge_attr                 Merge a set of attributes into a destination attribute.
  
----- information ------

   add_exon_nb                Add exon number transcript-wise.
   apropos                    Search in all command description files those related to a user-defined keyword.
   count                      Count the number of features in the gtf file.
   count_key_values           Count the number values for a set of keys.
   feature_size               Compute the size of features enclosed in the GTF.
   get_attr_list              Get the list of attributes from a GTF file.
   get_attr_value_list        Get the list of values observed for an attributes.
   get_example                Get example files including GTF.
   get_feature_list           Get the list of features enclosed in the GTF.
   nb_exons                   Count the number of exons by transcript.
   nb_transcripts             Count the number of transcript per gene.
   retrieve                   Retrieve a GTF file from ensembl.
   seqid_list                 Returns the chromosome list.
   tss_dist                   Computes the distance between TSS of gene transcripts.
  
------ selection -------

   random_list                Select a random list of genes or transcripts.
   random_tx                  Select randomly up to m transcript for each gene.
   rm_dup_tss                 If several transcripts of a gene share the same TSS, select only one representative.
   select_by_go               Select lines from a GTF file using a Gene Ontology ID.
   select_by_intron_size      Select transcripts by intron size.
   select_by_key              Select lines from a GTF based on attributes and values.
   select_by_loc              Select transcript/gene overlapping a genomic feature.
   select_by_max_exon_nb      For each gene select the transcript with the highest number of exons.
   select_by_nb_exon          Select transcripts based on the number of exons.
   select_by_numeric_value    Select lines from a GTF file based on a boolean test on numeric values.
   select_by_regexp           Select lines from a GTF file based on a regexp.
   select_by_tx_size          Select transcript based on their size (i.e size of mature/spliced transcript).
   select_most_5p_tx          Select the most 5' transcript of each gene.
   short_long                 Get the shortest or longest transcript of each gene
  
------ conversion ------

   bed_to_gtf                 Convert a bed file to a gtf but with lots of empty fields...
   tabulate                   Convert a GTF to tabulated format.
   convert                    Convert a GTF to various format including bed.
   convert_ensembl            Convert the GTF file to ensembl format. Essentially add 'transcript'/'gene' features.
   tabulate                   Convert a GTF to tabulated format.
  
------ annotation ------

   closest_genes              Find the n closest genes for each transcript.
   convergent                 Find transcripts with convergent tts.
   divergent                  Find transcripts with divergent promoters.
   exon_sizes                 Add a new key to transcript features containing a comma-separated list of exon sizes.
   intron_sizes               Add a new key to transcript features containing a comma-separated list of intron sizes.
   overlapping                Find (non)overlapping transcripts.
   tss_numbering              Add the tss number to each transcript (5'->3').
  
------ ologram ------

   ologram_merge_runs         Merge ologram runs, treating each as a superbatch.
   ologram_modl_treeify       Build a tree representation from an OLOGRAM-MODL multiple combinations result files (tsv).
  
------- sequence -------

   get_feat_seq               Get feature sequence (e.g exon, UTR...).
   get_tx_seq                 Get transcript sequences in fasta format.
  
----- coordinates ------

   get_5p_3p_coords           Get the 5p or 3p coordinate for each feature. TSS or TTS for a transcript.
   intergenic                 Extract intergenic regions.
   intronic                   Extract intronic regions.
   midpoints                  Get the midpoint coordinates for the requested feature.
   shift                      Transpose coordinates.
   splicing_site              Compute the locations of donor and acceptor splice sites.
  
------- coverage -------

   coverage                   Compute bigwig coverage in body, promoter, tts...
   mk_matrix                  Compute a coverage matrix (see profile).
  
----- miscellaneous ----

   bigwig_to_bed              Convert a bigwig to a BED3 format.
   col_from_tab               Select columns from a tabulated file based on their names.
   get_ceas_records           Convert a CEAS sqlite file back into a flat file.
   great_reg_domains          Attempt to compute labeled regions using GREAT 'association rule'

------------------------
```


## pygtftk_gtftk get_example

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


## pygtftk_gtftk get_tx_seq

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
