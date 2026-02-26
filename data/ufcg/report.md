# ufcg CWL Generation Report

## ufcg_profile

### Tool Description
Extract UFCG profile from Fungal whole genome sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/steineggerlab/ufcg
- **Stars**: N/A
### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - profile[0m
[32m Extract UFCG profile from Fungal whole genome sequences[0m

[33;1m
 INTERACTIVE MODE :[0m ufcg profile -u
[33;1m ONE-LINER MODE   :[0m ufcg profile -i <INPUT> -o <OUTPUT> [...]

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -i STR         Input directory containing fungal genome assemblies[0m
[0m -o STR         Output directory to store the result files[0m

[33m
 Runtime configurations[0m
[36m Argument       Description[0m
[0m -s STR         Set of markers to extract - see advanced options for details [PRO][0m
[0m -w STR         Directory to write the temporary files [/tmp][0m
[0m -t INT         Number of CPU threads to use [1][0m
[0m -m STR         File to the list containing metadata[0m
[0m -k             Keep the temporary products [0][0m
[0m -f             Force to overwrite the existing files [0][0m
[0m -n             Exclude introns and store cDNA sequences [0][0m
[0m -q             Quiet mode - report results only [0][0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)

 To see the advanced options, run with "profile -hh".
```


## ufcg_profile-rna

### Tool Description
Extract UFCG profile from Fungal RNA-seq reads

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - profile-rna[0m
[32m Extract UFCG profile from Fungal RNA-seq reads[0m

[33;1m
 USAGE :[0m ufcg profile-rna -p <PAIRED> -i <INPUT> -o <OUTPUT> [...]
[33;1m        [0m ufcg profile-rna -p 1 -l <LEFT> -r <RIGHT> -o <OUTPUT> [...]

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -p INT         Paired or unpaired reads (paired: 1; unpaired: 0)[0m
[0m -i STR *       File containing single reads in FASTQ/FASTA format[0m
[0m -l, -r STR *   File containing left/right reads in FASTQ/FASTA format[0m
[0m -o STR         Output directory[0m
[0m * Select one of above[0m

[33m
 Configurations[0m
[36m Argument       Description[0m
[0m -s STR         Set of markers to extract - see advanced options for details [PRO][0m
[0m -w STR         Directory to write the temporary files [/tmp][0m
[0m -t INT         Number of CPU threads to use [1][0m
[0m -k             Keep the temporary products [0][0m
[0m -f             Force to overwrite the existing files [0][0m
[0m -n             Exclude introns and store cDNA sequences [0][0m
[0m -q             Quiet mode - report results only [0][0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)

[33m
 Notes[0m
 * Currently, profile-rna module is only capable of extracting protein markers. (-s PRO)
 * To see the advanced options, run with "profile-rna -hh".
```


## ufcg_profile-pro

### Tool Description
Extract UFCG profile from Fungal proteome

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - profile-pro[0m
[32m Extract UFCG profile from Fungal proteome[0m

[33;1m
 USAGE :[0m ufcg profile-pro -i <INPUT> -o <OUTPUT> [...]

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -i STR         File containing fungal protein sequences[0m
[0m -o STR         Output directory[0m

[33m
 Runtime configurations[0m
[36m Argument       Description[0m
[0m -w STR         Directory to write the temporary files [/tmp][0m
[0m -t INT         Number of CPU threads to use [1][0m
[0m -k             Keep the temporary products [0][0m
[0m -f             Force to overwrite the existing files [0][0m

[33m
 Advanced options[0m
[36m Argument          Description[0m
[0m --info STR        Comma-separated metadata string (Filename*, Label*, Accession*, Taxon, NCBI, Strain, Taxonomy)[0m
[0m --mmseqs STR      Path to MMseqs2 binary [mmseqs][0m
[0m --seqpath STR     Path to the directory containing gene sequences [./config/seq][0m
[0m --evalue FLOAT    E-value cutoff for validation [1e-3][0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)

[33m
 Notes[0m
 * Currently, profile-pro module is only capable of extracting UFCG markers. (-s PRO)
```


## ufcg_convert

### Tool Description
Convert core gene profile into a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - convert[0m
[32m Convert core gene profile into a FASTA file[0m

[33;1m
 USAGE :[0m ufcg convert -i <PROFILE> -o <FASTA> [...]

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -i STR         Input core gene profile (.ucg)[0m
[0m -o STR         Output FASTA file[0m
[0m -t STR         Sequence type [nuc, pro][0m

[33m
 Configurations[0m
[36m Argument       Description[0m
[0m -l STR         FASTA header format, comma-separated string containing one or more of the following keywords: [acc][0m
[0m                [uid, acc, label, taxon, strain, type, taxonomy] [0m
[0m -f             Force to overwrite the existing files [0][0m
[0m -c             Include multiple copied genes (tag with numerical suffix) [0][0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)
```


## ufcg_train

### Tool Description
Train and generate sequence model of fungal markers

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - train[0m
[32m Train and generate sequence model of fungal markers[0m

[33;1m
 USAGE :[0m ufcg train -i <MARKER> -g <GENOME> -o <OUTPUT> -s <TYPE> [...]

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -i STR         Directory containing marker sequences in FASTA format (should be able to build an MSA)[0m
[0m -g STR         Directory containing reference genome sequences in FASTA format[0m
[0m -o STR         Output directory[0m

[33m
 Configurations[0m
[36m Argument       Description[0m
[0m -n INT         Number of training iteration; 0 to iterate until convergence [0][0m
[0m -t INT         Number of CPU threads to use [1][0m
[0m -w STR         Directory to write temporary files [/tmp][0m
[0m -c STR         Checkpoint directory that contains precomputed files[0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)

[33m
 Following binaries should be on the environment PATH: [0m
[36m Binary               Required by[0m
[0m fastBlockSearch      profile[0m
[0m augustus             profile[0m
[0m mmseqs               profile[0m
[0m mafft                align[0m
[0m prepareAlign         train[0m
[0m msa2prfl.pl          train[0m
```


## ufcg_align

### Tool Description
Align genes and provide multiple sequence alignments from UFCG profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - align[0m
[32m Align genes and provide multiple sequence alignments from UFCG profiles[0m

[33;1m
 USAGE:[0m ufcg align -i <INPUT> -o <OUTPUT> [...]

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -i STR         Input directory containing UFCG profiles[0m
[0m -o STR         Output directory for alignments[0m

[33m
 Additional options[0m
[36m Argument       Description[0m
[0m -l STR         Label format, comma-separated string containing one or more of the following keywords:[0m
[0m                {uid, acc, label, taxon, strain, type, taxonomy} [label][0m
[0m -n STR         Name of this run [align][0m
[0m -a STR         Alignment method {nucleotide, codon, codon12, protein} [protein][0m
[0m -t INT         Number of CPU threads to use [1][0m
[0m -f INT         Gap-rich filter percentage threshold {0 - 100} [50][0m
[0m -c             Align multiple copied genes [0][0m
[0m -k             Continue from the checkpoint [0][0m
[0m -m STR         Path to MAFFT binary [mafft-linsi][0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)
```


## ufcg_tree

### Tool Description
Reconstruct the phylogenetic relationship with UFCG profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - tree[0m
[32m Reconstruct the phylogenetic relationship with UFCG profiles[0m

[33;1m
 USAGE:[0m ufcg tree -i <INPUT> -o <OUTPUT> [...]

[33;1m
 Required options[0m
[36m Argument        Description[0m
[0m -i STR          Input directory containing UFCG profiles [0m
[0m -o STR          Output directory[0m

[33m
 Additional options[0m
[36m Argument        Description[0m
[0m -l STR          Tree leaf format, comma-separated string containing one or more of the following keywords: [label][0m
[0m                 {uid, acc, label, taxon, strain, type, taxonomy}[0m
[0m -n STR          Name of this run [tree] [0m
[0m -a STR          Alignment method {nucleotide, codon, codon12, protein} [protein][0m
[0m -t INT          Number of CPU threads to use [1][0m
[0m -p STR          Tree building program {raxml, iqtree, fasttree} [iqtree] [0m
[0m -c              Align multiple copied genes [0][0m
[0m -k              Continue from the checkpoint [0][0m

[33m
 Dependencies[0m
[36m Argument        Description[0m
[0m --mafft STR     Path to MAFFT binary [mafft-linsi][0m
[0m --iqtree STR    Path to IQ-TREE binary [iqtree][0m
[0m --raxml STR     Path to RAxML binary [raxmlHPC-PTHREADS][0m
[0m --fasttree STR  Path to FastTree binary [FastTree][0m

[33m
 Advanced options[0m
[36m Argument        Description[0m
[0m -f INT          Gap-rich filter percentage threshold {0 - 100} [50] [0m
[0m -m STR          ML tree inference model [JTT+ (proteins); GTR+ (nucleotides)] [0m
[0m -g INT          GSI value threshold {1 - 100} [95] [0m
[0m -x INT          Maximum number of gene tree executors; lower this if the RAM usage is excessive {1 - threads} [equal to -t][0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)
```


## ufcg_prune

### Tool Description
Fix UFCG tree labels or get a single gene tree

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - prune[0m
[32m Fix UFCG tree labels or get a single gene tree[0m

[33;1m
 USAGE:[0m ufcg prune -i <INPUT> -g <GENE> -l <LABEL>

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -i STR         Input .trm file provided by tree module [0m
[0m -g STR         Gene name - "UFCG" for a UFCG tree, proper gene name for a single gene tree [0m
[0m -l STR         Tree label format, comma-separated string containing one or more of the following keywords: [0m
[0m                [uid, acc, label, taxon, strain, type, taxonomy] [0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)
```


## ufcg_download

### Tool Description
List or download resources

### Metadata
- **Docker Image**: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
- **Homepage**: https://ufcg.steineggerlab.com
- **Package**: https://anaconda.org/channels/bioconda/packages/ufcg/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m    __  __ _____ _____ _____[0m
[32;1m   / / / // ___// ___// ___/[0m
[32;1m  / / / // /_  / /   / / __[0m
[32;1m / /_/ // __/ / /___/ /_/ /[0m
[32;1m \____//_/    \____/\____/[0m[32m v1.0.6[0m


[32;1m UFCG - download[0m
[32m List or download resources[0m

[33;1m
 USAGE :[0m ufcg download -t <TARGET> [...]

[33;1m
 Required options[0m
[36m Argument       Description[0m
[0m -t [0m[0mfull        [0m[0mFull download[0m
[0m    minimum     [0m[0mMinimum download (config, core)[0m
[0m    config      [0m[0mDownload config files[0m
[0m    core        [0m[0mDownload core gene database[0m
[0m    busco       [0m[0mDownload BUSCO odb_fungi_v10 database[0m
[0m    sample      [0m[0mDownload sample files[0m

[33m
 Configurations[0m
[36m Argument       Description[0m
[0m -d STR         Download directory [auto][0m
[0m -c             Check download status[0m

[33m
 General options
[0m[36m Argument       Description
[0m -h, --help     Print this manual
 -v, --verbose  Make program verbose
 --nocolor      Remove ANSI escapes from standard output
 --notime       Remove timestamp in front of the prompt string
 --developer    Activate developer mode (For testing or debugging)
```

