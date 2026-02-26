# netsyn CWL Generation Report

## netsyn

### Tool Description
netsyn

### Metadata
- **Docker Image**: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/labgem/netsyn
- **Package**: https://anaconda.org/channels/bioconda/packages/netsyn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/netsyn/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-27
- **GitHub**: https://github.com/labgem/netsyn
- **Stars**: N/A
### Original Help Text
```text
usage: netsyn -u <UniProtAC.list> -o <OutputDirName> [-md <metadataFile>, --conserveDownloadedINSDC]
       netsyn -u <UniProtAC.list> -c <CorrespondencesFileName> -o <OutputDirName> [-md <metadataFile>, --conserveDownloadedINSDC]
       netsyn -c <CorrespondencesFileName> -o <OutputDirName> [-md <metadataFile>]

version: 1.0.0

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

General settings:
  -u, --UniProtACList UNIPROTACLIST
                        UniProt accession list input(cf: wiki)
  -c, --CorrespondencesFile CORRESPONDENCESFILE
                        Correspondence entry file between: protein_AC/nucleic_AC/nucleic_File_Path (cf: wiki)
  -o, --OutputDirName OUTPUTDIRNAME
                        Output directory name, used to define the project name
  -md, --MetaDataFile METADATAFILE
                        File containing metadata
  -pd, --ProjectDescription PROJECTDESCRIPTION
                        The project description
  -np, --newProject     Force the creation of a new projet. Overwrite the project of the same name
  --conserveDownloadedINSDC
                        Conserve the downloaded files from GetINSDC. Require of --UniProtACList option
  --IncludedPseudogenes
                        CDS annotated as pseudogenes are considered as part of the genomic context

Clustering settings to determine protein families:
  -id, --Identity IDENTITY
                        Sequence identity.
                        Default value: 0.3
  -cov, --Coverage COVERAGE
                        Minimal coverage allowed.
                        Default value: 0.8
  -mas, --MMseqsAdvancedSettings MMSEQSADVANCEDSETTINGS
                        YAML file with the advanced clustering settings to determine protein families. Settings of MMseqs2 software

Synteny settings:
  -ws, --WindowSize {3,5,7,9,11}
                        Window size of genomic contexts to compare (target gene included).
                        Default value: 11.
  -sg, --SyntenyGap SYNTENYGAP
                        Number of genes allowed between two genes in synteny.
                        Default value: 3
  -ssc, --SyntenyScoreCutoff SYNTENYSCORECUTOFF
                        Define the Synteny Score Cutoff to conserved.
                        Default value: >= 3.0
  -cas, --ClusteringAdvancedSettings CLUSTERINGADVANCEDSETTINGS
                        YAML file with the advanced clustering settings to determine synteny NetSyn. Settings of clusterings methods

Grouping clustering settings:
  -cm, --ClusteringMethod {MCL,Infomap,Louvain,WalkTrap}
                        Clustering method choices: MCL (small graph), Infomap (medium graph), Louvain (medium graph) or WalkTrap (big  graph).
                        Default value: MCL
  -gl, --GroupingOnLabel GROUPINGONLABEL
                        Label of the metadata column on which the redundancy will be computed (Incompatible with --GroupingOnTaxonomy option.)
  -gt, --GroupingOnTaxonomy {superkingdom,phylum,class,order,family,genus,species}
                        Taxonomic rank on which the redundancy will be computed. (Incompatible with --GroupingOnLabel option)

logger:
  --logLevel {ERROR,error,WARNING,warning,INFO,info,DEBUG,debug}
                        log level
  --logFile LOGFILE     log file (use the stderr by default). Disable the log colors.
```

