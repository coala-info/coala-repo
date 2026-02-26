# phabox CWL Generation Report

## phabox_phabox2

### Tool Description
PhaBOX v2.1.13

### Metadata
- **Docker Image**: quay.io/biocontainers/phabox:2.1.13--pyhdfd78af_1
- **Homepage**: https://github.com/KennthShang/PhaBOX
- **Package**: https://anaconda.org/channels/bioconda/packages/phabox/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phabox/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/KennthShang/PhaBOX
- **Stars**: N/A
### Original Help Text
```text
[1m[96mPhaBOX v2.1.13[0m[0m                  
               [1m[96mJiayu SHANG, Cheng Peng, and Yanni SUN Sep. 2025[0m[0m 


[1mDocumentation, support and updates available at https://github.com/KennthShang/PhaBOX/wiki [0m


Syntax: phabox2 [--help] [--task TASK] [--dbdir DBDIR] [--outpth OUTPTH] 
                    [--contigs CONTIGS] [--proteins PROTEINS]
                    [--midfolder MIDFOLDER] [--threads THREADS]
                    [--len LEN] [--reject REJECT] [--aai AAI] [--skip N/Y]
                    [--share SHARE] [--pcov PCOV]
                    [--pident PIDENT] [--cov COV] 
                    [--blast BLAST] [--sensitive SENSITIVE] 
                    [--draw DRAW] [--marker MARKER [MARKER ...]]
                    [--tree TREE] [--bfolder BFOLDER] [--magonly MAGONLY]
                    [--mode MODE] [--ani ANI]



[93mGeneral options:[0m

[94m--task[0m    
    Select a program to run:
    end_to_end    || Run phamer, phagcn, phatyp, cherry, and phavip once (default) 
                     --skip Y can skip the phamer (deault N)
    phamer        || Virus identification
    phagcn        || Taxonomy classification
    phatyp        || Lifestyle prediction
    cherry        || Host prediction
    phavip        || Protein annotation
    contamination || Contamination/proviurs detection
    votu          || vOTU grouping (ANI-based or AAI-based)
    tree          || Build phylogenetic trees based on marker genes

    [93mFor more options in specific tasks, please run:[0m
        [93mphabox2 --task [task] -h[0m
        [93mExample:[0m
            [93mphabox2 --task phamer -h[0m
            [93mphabox2 --task phagcn -h[0m
    [93mend_to_end task will not show the options but use all the parameters[0m
    [93mYou can also check the parameters via: https://github.com/KennthShang/PhaBOX/wiki/Command-line-options [0m
            


[94m--dbdir[0m 
    Path of downloaded phabox2 database directory (required)

[94m--outpth[0m         
    Rootpth for the output folder (required)
    All the results, including intermediate files and final predictions, are stored in this folder. 

[94m--contigs[0m
    Path of the input FASTA file (required)

[94m--proteins[0m  
    FASTA file of predicted proteins. (optional)

[94m--midfolder[0m 
    Midfolder for intermediate files. (optional)
    This folder will be created within the --outpth to store intermediate files.

[94m--len[0m
    Filter the length of contigs || default: 3000
    Contigs with length smaller than this value will not proceed 

[94m--threads[0m   
    Number of threads to use || default: all available threads
```

