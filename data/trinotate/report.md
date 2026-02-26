# trinotate CWL Generation Report

## trinotate_Trinotate

### Tool Description
Trinotate: Annotation of,"Trinity"-assembled Transcriptome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
- **Homepage**: https://trinotate.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/trinotate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trinotate/overview
- **Total Downloads**: 42.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
___________      .__               __          __           
              __    ___/______|__| ____   _____/  |______ _/  |_  ____   
                |    |  _  __   |/     /  _    ____  \   __/ __   
                |    |   |  | /  |   |  (  <_> )  |  / __ |  |   ___/  
                |____|   |__|  |__|___|  /____/|__| (____  /__|  ___  > 
                                       /                 /          /  

     usage: /usr/local/bin/Trinotate --db <sqlite.db> <--command ...>
 

     <commands>: 

         * Initial creation of the Trinotate sqlite database and downloading of the required data sets
              
             Trinotate --db <sqlite.db> --create --trinotate_data_dir /path/to/TRINOTATE_DATA_DIR

                 The sqlite.db file is created as named and search databases are downloaded into /path/to/TRINOTATE_DATA_DIR
                   (Note, if EggnogMapper is installed and env var EGGNOG_DATA_DIR is NOT set, 
                    will additionally download those data too into TRINOTATE_DATA_DIR !) 

         * Initial import of transcriptome and protein data:

             Trinotate --db <sqlite.db> --init --gene_trans_map <file> --transcript_fasta <file> --transdecoder_pep <file>

         * Running annotation computes automatically including auto-loading of results.

             * to run ALL supported computes:
                   
                   Trinotate --db <sqlite.db> --run ALL --CPU <int> --transcript_fasta <file> --transdecoder_pep <file> 

             * or to run select supported computes, indicate which ones to run: 

                   Trinotate --db <sqlite.db> --CPU <int> --transcript_fasta <file> --transdecoder_pep <file> 
                                   --run "swissprot_blastp swissprot_blastx pfam signalp6 tmhmmv2 infernal EggnogMapper" 

                    Notes:
                        -  when specifying run with multiple values, enclose the list in quotes as shown above.
                        -  include --use_diamond if you would prefer to use diamond blast instead of ncbi (default) blast)
                        -  include --trinotate_data_dir <path> unless you have TRINOTATE_DATA_DIR env var set. 
                        -  if running using provided docker or singularity, signalp6 is not automatically included due to licensing restrictions)
                        -  deeptmhmm must be run separately from Trinotate and then loaded using Trinotate --LOAD_deeptmhmm

         * Transdecoder loading protein search results:

             Trinotate --db <sqlite.db> --LOAD_swissprot_blastp <file.outfmt6>
             Trinotate --db <sqlite.db> --LOAD_pfam <file>
             Trinotate --db <sqlite.db> --LOAD_signalp <file>
             Trinotate --db <sqlite.db> --LOAD_EggnogMapper <file>
             Trinotate --db <sqlite.db> --LOAD_tmhmmv2 <file>  or Trinotate --db <sqlite.db> --LOAD_deeptmhmm <file.gff3>


          * Trinity loading transcript search results:

             Trinotate --db <sqlite.db> --LOAD_swissprot_blastx <file.outfmt6>
             Trinotate --db <sqlite.db> --LOAD_infernal <file>
             

          * Load custom blast results using any searchable database

             Trinotate --db <sqlite.db> --LOAD_custom_blast <file.outfmt6> --blast_type <blastp|blastx> --custom_db_name <database_name>
                    (The custom_db_name is used for the column name for that annotation in the final report.)

          * report generation:

             Trinotate --db <sqlite.db> --report [ -E (default: 1e-5) ] 
                                                 [--pfam_cutoff DNC|DGC|DTC|SNC|SGC|STC (default: DNC=domain noise cutoff)] 
                                                 [--incl_pep] 
                                                 [--incl_trans]
```


## trinotate_blastp

### Tool Description
Protein-Protein BLAST 2.14.1+

### Metadata
- **Docker Image**: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
- **Homepage**: https://trinotate.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/trinotate/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
  blastp [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-task task_name] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-taxids taxids] [-negative_taxids taxids] [-taxidlist filename]
    [-negative_taxidlist filename] [-ipglist filename]
    [-negative_ipglist filename] [-entrez_query entrez_query]
    [-db_soft_mask filtering_algorithm] [-db_hard_mask filtering_algorithm]
    [-subject subject_input_file] [-subject_loc range] [-query input_file]
    [-out output_file] [-evalue evalue] [-word_size int_value]
    [-gapopen open_penalty] [-gapextend extend_penalty]
    [-qcov_hsp_perc float_value] [-max_hsps int_value]
    [-xdrop_ungap float_value] [-xdrop_gap float_value]
    [-xdrop_gap_final float_value] [-searchsp int_value] [-seg SEG_options]
    [-soft_masking soft_masking] [-matrix matrix_name]
    [-threshold float_value] [-culling_limit int_value]
    [-best_hit_overhang float_value] [-best_hit_score_edge float_value]
    [-subject_besthit] [-window_size int_value] [-lcase_masking]
    [-query_loc range] [-parse_deflines] [-outfmt format] [-show_gis]
    [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-sorthits sort_hits]
    [-sorthsps sort_hsps] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-mt_mode int_value] [-ungapped] [-remote]
    [-comp_based_stats compo] [-use_sw_tback] [-version]

DESCRIPTION
   Protein-Protein BLAST 2.14.1+

OPTIONAL ARGUMENTS
 -h
   Print USAGE and DESCRIPTION;  ignore all other parameters
 -help
   Print USAGE, DESCRIPTION and ARGUMENTS; ignore all other parameters
 -version
   Print version number;  ignore other arguments

 *** Input query options
 -query <File_In>
   Input file name
   Default = `-'
 -query_loc <String>
   Location on the query sequence in 1-based offsets (Format: start-stop)

 *** General search options
 -task <String, Permissible values: 'blastp' 'blastp-fast' 'blastp-short' >
   Task to execute
   Default = `blastp'
 -db <String>
   BLAST database name
    * Incompatible with:  subject, subject_loc
 -out <File_Out, file name length < 256>
   Output file name
   Default = `-'
 -evalue <Real>
   Expectation value (E) threshold for saving hits. Default = 10
 -word_size <Integer, >=2>
   Word size for wordfinder algorithm
 -gapopen <Integer>
   Cost to open a gap
 -gapextend <Integer>
   Cost to extend a gap
 -matrix <String>
   Scoring matrix name (normally BLOSUM62)
 -threshold <Real, >=0>
   Minimum word score such that the word is added to the BLAST lookup table
 -comp_based_stats <String>
   Use composition-based statistics:
       D or d: default (equivalent to 2 )
       0 or F or f: No composition-based statistics
       1: Composition-based statistics as in NAR 29:2994-3005, 2001
       2 or T or t : Composition-based score adjustment as in Bioinformatics
   21:902-911,
       2005, conditioned on sequence properties
       3: Composition-based score adjustment as in Bioinformatics 21:902-911,
       2005, unconditionally
   Default = `2'

 *** BLAST-2-Sequences options
 -subject <File_In>
   Subject sequence(s) to search
    * Incompatible with:  db, gilist, seqidlist, negative_gilist,
   negative_seqidlist, taxids, taxidlist, negative_taxids, negative_taxidlist,
   ipglist, negative_ipglist, db_soft_mask, db_hard_mask
 -subject_loc <String>
   Location on the subject sequence in 1-based offsets (Format: start-stop)
    * Incompatible with:  db, gilist, seqidlist, negative_gilist,
   negative_seqidlist, taxids, taxidlist, negative_taxids, negative_taxidlist,
   ipglist, negative_ipglist, db_soft_mask, db_hard_mask, remote

 *** Formatting options
 -outfmt <String>
   alignment view options:
     0 = Pairwise,
     1 = Query-anchored showing identities,
     2 = Query-anchored no identities,
     3 = Flat query-anchored showing identities,
     4 = Flat query-anchored no identities,
     5 = BLAST XML,
     6 = Tabular,
     7 = Tabular with comment lines,
     8 = Seqalign (Text ASN.1),
     9 = Seqalign (Binary ASN.1),
    10 = Comma-separated values,
    11 = BLAST archive (ASN.1),
    12 = Seqalign (JSON),
    13 = Multiple-file BLAST JSON,
    14 = Multiple-file BLAST XML2,
    15 = Single-file BLAST JSON,
    16 = Single-file BLAST XML2,
    18 = Organism Report
   
   Options 6, 7 and 10 can be additionally configured to produce
   a custom format specified by space delimited format specifiers,
   or by a token specified by the delim keyword.
    E.g.: "10 delim=@ qacc sacc score".
   The delim keyword must appear after the numeric output format
   specification.
   The supported format specifiers are:
   	    qseqid means Query Seq-id
   	       qgi means Query GI
   	      qacc means Query accesion
   	   qaccver means Query accesion.version
   	      qlen means Query sequence length
   	    sseqid means Subject Seq-id
   	 sallseqid means All subject Seq-id(s), separated by a ';'
   	       sgi means Subject GI
   	    sallgi means All subject GIs
   	      sacc means Subject accession
   	   saccver means Subject accession.version
   	   sallacc means All subject accessions
   	      slen means Subject sequence length
   	    qstart means Start of alignment in query
   	      qend means End of alignment in query
   	    sstart means Start of alignment in subject
   	      send means End of alignment in subject
   	      qseq means Aligned part of query sequence
   	      sseq means Aligned part of subject sequence
   	    evalue means Expect value
   	  bitscore means Bit score
   	     score means Raw score
   	    length means Alignment length
   	    pident means Percentage of identical matches
   	    nident means Number of identical matches
   	  mismatch means Number of mismatches
   	  positive means Number of positive-scoring matches
   	   gapopen means Number of gap openings
   	      gaps means Total number of gaps
   	      ppos means Percentage of positive-scoring matches
   	    frames means Query and subject frames separated by a '/'
   	    qframe means Query frame
   	    sframe means Subject frame
   	      btop means Blast traceback operations (BTOP)
   	    staxid means Subject Taxonomy ID
   	  ssciname means Subject Scientific Name
   	  scomname means Subject Common Name
   	sblastname means Subject Blast Name
   	 sskingdom means Subject Super Kingdom
   	   staxids means unique Subject Taxonomy ID(s), separated by a ';'
   			 (in numerical order)
   	 sscinames means unique Subject Scientific Name(s), separated by a ';'
   	 scomnames means unique Subject Common Name(s), separated by a ';'
   	sblastnames means unique Subject Blast Name(s), separated by a ';'
   			 (in alphabetical order)
   	sskingdoms means unique Subject Super Kingdom(s), separated by a ';'
   			 (in alphabetical order) 
   	    stitle means Subject Title
   	salltitles means All Subject Title(s), separated by a '<>'
   	   sstrand means Subject Strand
   	     qcovs means Query Coverage Per Subject
   	   qcovhsp means Query Coverage Per HSP
   	    qcovus means Query Coverage Per Unique Subject (blastn only)
   When not provided, the default value is:
   'qaccver saccver pident length mismatch gapopen qstart qend sstart send
   evalue bitscore', which is equivalent to the keyword 'std'
   Default = `0'
 -show_gis
   Show NCBI GIs in deflines?
 -num_descriptions <Integer, >=0>
   Number of database sequences to show one-line descriptions for
   Not applicable for outfmt > 4
   Default = `500'
    * Incompatible with:  max_target_seqs
 -num_alignments <Integer, >=0>
   Number of database sequences to show alignments for
   Default = `250'
    * Incompatible with:  max_target_seqs
 -line_length <Integer, >=1>
   Line length for formatting alignments
   Not applicable for outfmt > 4
   Default = `60'
 -html
   Produce HTML output?
 -sorthits <Integer, (>=0 and =<4)>
   Sorting option for hits:
   alignment view options:
     0 = Sort by evalue,
     1 = Sort by bit score,
     2 = Sort by total score,
     3 = Sort by percent identity,
     4 = Sort by query coverage
   Not applicable for outfmt > 4
 -sorthsps <Integer, (>=0 and =<4)>
   Sorting option for hps:
     0 = Sort by hsp evalue,
     1 = Sort by hsp score,
     2 = Sort by hsp query start,
     3 = Sort by hsp percent identity,
     4 = Sort by hsp subject start
   Not applicable for outfmt != 0

 *** Query filtering options
 -seg <String>
   Filter query sequence with SEG (Format: 'yes', 'window locut hicut', or
   'no' to disable)
   Default = `no'
 -soft_masking <Boolean>
   Apply filtering locations as soft masks
   Default = `false'
 -lcase_masking
   Use lower case filtering in query and subject sequence(s)?

 *** Restrict search or results
 -gilist <String>
   Restrict search of database to list of GIs
    * Incompatible with:  seqidlist, taxids, taxidlist, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -seqidlist <String>
   Restrict search of database to list of SeqIDs
    * Incompatible with:  gilist, taxids, taxidlist, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_gilist <String>
   Restrict search of database to everything except the specified GIs
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_seqidlist <String>
   Restrict search of database to everything except the specified SeqIDs
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -taxids <String>
   Restrict search of database to include only the specified taxonomy IDs
   (multiple IDs delimited by ',')
    * Incompatible with:  gilist, seqidlist, taxidlist, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_taxids <String>
   Restrict search of database to everything except the specified taxonomy IDs
   (multiple IDs delimited by ',')
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_seqidlist, negative_taxidlist, remote, subject,
   subject_loc
 -taxidlist <String>
   Restrict search of database to include only the specified taxonomy IDs
    * Incompatible with:  gilist, seqidlist, taxids, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_taxidlist <String>
   Restrict search of database to everything except the specified taxonomy IDs
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_seqidlist, negative_taxids, remote, subject,
   subject_loc
 -ipglist <String>
   Restrict search of database to list of IPGs
    * Incompatible with:  subject, subject_loc
 -negative_ipglist <String>
   Restrict search of database to everything except the specified IPGs
    * Incompatible with:  subject, subject_loc
 -entrez_query <String>
   Restrict search with the given Entrez query
    * Requires:  remote
 -db_soft_mask <String>
   Filtering algorithm ID to apply to the BLAST database as soft masking
    * Incompatible with:  db_hard_mask, subject, subject_loc
 -db_hard_mask <String>
   Filtering algorithm ID to apply to the BLAST database as hard masking
    * Incompatible with:  db_soft_mask, subject, subject_loc
 -qcov_hsp_perc <Real, 0..100>
   Percent query coverage per hsp
 -max_hsps <Integer, >=1>
   Set maximum number of HSPs per subject sequence to save for each query
 -culling_limit <Integer, >=0>
   If the query range of a hit is enveloped by that of at least this many
   higher-scoring hits, delete the hit
    * Incompatible with:  best_hit_overhang, best_hit_score_edge
 -best_hit_overhang <Real, (>0 and <0.5)>
   Best Hit algorithm overhang value (recommended value: 0.1)
    * Incompatible with:  culling_limit
 -best_hit_score_edge <Real, (>0 and <0.5)>
   Best Hit algorithm score edge value (recommended value: 0.1)
    * Incompatible with:  culling_limit
 -subject_besthit
   Turn on best hit per subject sequence
 -max_target_seqs <Integer, >=1>
   Maximum number of aligned sequences to keep 
   (value of 5 or more is recommended)
   Default = `500'
    * Incompatible with:  num_descriptions, num_alignments

 *** Statistical options
 -dbsize <Int8>
   Effective length of the database 
 -searchsp <Int8, >=0>
   Effective length of the search space

 *** Search strategy options
 -import_search_strategy <File_In>
   Search strategy to use
    * Incompatible with:  export_search_strategy
 -export_search_strategy <File_Out>
   File name to record the search strategy used
    * Incompatible with:  import_search_strategy

 *** Extension options
 -xdrop_ungap <Real>
   X-dropoff value (in bits) for ungapped extensions
 -xdrop_gap <Real>
   X-dropoff value (in bits) for preliminary gapped extensions
 -xdrop_gap_final <Real>
   X-dropoff value (in bits) for final gapped alignment
 -window_size <Integer, >=0>
   Multiple hits window size, use 0 to specify 1-hit algorithm
 -ungapped
   Perform ungapped alignment only?

 *** Miscellaneous options
 -parse_deflines
   Should the query and subject defline(s) be parsed?
 -num_threads <Integer, >=1>
   Number of threads (CPUs) to use in the BLAST search
   Default = `1'
    * Incompatible with:  remote
 -mt_mode <Integer, (>=0 and =<1)>
   Multi-thread mode to use in BLAST search:
    0 (auto) split by database 
    1 split by queries
   Default = `0'
    * Requires:  num_threads
 -remote
   Execute search remotely?
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_seqidlist, negative_taxids, negative_taxidlist,
   subject_loc, num_threads
 -use_sw_tback
   Compute locally optimal Smith-Waterman alignments?
```


## trinotate_blastx

### Tool Description
Translated Query-Protein Subject BLAST 2.14.1+

### Metadata
- **Docker Image**: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
- **Homepage**: https://trinotate.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/trinotate/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE
  blastx [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-task task_name] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-taxids taxids] [-negative_taxids taxids] [-taxidlist filename]
    [-negative_taxidlist filename] [-ipglist filename]
    [-negative_ipglist filename] [-entrez_query entrez_query]
    [-db_soft_mask filtering_algorithm] [-db_hard_mask filtering_algorithm]
    [-subject subject_input_file] [-subject_loc range] [-query input_file]
    [-out output_file] [-evalue evalue] [-word_size int_value]
    [-gapopen open_penalty] [-gapextend extend_penalty]
    [-qcov_hsp_perc float_value] [-max_hsps int_value]
    [-xdrop_ungap float_value] [-xdrop_gap float_value]
    [-xdrop_gap_final float_value] [-searchsp int_value]
    [-sum_stats bool_value] [-max_intron_length length] [-seg SEG_options]
    [-soft_masking soft_masking] [-matrix matrix_name]
    [-threshold float_value] [-culling_limit int_value]
    [-best_hit_overhang float_value] [-best_hit_score_edge float_value]
    [-subject_besthit] [-window_size int_value] [-ungapped] [-lcase_masking]
    [-query_loc range] [-strand strand] [-parse_deflines]
    [-query_gencode int_value] [-outfmt format] [-show_gis]
    [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-sorthits sort_hits]
    [-sorthsps sort_hsps] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-mt_mode int_value] [-remote]
    [-comp_based_stats compo] [-use_sw_tback] [-version]

DESCRIPTION
   Translated Query-Protein Subject BLAST 2.14.1+

OPTIONAL ARGUMENTS
 -h
   Print USAGE and DESCRIPTION;  ignore all other parameters
 -help
   Print USAGE, DESCRIPTION and ARGUMENTS; ignore all other parameters
 -version
   Print version number;  ignore other arguments

 *** Input query options
 -query <File_In>
   Input file name
   Default = `-'
 -query_loc <String>
   Location on the query sequence in 1-based offsets (Format: start-stop)
 -strand <String, `both', `minus', `plus'>
   Query strand(s) to search against database/subject
   Default = `both'
 -query_gencode <Integer, values between: 1-6, 9-16, 21-31, 33>
   Genetic code to use to translate query (see
   https://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=
   cgencodes for details)
   Default = `1'

 *** General search options
 -task <String, Permissible values: 'blastx' 'blastx-fast' >
   Task to execute
   Default = `blastx'
 -db <String>
   BLAST database name
    * Incompatible with:  subject, subject_loc
 -out <File_Out, file name length < 256>
   Output file name
   Default = `-'
 -evalue <Real>
   Expectation value (E) threshold for saving hits. Default = 10
 -word_size <Integer, >=2>
   Word size for wordfinder algorithm
 -gapopen <Integer>
   Cost to open a gap
 -gapextend <Integer>
   Cost to extend a gap
 -max_intron_length <Integer, >=0>
   Length of the largest intron allowed in a translated nucleotide sequence
   when linking multiple distinct alignments
   Default = `0'
 -matrix <String>
   Scoring matrix name (normally BLOSUM62)
 -threshold <Real, >=0>
   Minimum word score such that the word is added to the BLAST lookup table
 -comp_based_stats <String>
   Use composition-based statistics:
       D or d: default (equivalent to 2 )
       0 or F or f: No composition-based statistics
       1: Composition-based statistics as in NAR 29:2994-3005, 2001
       2 or T or t : Composition-based score adjustment as in Bioinformatics
   21:902-911,
       2005, conditioned on sequence properties
       3: Composition-based score adjustment as in Bioinformatics 21:902-911,
       2005, unconditionally
   Default = `2'

 *** BLAST-2-Sequences options
 -subject <File_In>
   Subject sequence(s) to search
    * Incompatible with:  db, gilist, seqidlist, negative_gilist,
   negative_seqidlist, taxids, taxidlist, negative_taxids, negative_taxidlist,
   ipglist, negative_ipglist, db_soft_mask, db_hard_mask
 -subject_loc <String>
   Location on the subject sequence in 1-based offsets (Format: start-stop)
    * Incompatible with:  db, gilist, seqidlist, negative_gilist,
   negative_seqidlist, taxids, taxidlist, negative_taxids, negative_taxidlist,
   ipglist, negative_ipglist, db_soft_mask, db_hard_mask, remote

 *** Formatting options
 -outfmt <String>
   alignment view options:
     0 = Pairwise,
     1 = Query-anchored showing identities,
     2 = Query-anchored no identities,
     3 = Flat query-anchored showing identities,
     4 = Flat query-anchored no identities,
     5 = BLAST XML,
     6 = Tabular,
     7 = Tabular with comment lines,
     8 = Seqalign (Text ASN.1),
     9 = Seqalign (Binary ASN.1),
    10 = Comma-separated values,
    11 = BLAST archive (ASN.1),
    12 = Seqalign (JSON),
    13 = Multiple-file BLAST JSON,
    14 = Multiple-file BLAST XML2,
    15 = Single-file BLAST JSON,
    16 = Single-file BLAST XML2,
    18 = Organism Report
   
   Options 6, 7 and 10 can be additionally configured to produce
   a custom format specified by space delimited format specifiers,
   or by a token specified by the delim keyword.
    E.g.: "10 delim=@ qacc sacc score".
   The delim keyword must appear after the numeric output format
   specification.
   The supported format specifiers are:
   	    qseqid means Query Seq-id
   	       qgi means Query GI
   	      qacc means Query accesion
   	   qaccver means Query accesion.version
   	      qlen means Query sequence length
   	    sseqid means Subject Seq-id
   	 sallseqid means All subject Seq-id(s), separated by a ';'
   	       sgi means Subject GI
   	    sallgi means All subject GIs
   	      sacc means Subject accession
   	   saccver means Subject accession.version
   	   sallacc means All subject accessions
   	      slen means Subject sequence length
   	    qstart means Start of alignment in query
   	      qend means End of alignment in query
   	    sstart means Start of alignment in subject
   	      send means End of alignment in subject
   	      qseq means Aligned part of query sequence
   	      sseq means Aligned part of subject sequence
   	    evalue means Expect value
   	  bitscore means Bit score
   	     score means Raw score
   	    length means Alignment length
   	    pident means Percentage of identical matches
   	    nident means Number of identical matches
   	  mismatch means Number of mismatches
   	  positive means Number of positive-scoring matches
   	   gapopen means Number of gap openings
   	      gaps means Total number of gaps
   	      ppos means Percentage of positive-scoring matches
   	    frames means Query and subject frames separated by a '/'
   	    qframe means Query frame
   	    sframe means Subject frame
   	      btop means Blast traceback operations (BTOP)
   	    staxid means Subject Taxonomy ID
   	  ssciname means Subject Scientific Name
   	  scomname means Subject Common Name
   	sblastname means Subject Blast Name
   	 sskingdom means Subject Super Kingdom
   	   staxids means unique Subject Taxonomy ID(s), separated by a ';'
   			 (in numerical order)
   	 sscinames means unique Subject Scientific Name(s), separated by a ';'
   	 scomnames means unique Subject Common Name(s), separated by a ';'
   	sblastnames means unique Subject Blast Name(s), separated by a ';'
   			 (in alphabetical order)
   	sskingdoms means unique Subject Super Kingdom(s), separated by a ';'
   			 (in alphabetical order) 
   	    stitle means Subject Title
   	salltitles means All Subject Title(s), separated by a '<>'
   	   sstrand means Subject Strand
   	     qcovs means Query Coverage Per Subject
   	   qcovhsp means Query Coverage Per HSP
   	    qcovus means Query Coverage Per Unique Subject (blastn only)
   When not provided, the default value is:
   'qaccver saccver pident length mismatch gapopen qstart qend sstart send
   evalue bitscore', which is equivalent to the keyword 'std'
   Default = `0'
 -show_gis
   Show NCBI GIs in deflines?
 -num_descriptions <Integer, >=0>
   Number of database sequences to show one-line descriptions for
   Not applicable for outfmt > 4
   Default = `500'
    * Incompatible with:  max_target_seqs
 -num_alignments <Integer, >=0>
   Number of database sequences to show alignments for
   Default = `250'
    * Incompatible with:  max_target_seqs
 -line_length <Integer, >=1>
   Line length for formatting alignments
   Not applicable for outfmt > 4
   Default = `60'
 -html
   Produce HTML output?
 -sorthits <Integer, (>=0 and =<4)>
   Sorting option for hits:
   alignment view options:
     0 = Sort by evalue,
     1 = Sort by bit score,
     2 = Sort by total score,
     3 = Sort by percent identity,
     4 = Sort by query coverage
   Not applicable for outfmt > 4
 -sorthsps <Integer, (>=0 and =<4)>
   Sorting option for hps:
     0 = Sort by hsp evalue,
     1 = Sort by hsp score,
     2 = Sort by hsp query start,
     3 = Sort by hsp percent identity,
     4 = Sort by hsp subject start
   Not applicable for outfmt != 0

 *** Query filtering options
 -seg <String>
   Filter query sequence with SEG (Format: 'yes', 'window locut hicut', or
   'no' to disable)
   Default = `12 2.2 2.5'
 -soft_masking <Boolean>
   Apply filtering locations as soft masks
   Default = `false'
 -lcase_masking
   Use lower case filtering in query and subject sequence(s)?

 *** Restrict search or results
 -gilist <String>
   Restrict search of database to list of GIs
    * Incompatible with:  seqidlist, taxids, taxidlist, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -seqidlist <String>
   Restrict search of database to list of SeqIDs
    * Incompatible with:  gilist, taxids, taxidlist, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_gilist <String>
   Restrict search of database to everything except the specified GIs
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_seqidlist <String>
   Restrict search of database to everything except the specified SeqIDs
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -taxids <String>
   Restrict search of database to include only the specified taxonomy IDs
   (multiple IDs delimited by ',')
    * Incompatible with:  gilist, seqidlist, taxidlist, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_taxids <String>
   Restrict search of database to everything except the specified taxonomy IDs
   (multiple IDs delimited by ',')
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_seqidlist, negative_taxidlist, remote, subject,
   subject_loc
 -taxidlist <String>
   Restrict search of database to include only the specified taxonomy IDs
    * Incompatible with:  gilist, seqidlist, taxids, negative_gilist,
   negative_seqidlist, negative_taxids, negative_taxidlist, remote, subject,
   subject_loc
 -negative_taxidlist <String>
   Restrict search of database to everything except the specified taxonomy IDs
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_seqidlist, negative_taxids, remote, subject,
   subject_loc
 -ipglist <String>
   Restrict search of database to list of IPGs
    * Incompatible with:  subject, subject_loc
 -negative_ipglist <String>
   Restrict search of database to everything except the specified IPGs
    * Incompatible with:  subject, subject_loc
 -entrez_query <String>
   Restrict search with the given Entrez query
    * Requires:  remote
 -db_soft_mask <String>
   Filtering algorithm ID to apply to the BLAST database as soft masking
    * Incompatible with:  db_hard_mask, subject, subject_loc
 -db_hard_mask <String>
   Filtering algorithm ID to apply to the BLAST database as hard masking
    * Incompatible with:  db_soft_mask, subject, subject_loc
 -qcov_hsp_perc <Real, 0..100>
   Percent query coverage per hsp
 -max_hsps <Integer, >=1>
   Set maximum number of HSPs per subject sequence to save for each query
 -culling_limit <Integer, >=0>
   If the query range of a hit is enveloped by that of at least this many
   higher-scoring hits, delete the hit
    * Incompatible with:  best_hit_overhang, best_hit_score_edge
 -best_hit_overhang <Real, (>0 and <0.5)>
   Best Hit algorithm overhang value (recommended value: 0.1)
    * Incompatible with:  culling_limit
 -best_hit_score_edge <Real, (>0 and <0.5)>
   Best Hit algorithm score edge value (recommended value: 0.1)
    * Incompatible with:  culling_limit
 -subject_besthit
   Turn on best hit per subject sequence
 -max_target_seqs <Integer, >=1>
   Maximum number of aligned sequences to keep 
   (value of 5 or more is recommended)
   Default = `500'
    * Incompatible with:  num_descriptions, num_alignments

 *** Statistical options
 -dbsize <Int8>
   Effective length of the database 
 -searchsp <Int8, >=0>
   Effective length of the search space
 -sum_stats <Boolean>
   Use sum statistics

 *** Search strategy options
 -import_search_strategy <File_In>
   Search strategy to use
    * Incompatible with:  export_search_strategy
 -export_search_strategy <File_Out>
   File name to record the search strategy used
    * Incompatible with:  import_search_strategy

 *** Extension options
 -xdrop_ungap <Real>
   X-dropoff value (in bits) for ungapped extensions
 -xdrop_gap <Real>
   X-dropoff value (in bits) for preliminary gapped extensions
 -xdrop_gap_final <Real>
   X-dropoff value (in bits) for final gapped alignment
 -window_size <Integer, >=0>
   Multiple hits window size, use 0 to specify 1-hit algorithm
 -ungapped
   Perform ungapped alignment only?

 *** Miscellaneous options
 -parse_deflines
   Should the query and subject defline(s) be parsed?
 -num_threads <Integer, >=1>
   Number of threads (CPUs) to use in the BLAST search
   Default = `1'
    * Incompatible with:  remote
 -mt_mode <Integer, (>=0 and =<1)>
   Multi-thread mode to use in BLAST search:
    0 (auto) split by database 
    1 split by queries
   Default = `0'
    * Requires:  num_threads
 -remote
   Execute search remotely?
    * Incompatible with:  gilist, seqidlist, taxids, taxidlist,
   negative_gilist, negative_seqidlist, negative_taxids, negative_taxidlist,
   subject_loc, num_threads
 -use_sw_tback
   Compute locally optimal Smith-Waterman alignments?
```


## trinotate_hmmscan

### Tool Description
search sequence(s) against a profile database

### Metadata
- **Docker Image**: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
- **Homepage**: https://trinotate.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/trinotate/overview
- **Validation**: PASS

### Original Help Text
```text
# hmmscan :: search sequence(s) against a profile database
# HMMER 3.3.2 (Nov 2020); http://hmmer.org/
# Copyright (C) 2020 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Usage: hmmscan [-options] <hmmdb> <seqfile>

Basic options:
  -h : show brief help on version and usage

Options controlling output:
  -o <f>           : direct output to file <f>, not stdout
  --tblout <f>     : save parseable table of per-sequence hits to file <f>
  --domtblout <f>  : save parseable table of per-domain hits to file <f>
  --pfamtblout <f> : save table of hits and domains to file, in Pfam format <f>
  --acc            : prefer accessions over names in output
  --noali          : don't output alignments, so output is smaller
  --notextw        : unlimit ASCII text output line width
  --textw <n>      : set max width of ASCII text output lines  [120]  (n>=120)

Options controlling reporting thresholds:
  -E <x>     : report models <= this E-value threshold in output  [10.0]  (x>0)
  -T <x>     : report models >= this score threshold in output
  --domE <x> : report domains <= this E-value threshold in output  [10.0]  (x>0)
  --domT <x> : report domains >= this score cutoff in output

Options controlling inclusion (significance) thresholds:
  --incE <x>    : consider models <= this E-value threshold as significant
  --incT <x>    : consider models >= this score threshold as significant
  --incdomE <x> : consider domains <= this E-value threshold as significant
  --incdomT <x> : consider domains >= this score threshold as significant

Options for model-specific thresholding:
  --cut_ga : use profile's GA gathering cutoffs to set all thresholding
  --cut_nc : use profile's NC noise cutoffs to set all thresholding
  --cut_tc : use profile's TC trusted cutoffs to set all thresholding

Options controlling acceleration heuristics:
  --max    : Turn all heuristic filters off (less speed, more power)
  --F1 <x> : MSV threshold: promote hits w/ P <= F1  [0.02]
  --F2 <x> : Vit threshold: promote hits w/ P <= F2  [1e-3]
  --F3 <x> : Fwd threshold: promote hits w/ P <= F3  [1e-5]
  --nobias : turn off composition bias filter

Other expert options:
  --nonull2     : turn off biased composition score corrections
  -Z <x>        : set # of comparisons done, for E-value calculation
  --domZ <x>    : set # of significant seqs, for domain E-value calculation
  --seed <n>    : set RNG seed to <n> (if 0: one-time arbitrary seed)  [42]
  --qformat <s> : assert input <seqfile> is in format <s>: no autodetection
  --cpu <n>     : number of parallel CPU workers to use for multithreads  [2]
```

