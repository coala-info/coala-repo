# mitoz CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mitoz_all | PASS | full pipeline on the MitoZ test reads gave a circular 16453 bp annotated mitogenome (closest species Limulus polyphemus) |
| mitoz_annotate | PASS | annotation of the MitoZ example mitogenome matches the stored result except four gene boundaries (version difference) |
| mitoz_assemble | Not completed | megahit assembled a circular 16453 bp mitogenome with 11 full-length genes from the MitoZ test reads, but the repo's stored example result differs (18419 bp, linear), so the assembly cannot be confirmed. |
| mitoz_filter | PASS | all reads of the small MitoZ test set passed the filter (49392 pairs kept) |
| mitoz_findmitoscaf | PASS |  |
| mitoz_tools_bold_identification | Not completed | the BOLD web page the tool reads no longer exists (404 at boldsystems.org), so no identification can be returned |
| mitoz_tools_circle_check | PASS |  |
| mitoz_tools_gbfiletool_comrev | PASS |  |
| mitoz_tools_gbfiletool_cut | PASS |  |
| mitoz_tools_gbfiletool_select | PASS |  |
| mitoz_tools_gbfiletool_sort | PASS |  |
| mitoz_tools_gbseqextractor | PASS |  |
| mitoz_tools_group_seq_by_gene | PASS |  |
| mitoz_tools_msaconverter | PASS |  |
| mitoz_tools_taxonomy_ranks | PASS |  |
| mitoz_visualize | PASS |  |

## mitoz_filter

### Tool Description
Filter input fastq reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Total Downloads**: 17.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linzhi2013/MitoZ
- **Stars**: N/A
### Original Help Text
```text
usage: mitoz filter [-h] --fq1 <file> [--fq2 <file>] [--phred64]
                    [--outprefix <str>] [--fastq_read_length <INT>]
                    [--data_size_for_mt_assembly <float1>,<float2>]
                    [--filter_other_para <str>] [--thread_number <int>]
                    [--workdir <directory>] [--workdir_done <directory>]
                    [--workdir_log <directory>]

Filter input fastq reads.

optional arguments:
  -h, --help            show this help message and exit
  --fq1 <file>          Fastq1 file
  --fq2 <file>          Fastq2 file
  --phred64             Are the fastq phred64 encoded? [False]
  --outprefix <str>     output prefix [out]
  --fastq_read_length <INT>
                        read length of fastq reads, used to split clean fastq
                        files. [150]
  --data_size_for_mt_assembly <float1>,<float2>
                        Data size (Gbp) used for mitochondrial genome
                        assembly, usually between 3~8 Gbp is enough. The
                        float1 means the size (Gbp) of raw data to be
                        subsampled, while the float2 means the size of clean
                        data should be >= float2 Gbp, otherwise MitoZ will
                        stop to run. When only float1 is set, float2 is
                        assumed to be 0. Set float1 to be 0 if you want to use
                        ALL raw data. [5,0]
  --filter_other_para <str>
                        other parar. []
  --thread_number <int>
                        thread number [4]
  --workdir <directory>
                        working directory [./]
  --workdir_done <directory>
                        done directory [./done]
  --workdir_log <directory>
                        log directory [./log]
```


## mitoz_assemble

### Tool Description
Mitochondrial genome assembly from input fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mitoz assemble [-h] [--workdir <STR>] --outprefix <STR>
                      [--thread_number <INT>] --fq1 <file> [--fq2 <file>]
                      [--insert_size <INT>] [--fastq_read_length <INT>]
                      [--assembler {mitoassemble,spades,megahit}]
                      [--tmp_dir <STR>] [--kmers <INT> [<INT> ...]]
                      [--kmers_megahit <INT> [<INT> ...]]
                      [--kmers_spades <INT> [<INT> ...]] [--memory <INT>]
                      [--resume_assembly] [--profiles_dir <STR>]
                      [--slow_search] [--filter_by_taxa] --requiring_taxa
                      <STR> [--requiring_relax {0,1,2,3,4,5,6}]
                      [--min_abundance <float>] [--abundance_pattern <STR>]
                      [--genetic_code <INT>]
                      [--clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}]

Mitochondrial genome assembly from input fastq files.

optional arguments:
  -h, --help            show this help message and exit

Common arguments:
  --workdir <STR>       workdir [./]
  --outprefix <STR>     output prefix
  --thread_number <INT>
                        thread number. Caution: For spades, --thread_number 32
                        can take 150 GB RAM! Setting this to 8 to 16 is
                        typically good. [8]

Input fastq files:
  --fq1 <file>          fastq 1 file. Set only this option but not --fastq2
                        means SE data. [required]
  --fq2 <file>          fastq 2 file (optional for mitoassemble and megahit,
                        required for spades)
  --insert_size <INT>   insert size of input fastq files [250]
  --fastq_read_length <INT>
                        read length of fastq reads, used by mitoAssemble.
                        [150]

Assembly arguments:
  --assembler {mitoassemble,spades,megahit}
                        Assembler to be used. [megahit]
  --tmp_dir <STR>       Set temp directory for megahit if necessary (See
                        https://github.com/linzhi2013/MitoZ/issues/176)
  --kmers <INT> [<INT> ...]
                        kmer size(s) to be used. Multiple kmers can be used,
                        separated by space. Only for mitoassemble [71]
  --kmers_megahit <INT> [<INT> ...]
                        kmer size(s) to be used. Multiple kmers can be used,
                        separated by space. Only for megahit [21 29 39 59 79
                        99 119 141]
  --kmers_spades <INT> [<INT> ...]
                        kmer size(s) to be used. Multiple kmers can be used,
                        separated by space. Only for spades ['auto']
  --memory <INT>        memory size limit for spades/megahit, no enough memory
                        will make the two programs halt or exit [50]
  --resume_assembly     to resume previous assembly running [False]

Search mitochondrial sequences arguments:
  --profiles_dir <STR>  Directory cotaining 'CDS_HMM/', 'MT_database/' and
                        'rRNA_CM/'. [/usr/local/lib/python3.8/site-
                        packages/mitoz/profiles]
  --slow_search         By default, we firstly use tiara to perform quick
                        sequence classification (100 times faster than
                        usual!), however, it is valid only when your
                        mitochondrial sequences are >= 3000 bp. If you have
                        missing genes, set '--slow_search' to use the
                        tradicitiona search mode. [False]
  --filter_by_taxa      filter out non-requiring_taxa sequences by mito-PCGs
                        annotation to do taxa assignment.[True]
  --requiring_taxa <STR>
                        filtering out non-requiring taxa sequences which may
                        be contamination [required]
  --requiring_relax {0,1,2,3,4,5,6}
                        The relaxing threshold for filtering non-target-
                        requiring_taxa. The larger digital means more
                        relaxing. [0]
  --min_abundance <float>
                        the minimum abundance of sequence required. Set this
                        to any value <= 0 if you do NOT want to filter
                        sequences by abundance [10]
  --abundance_pattern <STR>
                        the regular expression pattern to capture the
                        abundance information in the header of sequence
                        ['abun\=([0-9]+\.*[0-9]*)']
  --genetic_code <INT>  which genetic code table to use? 'auto' means
                        determined by '--clade' option. [auto]
  --clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}
                        which clade does your species belong to? [Arthropoda]
```


## mitoz_findmitoscaf

### Tool Description
Search for mitochondrial sequences from input fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mitoz findmitoscaf [-h] --fastafile <file> [--fq1 <file>]
                          [--fq2 <file>] --outprefix <STR> [--workdir <STR>]
                          [--thread_number <INT>] [--profiles_dir <STR>]
                          [--slow_search] [--filter_by_taxa] --requiring_taxa
                          <STR> [--requiring_relax {0,1,2,3,4,5,6}]
                          [--min_abundance <float>]
                          [--abundance_pattern <STR>] [--skip_read_mapping]
                          [--genetic_code <INT>]
                          [--clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}]

Search for mitochondrial sequences from input fasta file.

optional arguments:
  -h, --help            show this help message and exit
  --fastafile <file>    Input fasta file. Gzip supported. [required]
  --fq1 <file>          Input fastq 1 file. use this option if the headers of
                        your '--fastafile' does NOT have abundance information
                        BUT you WANT to filter sequence by their sequencing
                        abundances [optional]
  --fq2 <file>          Input fastq 2 file. use this option if the headers of
                        your '--fastafile' does NOT have abundance information
                        BUT you WANT to filter sequence by their sequencing
                        abundances [optional]
  --outprefix <STR>     output prefix
  --workdir <STR>       workdir [./]
  --thread_number <INT>
                        thread number [8]
  --profiles_dir <STR>  Directory cotaining 'CDS_HMM/', 'MT_database/' and
                        'rRNA_CM/'. [/usr/local/lib/python3.8/site-
                        packages/mitoz/profiles]
  --slow_search         By default, we firstly use tiara to perform quick
                        sequence classification (100 times faster than
                        usual!), however, it is valid only when your
                        mitochondrial sequences are >= 3000 bp. If you have
                        missing genes, set '--slow_search' to use the
                        tradicitiona search mode. [False]
  --filter_by_taxa      filter out non-requiring_taxa sequences by mito-PCGs
                        annotation to do taxa assignment.[True]
  --requiring_taxa <STR>
                        filtering out non-requiring taxa sequences which may
                        be contamination [required]
  --requiring_relax {0,1,2,3,4,5,6}
                        The relaxing threshold for filtering non-target-
                        requiring_taxa. The larger digital means more
                        relaxing. [0]
  --min_abundance <float>
                        the minimum abundance of sequence required. Set this
                        to any value <= 0 if you do NOT want to filter
                        sequences by abundance [10]
  --abundance_pattern <STR>
                        the regular expression pattern to capture the
                        abundance information in the header of sequence
                        ['abun\=([0-9]+\.*[0-9]*)']
  --skip_read_mapping   Skip read-mapping step, assuming we can extract the
                        abundance from seqid line. [False]
  --genetic_code <INT>  which genetic code table to use? 'auto' means
                        determined by '--clade' option. [auto]
  --clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}
                        which clade does your species belong to? [Arthropoda]
```


## mitoz_annotate

### Tool Description
Annotate PCGs, tRNA and rRNA genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mitoz annotate [-h] [--workdir <STR>] --outprefix <STR>
                      [--thread_number <INT>] --fastafiles <STR> [<STR> ...]
                      [--fq1 <file>] [--fq2 <file>] [--profiles_dir <STR>]
                      [--species_name <STR>] [--template_sbt <file>]
                      [--genetic_code <INT>]
                      [--clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}]

Annotate PCGs, tRNA and rRNA genes.

optional arguments:
  -h, --help            show this help message and exit
  --workdir <STR>       workdir [./]
  --outprefix <STR>     output prefix [required]
  --thread_number <INT>
                        thread number [8]
  --fastafiles <STR> [<STR> ...]
                        fasta file(s). The length of sequence id should be <=
                        13 characters, and each sequence should have
                        'topology=linear' or 'topology=circular' at the header
                        line, otherwise it is assumbed to be
                        'topology=linear'. For example, '>Contig1
                        topology=linear' [required]
  --fq1 <file>          Fastq1 file if you want to visualize the depth
                        distribution
  --fq2 <file>          Fastq2 file if you want to visualize the depth
                        distribution
  --profiles_dir <STR>  Directory cotaining 'CDS_HMM/', 'MT_database/' and
                        'rRNA_CM/'. [/usr/local/lib/python3.8/site-
                        packages/mitoz/profiles]
  --species_name <STR>  species name to use in output genbank file ['Test
                        sp.']
  --template_sbt <file>
                        The sqn template to generate the resulting genbank
                        file. Go to https://www.ncbi.nlm.nih.gov/genbank/tbl2a
                        sn2/#Template to generate your own template file if
                        you like. ['/usr/local/lib/python3.8/site-
                        packages/mitoz/annotate/script/template.sbt']
  --genetic_code <INT>  which genetic code table to use? 'auto' means
                        determined by '--clade' option. [auto]
  --clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}
                        which clade does your species belong to? [Arthropoda]
```


## mitoz_visualize

### Tool Description
Visualize input GenBank file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mitoz visualize [-h] [--circos <str>] --gb <file> [--gc {yes,no}]
                       [--win <str>] [--gc_fill <str>] [--depth_file <file>]
                       [--run_map {yes,no}] [--fq1 <file>] [--fq2 <file>]
                       [--bwa <str>] [--thread <int>] [--samtools <str>]
                       [--opts_samtools <str>] [--depth_fill <str>]
                       [--cds_color <str>] [--trna_color <str>]
                       [--rrna_color <str>] [--label_color <str>]
                       [--locus_color <str>] [--base {yes,no}] [--bgc <str>]
                       [--outdir <str>]

Visualize input GenBank file.

optional arguments:
  -h, --help            show this help message and exit
  --circos <str>        absolute path of circos executable. otherwise,
                        `circos` must be in your `PATH` variable [circos]
  --gb <file>           Your input Genbank file [required]

GC content track (the innermost one)
        In the resulting GC track (the innermost one), 
        the red line means 0.5, while each black lines mean 0.05. :
  --gc {yes,no}         whether draw GC content track. [no]
  --win <str>           windows size for calculating GC content [50]
  --gc_fill <str>       color for filling the GC track [128,177,211]

Abundance track (the middle one)
        This reveals the depth distribution, with dark green for the outline.
        If the depth lower than the minimum value (default 20), it turns red, 
        whereas if the depth larger than upper quartile,
        it turns dark green as same with the outline:
  --depth_file <file>   A file of tab-separated table with three columns:
                        reference name, position, and coverage depth, which is
                        generated by 'samtools depth' command. Or you can set
                        '--run_map yes' and '--fq1' and '--fq2' to get this
                        information
  --run_map {yes,no}    If you do NOT have the '--depth_file', setting '--
                        run_map yes' as well as '--fq1' and '--fq2' to map
                        reads to references to get the '--depth_file' [no]
  --fq1 <file>          fastq 1 file. Do NOT forget to set '--run_map yes'
  --fq2 <file>          fastq 2 file. Do NOT forget to set '--run_map yes'
  --bwa <str>           absolute path of bwa executable, otherwise, `bwa` must
                        be in your `PATH` variable [bwa]
  --thread <int>        BWA thread number [2]
  --samtools <str>      absolute path of samtools executable, otherwise,
                        `samtools` must be in your `PATH` variable [samtools]
  --opts_samtools <str>
                        optional arguments for samtools [-a -a]
  --depth_fill <str>    color for filling the abundance track [190,186,218]

Color setting (the outermost one):
  --cds_color <str>     PCG color [141,211,199]
  --trna_color <str>    tRNA color [251,128,114]
  --rrna_color <str>    rRNA color [253,192,134]
  --label_color <str>   gene name label color [black]
  --locus_color <str>   locus name's clolor showed on center of circle [black]

Base track:
  --base {yes,no}       whether draw base track [no]

Outfile setting:
  --bgc <str>           background color or the path to a user-defined image
                        file (as the background of the resulting file!)
                        [white]
  --outdir <str>        output directory [./outdir]
```


## mitoz_all

### Tool Description
Run all steps for mitochondrial genome anlysis from input fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mitoz all [-h] [--outprefix <str>] [--thread_number <int>]
                 [--workdir <directory>]
                 [--clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}]
                 [--genetic_code <INT>] [--species_name <STR>]
                 [--template_sbt <file>] --fq1 <file> [--fq2 <file>]
                 [--phred64] [--insert_size <INT>] [--fastq_read_length <INT>]
                 [--data_size_for_mt_assembly <float1>,<float2>]
                 [--skip_filter] [--filter_other_para <str>]
                 [--assembler {mitoassemble,spades,megahit}] [--tmp_dir <STR>]
                 [--kmers <INT> [<INT> ...]]
                 [--kmers_megahit <INT> [<INT> ...]]
                 [--kmers_spades <INT> [<INT> ...]] [--memory <INT>]
                 [--resume_assembly] [--profiles_dir <STR>] [--slow_search]
                 [--filter_by_taxa] --requiring_taxa <STR>
                 [--requiring_relax {0,1,2,3,4,5,6}] [--min_abundance <float>]

Run all steps for mitochondrial genome anlysis from input fastq files.

optional arguments:
  -h, --help            show this help message and exit

Common arguments:
  --outprefix <str>     output prefix [out]
  --thread_number <int>
                        thread number [8]
  --workdir <directory>
                        working directory [./]
  --clade {Chordata,Arthropoda,Echinodermata,Annelida-segmented-worms,Bryozoa,Mollusca,Nematoda,Nemertea-ribbon-worms,Porifera-sponges}
                        which clade does your species belong to? [Arthropoda]
  --genetic_code <INT>  which genetic code table to use? 'auto' means
                        determined by '--clade' option. [auto]
  --species_name <STR>  species name to use in output genbank file ['Test
                        sp.']
  --template_sbt <file>
                        The sqn template to generate the resulting genbank
                        file. Go to https://www.ncbi.nlm.nih.gov/genbank/tbl2a
                        sn2/#Template to generate your own template file if
                        you like. ['/usr/local/lib/python3.8/site-
                        packages/mitoz/annotate/script/template.sbt']

Input fastq information:
  --fq1 <file>          Fastq1 file [required]
  --fq2 <file>          Fastq2 file [optional]
  --phred64             Are the fastq phred64 encoded? [False]
  --insert_size <INT>   insert size of input fastq files [250]
  --fastq_read_length <INT>
                        read length of fastq reads, used by the filter
                        subcommand and mitoAssemble. [150]
  --data_size_for_mt_assembly <float1>,<float2>
                        Data size (Gbp) used for mitochondrial genome
                        assembly, usually between 2~8 Gbp is enough. The
                        float1 means the size (Gbp) of raw data to be
                        subsampled, while the float2 means the size of clean
                        data must be >= float2 Gbp, otherwise MitoZ will STOP
                        running! When only float1 is set, float2 is assumed to
                        be 0. (1) Set float1 to be 0 if you want to use ALL
                        raw data; (2) Set 0,0 if you want to use ALL raw data
                        and do NOT interrupt MitoZ even if you got very little
                        clean data. If you got missing mitochondrial genes,
                        try (1) differnt kmers; (2)different assembler; (3)
                        increase <float1>,<float2> [2,0]
  --skip_filter         Skip the rawdata filtering step, assuming input fastq
                        are clean data. To subsample such clean data, set
                        <float2> of the --data_size_for_mt_assembly option to
                        be larger than 0 (using all input clean data by
                        default). [False]
  --filter_other_para <str>
                        other parameter for filtering. []

Assembly arguments:
  --assembler {mitoassemble,spades,megahit}
                        Assembler to be used. [megahit]
  --tmp_dir <STR>       Set temp directory for megahit if necessary (See
                        https://github.com/linzhi2013/MitoZ/issues/176)
  --kmers <INT> [<INT> ...]
                        kmer size(s) to be used. Multiple kmers can be used,
                        separated by space [71]
  --kmers_megahit <INT> [<INT> ...]
                        kmer size(s) to be used. Multiple kmers can be used,
                        separated by space. Only for megahit [43 71 99]
  --kmers_spades <INT> [<INT> ...]
                        kmer size(s) to be used. Multiple kmers can be used,
                        separated by space. Only for spades ['auto']
  --memory <INT>        memory size limit for spades/megahit, no enough memory
                        will make the two programs halt or exit [50]
  --resume_assembly     to resume previous assembly running [False]

Search mitochondrial sequences arguments:
  --profiles_dir <STR>  Directory cotaining 'CDS_HMM/', 'MT_database/' and
                        'rRNA_CM/'. [/usr/local/lib/python3.8/site-
                        packages/mitoz/profiles]
  --slow_search         By default, we firstly use tiara to perform quick
                        sequence classification (100 times faster than
                        usual!), however, it is valid only when your
                        mitochondrial sequences are >= 3000 bp. If you have
                        missing genes, set '--slow_search' to use the
                        tradicitiona search mode. [False]
  --filter_by_taxa      filter out non-requiring_taxa sequences by mito-PCGs
                        annotation to do taxa assignment.[True]
  --requiring_taxa <STR>
                        filtering out non-requiring taxa sequences which may
                        be contamination [required]
  --requiring_relax {0,1,2,3,4,5,6}
                        The relaxing threshold for filtering non-target-
                        requiring_taxa. The larger digital means more
                        relaxing. [0]
  --min_abundance <float>
                        the minimum abundance of sequence required. Set this
                        to any value <= 0 if you do NOT want to filter
                        sequences by abundance [10]
```

## mitoz_tools_gbseqextractor

### Tool Description
Extracts CDS, rRNA, tRNA or whole sequences of genes from a GenBank file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools gbseqextractor: ok via mitoz-tools gbseqextractor --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: mitoz-tools gbseqextractor [-h] -f <STR> -prefix <STR>
                                  [-seqPrefix <STR>]
                                  [-types {CDS,rRNA,tRNA,wholeseq,gene} [{CDS,rRNA,tRNA,wholeseq,gene} ...]]
                                  [-cds_translation] [-gi] [-p] [-t] [-rv]
                                  [-s] [-l] [-F]

Extract any CDS or rNRA or tRNA DNA sequences of genes from Genbank file.

Seqid will be the value of '/gene=' or '/product=', if they both were not
present, the gene will not be output!

version 20201128:
    Now we can handle compounlocation (feature location with "join")!
    We can also output the translation for each CDS (retrived from '/translation=')

Please cite:
Guanliang Meng, Yiyuan Li, Chentao Yang, Shanlin Liu,
MitoZ: a toolkit for animal mitochondrial genome assembly, annotation
and visualization, Nucleic Acids Research, https://doi.org/10.1093/nar/gkz173

optional arguments:
  -h, --help            show this help message and exit
  -f <STR>              Genbank file
  -prefix <STR>         prefix of output file. required.
  -seqPrefix <STR>      prefix of each seq id. default: None
  -types {CDS,rRNA,tRNA,wholeseq,gene} [{CDS,rRNA,tRNA,wholeseq,gene} ...]
                        what kind of genes you want to extract? wholeseq for
                        whole fasta seq. WARNING: Each sequence in the result
                        files corresponds to ONE feature in the GenBank file,
                        I will NOT combine multiple CDS of the same gene into
                        ONE! [CDS]
  -cds_translation      Also output translated CDS (required -types CDS). The
                        translations are retrived directly from the
                        '/translation=' key word. [False]
  -gi                   use gi number as sequence ID instead of accession
                        number when " gi number is present. (default:
                        accession number)
  -p                    output the position information on the ID line.
                        Warning: the position on ID line is 0 left-most!
                        [False]
  -t                    output the taxonomy lineage on ID line [False]
  -rv                   reverse and complement the output sequences if they
                        are on the 3'-5' direction [True]
  -s                    output the species name on the ID line [False]
  -l                    output the seq length on the ID line [False]
  -F                    only output full length genes,i.e., exclude the genes
                        with '>' or '<' in their location [False]
```

## mitoz_tools_gbfiletool_cut

### Tool Description
Cuts GenBank records to chosen regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools gbfiletool cut: ok via mitoz-tools gbfiletool cut --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: mitoz-tools gbfiletool cut [-h] -i <STR> -o <STR> -k <seqid:start:stop>
                                  [<seqid:start:stop> ...]

optional arguments:
  -h, --help            show this help message and exit
  -k <seqid:start:stop> [<seqid:start:stop> ...]
                        sequence regions to output. subrecord [start, stop]
                        will be output. if seqid:start, sites from start to
                        the end of rec will be output; Other seq records will
                        be omited (not output). position is 1-left

input/output arguments:
  -i <STR>              genbank input file
  -o <STR>              genbank out file
```

## mitoz_tools_gbfiletool_comrev

### Tool Description
Gets the complement reverse of GenBank records.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools gbfiletool comrev: ok via mitoz-tools gbfiletool comrev --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: mitoz-tools gbfiletool comrev [-h] -i <STR> -o <STR>

optional arguments:
  -h, --help  show this help message and exit

input/output arguments:
  -i <STR>    genbank input file
  -o <STR>    genbank out file
```

## mitoz_tools_gbfiletool_sort

### Tool Description
Sorts the gene order of circular GenBank records so a chosen gene comes first.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools gbfiletool sort: ok via mitoz-tools gbfiletool sort --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: mitoz-tools gbfiletool sort [-h] -i <STR> -o <STR> -g <STR>

optional arguments:
  -h, --help  show this help message and exit
  -g <STR>    the first gene in output

input/output arguments:
  -i <STR>    genbank input file
  -o <STR>    genbank out file
```

## mitoz_tools_gbfiletool_select

### Tool Description
Outputs specific GenBank records.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools gbfiletool select: ok via mitoz-tools gbfiletool select --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: mitoz-tools gbfiletool select [-h] -i <STR> -o <STR> -k <recid>
                                     [<recid> ...]

optional arguments:
  -h, --help            show this help message and exit
  -k <recid> [<recid> ...]
                        ids of record to be output.

input/output arguments:
  -i <STR>              genbank input file
  -o <STR>              genbank out file
```

## mitoz_tools_circle_check

### Tool Description
Checks whether sequences of at least 12 Kbp are circular.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools circle_check: ok via mitoz-tools circle_check --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: mitoz-tools circle_check [-h] [-i <file>] -o <file> [-m <int>]

Check whether the sequences are circular when the sequences have length >= 12Kbp

output files:

1. <outPrefix>.mitogenome.fa
All the sequences from <in.fasta>.

The sequence id line will be like:
>C1 topology=circular
>C2 topology=linear

For the circular mt sequence, the overlapping region (the second `ATGCNN`
below) has been removed (below is an example)

ATGCNNNNN[ATGCNN]

Assuming `ATGCNNNNN` is a circular mt sequence, `ATGCNN` are the overlapping
regions.

2. <outPrefix>.start2end_for-circular-mt-only
This file contains the circular sequences only, and the first 300 bp of each
has been moved to the end of the sequence, just for better reads mapping. You
can check the sequencing depth around the 'joining site' (-300 bp) using the
`annotate` module of MitoZ, to confirm if the sequence is really circular.

3. <outPrefix>.overlap_information
The overlapping sequence detected for the circular sequences.

Author
    mengguanliang@genomics.cn, BGI.

Please cite:
Guanliang Meng, Yiyuan Li, Chentao Yang, Shanlin Liu,
MitoZ: a toolkit for animal mitochondrial genome assembly, annotation
and visualization, Nucleic Acids Research, https://doi.org/10.1093/nar/gkz173

optional arguments:
  -h, --help  show this help message and exit
  -i <file>   input fasta file
  -o <file>   output prefix
  -m <int>    mismatch allowed in the overlapping region [3]
```

## mitoz_tools_msaconverter

### Tool Description
Converts multiple sequence alignments between formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools msaconverter: ok via mitoz-tools msaconverter --help (--help=ok, -h=ok, -help=ok, (no args)=crash)
usage: mitoz-tools msaconverter [-h] [-i <INFILE>] [-o <OUTFILE>]
                                [-p {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,mauve,maf}]
                                [-q {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,mauve,maf}]
                                [-t {DNA,RNA,protein}]

Convert multiple-sequence-alignment into different formats. 
See https://biopython.org/wiki/AlignIO for format introductions. 
By Guanliang MENG.

optional arguments:
  -h, --help            show this help message and exit
  -i <INFILE>           input msa file
  -o <OUTFILE>          output msa file
  -p {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,mauve,maf}
                        input msa format [fasta]
  -q {fasta,clustal,stockholm,nexus,phylip,phylip-sequential,phylip-relaxed,mauve,maf}
                        input msa format [phylip-relaxed]
  -t {DNA,RNA,protein}  Molecule types [DNA]
```

## mitoz_tools_taxonomy_ranks

### Tool Description
Gets lineage information of taxids, species names or higher ranks with ETE3.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools taxonomy_ranks: ok via mitoz-tools taxonomy_ranks --help (--help=ok, -h=ok, -help=usage_only, (no args)=usage_only)
usage: mitoz-tools taxonomy_ranks [-h] -i <file> -o <file> [-t] [-e] [-v]

To get the lineage information of input taxid, species name, or higher ranks
(e.g., Family, Order) with ETE3 package.

The ete3 package will automatically download the NCBI Taxonomy database during
 the first time using of this program.

Please be informed:

(1) A rank name may have more than one taxids, e.g., Pieris can means:
Pieris <butterfly> and Pieris <angiosperm>. I will search the lineages for
both of them.

(2) When you give a species name, if I can not find the taxid for the species
name, I will try to search the first word (Genus).

(3) Any input without result found will be output in outfile.err ('-o' option).

optional arguments:
  -h, --help  show this help message and exit
  -i <file>   A file can be a list of ncbi taxa id or species names (or higher
              ranks, e.g. Family, Order), or a mixture of them.
  -o <file>   outfile
  -t          Also print out the taxid for each rank
  -e          Also print out the records without lineage information found to
              the '-o <file>'
  -v          verbose output
```

## mitoz_tools_bold_identification

### Tool Description
Identifies taxa of sequences from the BOLD database.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools bold_identification: ok via mitoz-tools bold_identification --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: mitoz-tools bold_identification [-h] -i <str> [-f <str>] -o <str>
                                       [-d {COX1,COX1_SPECIES,COX1_SPECIES_PUBLIC,COX1_L640bp,ITS,MATK_RBCL}]
                                       [-n <int>] [-r <int>] [-c] [-C]
                                       [-q <int>] [-D] [--version]

To identify taxa of given sequences from BOLD (http://www.boldsystems.org/).

Some sequences can fail to get taxon information, which can be caused by
TimeoutException if your network to the BOLD server is bad.
Those sequences will be output in the file '*.TimeoutException.fasta'.

You can:
1) run another searching with the same command directly (but add -c option);
2) lengthen the time to wait for each query (-t option);
3) increase submission times (-r option) for a sequence.

Also, the sequences without BOLD matches will be output in the
file '*.NoBoldMatchError.fasta'

By Guanliang Meng.
See https://github.com/linzhi2013/bold_identification.

Citation:
Yang C, Zheng Y, Tan S, Meng G, et al.
Efficient COI barcoding using high throughput single-end 400 bp sequencing.
https://doi.org/10.1186/s12864-020-07255-w

optional arguments:
  -h, --help            show this help message and exit
  -i <str>              input file name
  -f <str>              input file format [fasta]
  -o <str>              outfile prefix
  -d {COX1,COX1_SPECIES,COX1_SPECIES_PUBLIC,COX1_L640bp,ITS,MATK_RBCL}
                        database to search [COX1]
  -n <int>              how many first top hits will be output. [1]
  -r <int>              Maximum submission time for a sequence, useful for
                        handling TimeOutException. [4]
  -c                    continuous mode, jump over the ones already in "-o"
                        file, will resubmit all the remained. use "-cc" to
                        also jump over the ones in "*.NoBoldMatchError.fasta"
                        file.
  -C                    For chimera check purpose. If set, for each sequence,
                        I will query the BOLD database using the subsequences
                        from 5'- and 3'-ends with a length of '-q <int>' bp,
                        respectively
  -q <int>              The length of subsequences for chimera check [400]
  -D                    debug mode output [False]
  --version             show program's version number and exit
```

## mitoz_tools_group_seq_by_gene

### Tool Description
Groups the gene sequences of different samples into files by gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
- **Homepage**: https://github.com/linzhi2013/MitoZ
- **Package**: https://anaconda.org/channels/bioconda/packages/mitoz/overview
- **Validation**: PASS

### Original Help Text
```text
[help] mitoz-tools group_seq_by_gene: ok via mitoz-tools group_seq_by_gene --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=crash)
usage: mitoz-tools group_seq_by_gene [-h] [-r <file>] [-d <str>] [-p <str>]
                                     [-clean_header]

To group the gene sequences of different samples into different files by genes.

Please cite:
Guanliang Meng, Yiyuan Li, Chentao Yang, Shanlin Liu,
MitoZ: a toolkit for animal mitochondrial genome assembly, annotation
and visualization, Nucleic Acids Research, https://doi.org/10.1093/nar/gkz173

optional arguments:
  -h, --help     show this help message and exit
  -r <file>      the gene file list. Per-line format: Abbreviation
                 geneFilePath. The abbreviation will be added to the seqid to
                 indicate different samples.
  -d <str>       the delimiter between the abbreviation and the seqid [;]
  -p <str>       the prefix of all result files [MitoZ]
  -clean_header  Only shows the 'Abbreviation' in the sequence header [False]
```

## Metadata
- **Skill**: generated
