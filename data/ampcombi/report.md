# ampcombi CWL Generation Report

## ampcombi_parse_tables

### Tool Description
Parse and summarize results from various AMP (Antimicrobial Peptide) prediction tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/Darcy220606/AMPcombi
- **Package**: https://anaconda.org/channels/bioconda/packages/ampcombi/overview
- **Validation**: PASS
- **usage**: https://ampcombi.readthedocs.io/en/main/usage.html

- **Conda**: https://anaconda.org/channels/bioconda/packages/ampcombi/overview
- **Total Downloads**: 14.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Darcy220606/AMPcombi
- **Stars**: N/A
### Original Help Text
```text
usage: ampcombi [options] parse_tables [-h] [--amp_results [AMP]]
                                       [--sample_list [SAMPLES ...]]
                                       [--path_list [FILES ...]]
                                       [--amp_cutoff P]
                                       [--hmm_evalue HMMEVALUE]
                                       [--db_evalue DBEVALUE]
                                       [--aminoacid_length LENGTH]
                                       [--window_size_stop_codon STOPWINDOWSIZE]
                                       [--window_size_transporter TRANSPORTERWINDOWSIZE]
                                       [--remove_stop_codons REMOVESTOPS]
                                       [--faa FAA] [--gbk GBK]
                                       [--ampir_file [AMPIR]]
                                       [--amplify_file [AMPLIFY]]
                                       [--macrel_file [MACREL]]
                                       [--neubi_file [NEUBI]]
                                       [--hmmsearch_file [HMMSEARCH]]
                                       [--ensemblamppred_file [AMPPRED]]
                                       [--ampgram_file [AMPGRAM]]
                                       [--amptransformer_file [AMPTRANSFORMER]]
                                       [--amp_database_dir [REF_DB_DIR]]
                                       [--amp_database [REF_DB]]
                                       [--interproscan_output INTERPRO]
                                       [--interproscan_filter INTERPRO_REMOVE]
                                       [--sample_metadata SAMPLEMETADATA]
                                       [--contig_metadata CONTIGMETADATA]
                                       [--log [LOG_FILE]] [--threads [CORES]]
                                       [--version]

options:
  -h, --help            show this help message and exit
  --amp_results [AMP]   Enter the path to the folder that contains the
                        different tool's output files in sub-folders named by
                        sample name. If paths are to be inferred, sub-folders
                        in this results-directory have to be organized like
                        '/amp_results/toolsubdir/samplesubdir/sample.filetype'
                        (default: ./test_files/)
  --sample_list [SAMPLES ...]
                        Enter a list of sample-names, e.g. sample_1 sample_2
                        sample_n. If not given, the sample-names will be
                        inferred from the folder structure
  --path_list [FILES ...]
                        Enter the list of paths to the files to be summarized
                        as a list of lists, e.g. --path_list
                        path/to/tool1/sample1/sample1.tsv
                        path/to/tool2/sample1/sample1.tsv --path_list
                        path/to/tool1/sample2.tsv path/to/tool2/sample2.tsv.
                        If not given, the file-paths will be inferred from the
                        folder structure
  --amp_cutoff P        Enter the probability cutoff for AMPs for all tools
                        except for HMMsearch (default: 0.0)
  --hmm_evalue HMMEVALUE
                        Enter the E-value cutoff for AMPs for HMMsearch
                        (default: None)
  --db_evalue DBEVALUE  Enter the E-value cutoff for AMPs for the database
                        diamond alignment. Any E-value below this value will
                        only remove the DRAMP classification and not the
                        entire hit (default: 0.05)
  --aminoacid_length LENGTH
                        Enter the length of the aa sequences required. Any
                        hits below that cutoff will be removed (default: 100)
  --window_size_stop_codon STOPWINDOWSIZE
                        Enter the length of the window size required to look
                        for stop codons downstream and upstream of the CDS
                        hits. (default: 60)
  --window_size_transporter TRANSPORTERWINDOWSIZE
                        Enter the length of the window size required to look
                        for a 'transporter' e.g. ABC transporter downstream
                        and upstream of the CDS hits. (default: 11)
  --remove_stop_codons REMOVESTOPS
                        Removes any hits/CDSs that don't have a stop codon
                        found in the window below or upstream of the CDS
                        assigned by '--window_size_stop_codon'. Must be turned
                        on if hits are to be removed. (default: False)
  --faa FAA             Enter the path to the folder containing the reference
                        .faa files or to one .faa file (running only one
                        sample). Filenames have to contain the corresponding
                        sample-name, i.e. sample_1.faa (default: ./test_faa/)
  --gbk GBK             Enter the path to the folder containing the reference
                        .gbk/.gbff files or to one .gbk/.gbff file (running
                        only one sample). Filenames have to contain the
                        corresponding sample-name, i.e. sample_1.gbk/
                        sample_1.gbff (default: ./test_gbff/)
  --ampir_file [AMPIR]  If AMPir was used, enter the ending of the input files
                        (as they appear in the directory tree), e.g.
                        'ampir.tsv'
  --amplify_file [AMPLIFY]
                        If AMPlify was used, enter the ending of the input
                        files (as they appear in the directory tree), e.g.
                        'amplify.tsv'
  --macrel_file [MACREL]
                        If Macrel was used, enter the ending of the input
                        files (as they appear in the directory tree), e.g.
                        'macrel.tsv'
  --neubi_file [NEUBI]  If Neubi was used, enter the ending of the input files
                        (as they appear in the directory tree), e.g.
                        'neubi.fasta'
  --hmmsearch_file [HMMSEARCH]
                        If HMMer/HMMsearch was used, enter the ending of the
                        input files (as they appear in the directory tree),
                        e.g. 'hmmsearch.txt'
  --ensemblamppred_file [AMPPRED]
                        If EnsemblAMPpred was used, enter the ending of the
                        input files (as they appear in the directory tree),
                        e.g. 'ensembleamppred.txt'
  --ampgram_file [AMPGRAM]
                        If AMPgram was used, enter the ending of the input
                        files (as they appear in the directory tree), e.g.
                        'ampgram.txt'
  --amptransformer_file [AMPTRANSFORMER]
                        If AMPtransformer was used, enter the ending of the
                        input files (as they appear in the directory tree),
                        e.g. 'amptransformer.txt'
  --amp_database_dir [REF_DB_DIR]
                        Enter the path to the folder containing the reference
                        database files (.fa and .tsv); a fasta file and the
                        corresponding table with functional and taxonomic
                        classifications. (default: None)
  --amp_database [REF_DB]
                        Enter the name of the database to be used to classify
                        the AMPs. Can either be APD, DRAMP, or UniRef100
                        (default: DRAMP)
  --interproscan_output INTERPRO
                        Enter the path to the folder containing the output
                        obtained from interproscan (i.e., in '*.faa.tsv').
                        NOTE: ONLY tested against output from applications:[PA
                        NTHER,ProSiteProfiles,ProSitePatterns,Pfam]. (default:
                        None)
  --interproscan_filter INTERPRO_REMOVE
                        Enter a comma seperated list of all keywords that
                        describes the protein that is not required in the
                        analysis. This is case insensitive. (default:
                        ribosomal protein,ribosomal proteins,ribosome
                        protein,ribosomal rna,Ribosomal protein,RIBOSOMAL
                        PROTEIN)
  --sample_metadata SAMPLEMETADATA
                        Path to a tsv-file containing sample metadata, e,g,
                        'path/to/sample_metadata.tsv'. The metadata table can
                        have more information for sample identification that
                        will be added to the output summary. The table needs
                        to contain the sample names in the first column.
                        (default: None)
  --contig_metadata CONTIGMETADATA
                        Path to a tsv-file containing contig metadata, e,g,
                        'path/to/contig_metadata.tsv'. The metadata table can
                        have more information for contig classification that
                        will be added to the output summary. The table needs
                        to contain the sample names in the first column and
                        the contig_ID in the second column. This can be the
                        output from MMseqs2, pydamage and MetaWrap. (default:
                        None)
  --log [LOG_FILE]      Silences the standard output and captures it in a log
                        file)
  --threads [CORES]     Changes the threads used for DIAMOND alignment
                        (default: 4)
  --version             show program's version number and exit
```


## ampcombi_complete

### Tool Description
Complete the ampcombi analysis by aggregating summary files from a directory or a list of files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/Darcy220606/AMPcombi
- **Package**: https://anaconda.org/channels/bioconda/packages/ampcombi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ampcombi [options] complete [-h] [--summaries_directory [SUMMARYDIR]]
                                   [--summaries_files SUMMARYFILE [SUMMARYFILE ...]]
                                   [--log [LOG_FILE]] [--version]

options:
  -h, --help            show this help message and exit
  --summaries_directory [SUMMARYDIR]
                        Enter a directory path in which summaries are in
                        samples directories, e.g. './ampcombi_parse_tables/'
  --summaries_files SUMMARYFILE [SUMMARYFILE ...]
                        Enter a list of samples' ampcombi summaries, e.g.
                        ./ampcombi/sample_1/sample_1_ampcombi.tsv
                        ./ampcombi/sample_2_ampcombi.tsv
  --log [LOG_FILE]      Silences the standard output and captures it in a log
                        file)
  --version             show program's version number and exit
```


## ampcombi_cluster

### Tool Description
Clustering of AMPs using mmseqs2 based on the Ampcombi summary results.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/Darcy220606/AMPcombi
- **Package**: https://anaconda.org/channels/bioconda/packages/ampcombi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ampcombi [options] cluster [-h] [--ampcombi_summary [COMPLETESUMMARY]]
                                  [--cluster_cov_mode [MMSEQSCOVMODE]]
                                  [--cluster_mode [MMSEQSCLUSTERMODE]]
                                  [--cluster_coverage [MMSEQSCOVERAGE]]
                                  [--cluster_seq_id [MMSEQSSEQID]]
                                  [--cluster_sensitivity [MMSEQSSENSITIVITY]]
                                  [--cluster_remove_singletons [REMOVESINGLETONS]]
                                  [--cluster_retain_label [RETAINLABELS]]
                                  [--cluster_min_member [MINNUMBER]]
                                  [--threads [CORES]] [--log [LOG_FILE]]
                                  [--version]

options:
  -h, --help            show this help message and exit
  --ampcombi_summary [COMPLETESUMMARY]
                        Enter a file path corresponding to the
                        Ampcombi_summary.tsv that can be generated by running
                        --ampcombi complete. (default: ./Ampcombi_summary.tsv)
  --cluster_cov_mode [MMSEQSCOVMODE]
                        This assigns the cov. mode to the mmseqs2 cluster
                        module- More information can be obtained in mmseqs2
                        docs at https://mmseqs.com/latest/userguide.pdf
  --cluster_mode [MMSEQSCLUSTERMODE]
                        This assigns the cluster mode to the mmseqs2 cluster
                        module- More information can be obtained in mmseqs2
                        docs at https://mmseqs.com/latest/userguide.pdf
  --cluster_coverage [MMSEQSCOVERAGE]
                        This assigns the coverage to the mmseqs2 cluster
                        module- More information can be obtained in mmseqs2
                        docs at https://mmseqs.com/latest/userguide.pdf
  --cluster_seq_id [MMSEQSSEQID]
                        This assigns the seqsid to the mmseqs2 cluster module-
                        More information can be obtained in mmseqs2 docs at
                        https://mmseqs.com/latest/userguide.pdf
  --cluster_sensitivity [MMSEQSSENSITIVITY]
                        This assigns sensitivity of alignment to the mmseqs2
                        cluster module- More information can be obtained in
                        mmseqs2 docs at
                        https://mmseqs.com/latest/userguide.pdf
  --cluster_remove_singletons [REMOVESINGLETONS]
                        This removes any hits that did not form a cluster
  --cluster_retain_label [RETAINLABELS]
                        This removes any cluster that only has a certain label
                        in the sample name. For example if you have samples
                        labels with 'S1_metaspades' and 'S1_megahit', you can
                        retain clusters that have samples with suffix
                        '_megahit' by running '--retain_clusters_label
                        megahit'
  --cluster_min_member [MINNUMBER]
                        This removes any cluster that has a hit number lower
                        than this
  --threads [CORES]     Changes the threads used for DIAMOND alignment
                        (default: 4)
  --log [LOG_FILE]      Silences the standard output and captures it in a log
                        file)
  --version             show program's version number and exit
```


## ampcombi_signal_peptide

### Tool Description
Identify signal peptides using SignalP models and Ampcombi cluster summaries.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/Darcy220606/AMPcombi
- **Package**: https://anaconda.org/channels/bioconda/packages/ampcombi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ampcombi [options] signal_peptide [-h]
                                         [--ampcombi_cluster [CLUSTERSUMMARY]]
                                         [--signalp_model [SIGNALPMODELS]]
                                         [--log [LOG_FILE]] [--version]

options:
  -h, --help            show this help message and exit
  --ampcombi_cluster [CLUSTERSUMMARY]
                        Enter a file path corresponding to the
                        Ampcombi_summary_cluster.tsv that can be generated by
                        running --ampcombi cluster. (default:
                        ./Ampcombi_summary_cluster.tsv)
  --signalp_model [SIGNALPMODELS]
                        Enter a directory path corresponding to the signalp
                        models. More information can be found in signalp
                        documentation at https://services.healthtech.dtu.dk/se
                        rvices/SignalP-6.0/
  --log [LOG_FILE]      Silences the standard output and captures it in a log
                        file)
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated
