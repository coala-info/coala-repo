# motifscan CWL Generation Report

## motifscan_config

### Tool Description
Configure data paths for MotifScan.

### Metadata
- **Docker Image**: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
- **Homepage**: https://github.com/shao-lab/MotifScan
- **Package**: https://anaconda.org/channels/bioconda/packages/motifscan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/motifscan/overview
- **Total Downloads**: 31.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shao-lab/MotifScan
- **Stars**: N/A
### Original Help Text
```text
usage: motifscan config [-h] [--show] [--set-default-genome PATH]
                        [--set-default-motif PATH] [--get-genome NAME]
                        [--set-genome NAME PATH] [--rm-genome NAME]
                        [--get-motif NAME] [--set-motif NAME PATH]
                        [--rm-motif NAME] [--verbose]

Configure data paths for MotifScan.

Commands listed below enable users to change the default installation
location of genome/motif data files and check the paths of installed 
genome assemblies or motif sets.

The user specific config file is located at: /root/.motifscanrc

options:
  -h, --help            show this help message and exit
  --verbose             Enable verbose log messages.

Basic Options:
  --show                Show all configured values.

Default Install Location:
  --set-default-genome PATH
                        Set the default installation path for genome
                        assemblies.
  --set-default-motif PATH
                        Set the default installation path for motif sets.

Genome Path Options:
  --get-genome NAME     Get the genome path of a specific genome assembly.
  --set-genome NAME PATH
                        Set the genome path for a specific genome assembly.
  --rm-genome NAME      Remove a specific genome assembly.

Motif Path Options:
  --get-motif NAME      Get the motif path of a specific motif set.
  --set-motif NAME PATH
                        Set the motif path for a specific motif set.
  --rm-motif NAME       Remove a specific motif set.

Examples:
---------    
1) Display all values set in the config file:

    motifscan config --show

2) Change the default installation location for genome assemblies:

    motifscan config --set-default-genome <path>

3) Change the default installation location for motif sets:

    motifscan config --set-default-motif <path>     

4) Get the genome path of a specific genome assembly:

    motifscan config --get-genome <genome_name>

5) Change the motif path for a specific motif set:

    motifscan config --set-motif <motif_set> <path>
```


## motifscan_genome

### Tool Description
Genome assembly commands.
This subcommand controls the genome assemblies used by MotifScan. MotifScan requires a sequences FASTA file and a gene annotation file (if available) for each genome assembly, users can either download them from a remote database or install directly with local prepared files.

### Metadata
- **Docker Image**: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
- **Homepage**: https://github.com/shao-lab/MotifScan
- **Package**: https://anaconda.org/channels/bioconda/packages/motifscan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: motifscan genome [-h]
                        (--list | --list-remote | --search KEYWORD | --install | --uninstall NAME)
                        [-n NAME] [-i FASTA [FASTA ...]] [-a ANNOTATION]
                        [-r GENOME] [-o DIR] [--database {ucsc}] [--clean]
                        [--verbose]

Genome assembly commands.

This subcommand controls the genome assemblies used by MotifScan.
MotifScan requires a sequences FASTA file and a gene annotation file 
(if available) for each genome assembly, users can either download them 
from a remote database or install directly with local prepared files.

options:
  -h, --help            show this help message and exit
  --verbose             Enable verbose log messages.

Genome Subcommands:
  --list                Display installed genome assemblies.
  --list-remote         Display available remote genome assemblies.
  --search KEYWORD      Search for genome assemblies in a remote database.
  --install             Install a new genome assembly.
  --uninstall NAME      Uninstall a genome assembly.

Install Options:
  -n NAME, --name NAME  Name of the genome assembly to be installed.
  -i FASTA [FASTA ...]  Local genome sequences file(s) in FASTA format.
  -a ANNOTATION         Local gene annotation (refGene.txt) file.
  -r GENOME, --remote GENOME
                        Download required data files from a remote assembly.
  -o DIR, --output-dir DIR
                        Write to a given directory instead of the default
                        directory.

Remote Database Options:
  --database {ucsc}     Which remote database is used to list/install/search
                        genome assemblies. Default: ucsc
  --clean               Clean the download directory after installation.

Examples:
--------- 
1) Display installed genomes:

    motifscan genome --list

2) Display all available genomes in a remote database:

    motifscan genome --list-remote

3) Search genomes in a remote database by keyword (e.g. 'human'):

    motifscan genome --search human

4) Install 'hg19' genome assembly from a remote database:

    motifscan genome --install -n hg19 -r hg19

5) Install 'hg19' genome assembly with local prepared files:

    motifscan genome --install -n hg19 -i <hg19.fa> -a <refGene.txt>   

6) Uninstall a genome assembly:

    motifscan genome --uninstall <genome_name>

Notes:
------       
The path of newly installed genome will be automatically saved. If you 
move the directory to another location later, please reconfigure it:

    motifscan config --set-genome <genome_name> <new_path>
```


## motifscan_motif

### Tool Description
Motif set (PFMs/PWMs) commands.

MotifScan only detects the binding sites of known motifs. Before scanning, 
the motif set should be installed and built with PFMs (Position Frequency 
Matrices). Since different assemblies have different genome contents, it 
is necessary to build the PFMs and get proper motif score cutoffs for every 
genome assembly you want to scan later.

### Metadata
- **Docker Image**: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
- **Homepage**: https://github.com/shao-lab/MotifScan
- **Package**: https://anaconda.org/channels/bioconda/packages/motifscan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: motifscan motif [-h]
                       (--list | --list-remote | --install | --build NAME | --uninstall NAME)
                       [-n NAME] [-i FILE [FILE ...]] [-r PFMs] [-o DIR]
                       [--database {jaspar_core,jaspar_collections}]
                       [-g GENOME] [--n-random N] [--n-repeat N] [--max-n N]
                       [--seed SEED] [-t N] [--verbose]

Motif set (PFMs/PWMs) commands.

MotifScan only detects the binding sites of known motifs. Before scanning, 
the motif set should be installed and built with PFMs (Position Frequency 
Matrices). Since different assemblies have different genome contents, it 
is necessary to build the PFMs and get proper motif score cutoffs for every 
genome assembly you want to scan later. 

options:
  -h, --help            show this help message and exit
  --verbose             Enable verbose log messages.

Motif Subcommands:
  --list                Display installed motif sets.
  --list-remote         Display available remote motif sets.
  --install             Install a new motif set with PFMs.
  --build NAME          Build an installed motif set for additional genome
                        assembly.
  --uninstall NAME      Uninstall a motif set.

Install Options:
  -n NAME, --name NAME  Name of the motif set (PFMs) to be installed.
  -i FILE [FILE ...]    Local motif PFMs file(s) to be installed.
  -r PFMs, --remote PFMs
                        Download a remote motif PFMs set.
  -o DIR, --output-dir DIR
                        Write to a given directory instead of the default
                        directory.

Remote Database Options:
  --database {jaspar_core,jaspar_collections}
                        Which remote database is used to list/install motif
                        set (PFMs). Default: jaspar_core

Build Options:
  -g GENOME, --genome GENOME
                        Genome assembly to build the motif set (PFMs) for.
  --n-random N          Generate N random background sequences to calculate
                        motif score cutoffs. Default: 1,000,000
  --n-repeat N          Repeat N rounds of random sampling and use the
                        averaged cutoff as final cutoff. Default: 1
  --max-n N             The maximal number of `N` base allowed in each random
                        sampled sequence. Default: 0
  --seed SEED           Random seed used to generate background sequences.

Threads Options:
  -t N, --threads N     Number of processes used to run in parallel.

Examples:
---------        
1) Display installed motif sets:

    motifscan motif --list

2) Display all available motif sets in a remote database:

    motifscan motif --list-remote

3) Install a motif set from a remote database and build for genome 'hg19':

    motifscan motif --install -n <motif_set> -r <remote_PFMs> -g hg19

4） Install a motif set with local PFMs file(s) and build for genome 'mm9':

    motifscan motif --install -n <motif_set> -i <pfms.jaspar> -g mm9

5) Build an installed motif set (PFMs) for additional assembly 'hg38':

    motifscan motif --build <motif_set> -g hg38

6) Uninstall a motif set:

    motifscan motif --uninstall <motif_set>

Notes:
------
1) When installing a motif set by `--install`, you can append a `-g` option 
to build the PFMs for the specified assembly after installation.

2) The genome assembly specified by `-g` should be pre-installed by command 
`motifscan genome --install`.

3) The path of newly installed motif set will be automatically saved and 
all the built PWMs files are stored under the directory. If you move it 
to a new path, please reconfigure it:

    motifscan config --set-motif <motif_set> <new_path>
```


## motifscan_scan

### Tool Description
Scan input regions to detect motif occurrences.

This main command invokes to scan the sequences of user specified input 
genomic regions and detect the occurrences for a set of known motifs. 
After scanning the input regions, an optional motif enrichment analysis 
is performed to check whether these motifs are over/under-represented 
compared to control regions (can be random generated or user specified).

### Metadata
- **Docker Image**: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
- **Homepage**: https://github.com/shao-lab/MotifScan
- **Package**: https://anaconda.org/channels/bioconda/packages/motifscan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: motifscan scan [-h] -i FILE
                      [-f {bed,bed3-summit,macs,macs2,narrowpeak,broadpeak,manorm}]
                      -m NAME -g GENOME [-p {1e-2,1e-3,1e-4,1e-5,1e-6}]
                      [--loc {promoter,distal}] [--upstream DISTANCE]
                      [--downstream DISTANCE] [-w LENGTH]
                      [--strand {both,+,-}] [--no-enrich] [--n-random N]
                      [--seed SEED] [-c FILE]
                      [--cf {bed,bed3-summit,macs,macs2,narrowpeak,broadpeak,manorm}]
                      [-t N] -o DIR [--site] [--plot] [--verbose]

Scan input regions to detect motif occurrences.

This main command invokes to scan the sequences of user specified input 
genomic regions and detect the occurrences for a set of known motifs. 
After scanning the input regions, an optional motif enrichment analysis 
is performed to check whether these motifs are over/under-represented 
compared to control regions (can be random generated or user specified).

options:
  -h, --help            show this help message and exit
  --verbose             Enable verbose log messages.

Input Options:
  -i FILE               Input genomic regions (peaks) to be scanned.
  -f {bed,bed3-summit,macs,macs2,narrowpeak,broadpeak,manorm}
                        Format of the input file. Default: bed
  -m NAME, --motif NAME
                        Motif set name to scan for.
  -g GENOME, --genome GENOME
                        Genome assembly name.

Scanning Options:
  -p {1e-2,1e-3,1e-4,1e-5,1e-6}
                        P value cutoff for motif scores. Default: 1e-4
  --loc {promoter,distal}
                        If specified, only scan promoter or distal regions.
  --upstream DISTANCE   TSS upstream distance for promoters. Default: 4000
  --downstream DISTANCE
                        TSS downstream distance for promoters. Default: 2000
  -w LENGTH, --window-size LENGTH
                        Window size for scanning. In most cases, motifs occur
                        closely around the centers or summits of genomic
                        peaks. Scanning a fixed-size window is often
                        sufficient to detect motif sites and unbiased for the
                        enrichment analysis. If set to 0, the whole input
                        regions are included for scanning. Default: 1000
  --strand {both,+,-}   Enable strand-specific scanning, defaults to scan both
                        strands.

Enrichment Analysis Options:
  --no-enrich           Disable the enrichment analysis.
  --n-random N          Generate N random control regions for each input
                        region. Default: 5
  --seed SEED           Random seed used to generate control regions.
  -c FILE               Use custom control regions for the enrichment
                        analysis.
  --cf {bed,bed3-summit,macs,macs2,narrowpeak,broadpeak,manorm}
                        Format of the control file. Default: bed

Threads Options:
  -t N, --threads N     Number of processes used to run in parallel.

Output Options:
  -o DIR, --output-dir DIR
                        Directory to write output files.
  --site                If set, report the position for each detected motif
                        site.
  --plot                If set, plot the distributions of detected motif
                        sites.

Examples:
---------
1) Scan input regions for a set of known motifs under 'hg19' genome:

    motifscan scan -i regions.bed -m <motif_set> -g hg19 -o <path>

2) Test motif enrichment compared to user-specified control regions:

    motifscan scan -i regions.bed -c control.bed -m <motif_set> -g hg19 -o <path>

3) Only scan input regions located at promoters:

    motifscan scan -i regions.bed -m <motif_set> -g hg19 --loc promoter -o <path>

4) Scan whole input regions rather than fixed-size windows:

    motifscan scan -i regions.bed -m <motif_set> -g hg19 -w 0 -o <path>

5) Report the positions and distributions of detected motif sites:

    motifscan scan -i regions.bed -m <motif_set> -g hg19 --site --plot -o <path>
```

