# mitoz CWL Generation Report

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


## Metadata
- **Skill**: generated
