# netsyn CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| netsyn | PASS | real genomes from NCBI (4 Mollicutes/Buchnera, rplB targets) via a correspondences file; added NetworkAccess and nucleic_files input |
| netsyn_clusteringIntoFamilies | PASS | family counts match the main netsyn run |
| netsyn_dataExport | Failed | tool bug: crashes with a missing clusteringMethod argument when run alone |
| netsyn_getINSDCFiles | PASS | two real UniProt accessions, downloaded from ENA |
| netsyn_parseINSDCFiles_GetTaxonomy | PASS | same 4 real genomes |
| netsyn_syntenyFinder | Failed | tool bug: crashes with KeyError 'metrics' when run alone |

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

## netsyn_getINSDCFiles

### Tool Description
Download the INSDC files for a list of UniProt accessions.

### Metadata
- **Docker Image**: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/labgem/netsyn
- **Package**: https://anaconda.org/channels/bioconda/packages/netsyn/overview
- **Validation**: PASS

### Original Help Text
```text
usage: GetINSDCFiles.py -u <UniProtAC.list> -o <OutputName>

version: 1.0.0

options:
  -h, --help            show this help message and exit

General settings:
  -u, --UniProtACList UNIPROTACLIST
                        Protein accession list.
  -o, --OutputName OUTPUTNAME
                        Name of corresponding file.

logger:
  --logLevel [{ERROR,error,WARNING,warning,INFO,info,DEBUG,debug}]
                        log level
  --logFile [LOGFILE]   log file (use the stderr by default)
```

## netsyn_parseINSDCFiles_GetTaxonomy

### Tool Description
Parse INSDC files to extract genomic contexts and taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/labgem/netsyn
- **Package**: https://anaconda.org/channels/bioconda/packages/netsyn/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ParseINSDCFiles_GetTaxonomy.py -c <CorrespondencesFile> -o <outputName> [--IncludedPseudogenes]

version: 1.0.0

options:
  -h, --help            show this help message and exit

General settings:
  -c, --CorrespondencesFile CORRESPONDENCESFILE
                        Correspondence entry file between: protein_AC/nucleic_AC/nucleic_File_Path (cf: wiki)
  -o, --outputName OUTPUTNAME
                        Output name files
  --IncludedPseudogenes
                        CDS annotated as pseudogenes are considered as part of the genomic context

logger:
  --logLevel [{ERROR,error,WARNING,warning,INFO,info,DEBUG,debug}]
                        log level
  --logFile [LOGFILE]   log file (use the stderr by default)
```

## netsyn_clusteringIntoFamilies

### Tool Description
Group proteins into families with MMseqs2.

### Metadata
- **Docker Image**: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/labgem/netsyn
- **Package**: https://anaconda.org/channels/bioconda/packages/netsyn/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ClusteringIntoFamilies.py -f <fastaFileName> -ip <proteinsFile> -o <outputName> -id <ident> -mc <MinimalCoverage>

version: 1.0.0

options:
  -h, --help            show this help message and exit

General settings:
  -f, --FastaFile FASTAFILE
                        Fasta file obtained during the previous process ParseINSDCFiles_GetTaxonomy with all proteins sequences
  -ip, --inputProteins INPUTPROTEINS
                        Json file obtained during the previous process ParseINSDCFiles_GetTaxonomy containing proteins information
  -o, --outputName OUTPUTNAME
                        Output name files
  -id, --Identity IDENTITY
                        Sequence identity.
                        Default value: 0.3
  -cov, --Coverage COVERAGE
                        Minimal coverage allowed.
                        Default value: 0.8

Advanced settings:
  -asm, --MMseqsAdvancedSettings MMSEQSADVANCEDSETTINGS
                        YAML file with the advanced clustering settings to determine protein families. Settings of MMseqs2 software

logger:
  --logLevel [{ERROR,error,WARNING,warning,INFO,info,DEBUG,debug}]
                        log level
  --logFile [LOGFILE]   log file (use the stderr by default)
```

## netsyn_syntenyFinder

### Tool Description
Find conserved syntenies between genomic contexts.

### Metadata
- **Docker Image**: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/labgem/netsyn
- **Package**: https://anaconda.org/channels/bioconda/packages/netsyn/overview
- **Validation**: PASS

### Original Help Text
```text
Matplotlib not present
Visualization not supported to missing libraries.
usage: SyntenyFinder.py -ip <proteinsFileName> -it <targetsFileName> -o <outputName>
		-ws <WindowSize> -sg <SyntenyGap> -ssc <SyntenyScoreCutoff>

version: 1.0.0

options:
  -h, --help            show this help message and exit

General settings:
  -ip, --inputProteins INPUTPROTEINS
                        Proteins File
  -it, --inputTargets INPUTTARGETS
                        Targets File
  -o, --outputName OUTPUTNAME
                        Output name files
  -ws, --WindowSize {3,5,7,9,11}
                        Window size of genomic contexts to compare (target gene inclued).
                        Default value: 11.
  -sg, --SyntenyGap SYNTENYGAP
                        Number of genes allowed between two genes in synteny.
                        Default value: 3
  -ssc, --SyntenyScoreCutoff SYNTENYSCORECUTOFF
                        Define the minimum Synteny Score Cut off to conserved.
                        Default value: >= 3.0

Advanced settings:
  -asc, --ClusteringAdvancedSettings CLUSTERINGADVANCEDSETTINGS
                        YAML file with the advanced clustering settings to determine synteny NetSyn. Settings of clusterings methods

logger:
  --logLevel [{ERROR,error,WARNING,warning,INFO,info,DEBUG,debug}]
                        log level
  --logFile [LOGFILE]   log file (use the stderr by default)
```

## netsyn_dataExport

### Tool Description
Export the NetSyn graph and results.

### Metadata
- **Docker Image**: quay.io/biocontainers/netsyn:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/labgem/netsyn
- **Package**: https://anaconda.org/channels/bioconda/packages/netsyn/overview
- **Validation**: PASS

### Original Help Text
```text
usage: DataExport.py -in <inputNodes> -ie <inputEdges> -io <inputOrganisms> -ip <inputProteins> -o <outputName>
		[-md <metadataFile>]
		[-rrl <GroupingOnLabel> | -rrt <GroupingOnTaxonomy> -cm <ClusteringMethod>]

version: 1.0.0

options:
  -h, --help            show this help message and exit

General settings:
  -in, --inputNodes INPUTNODES
                        Path of the nodes file obtained from the SyntenyFinder part
  -ie, --inputEdges INPUTEDGES
                        Path of the edges file obtained from the SyntenyFinder part
  -io, --inputOrganisms INPUTORGANISMS
                        Path of the organims file from the ClusteringIntoFamilies part
  -ip, --inputProteins INPUTPROTEINS
                        Path of the proteins file from the ClusteringIntoFamilies part
  -o, --outputName OUTPUTNAME
                        Output name files
  -md, --metadataFile METADATAFILE
                        Path of the metadata file provided by the user

Redundancy Removal settings:
  -cm, --ClusteringMethod {MCL,Infomap,Louvain,WalkTrap}
                        Clustering method choose in : MCL (small graph), Infomap (medium graph), Louvain (medium graph) or WalkTrap (big  graph).
                        Default value: MCL
  -rrl, --GroupingOnLabel GROUPINGONLABEL
                        Label of the metadata column on which the redundancy will be computed (Incompatible with --GroupingOnTaxonomy option.)
  -rrt, --GroupingOnTaxonomy {superkingdom,phylum,class,order,family,genus,species}
                        Taxonomic rank on which the redundancy will be computed. (Incompatible with --GroupingOnLabel option)

logger:
  --logLevel [{ERROR,error,WARNING,warning,INFO,info,DEBUG,debug}]
                        log level
  --logFile [LOGFILE]   log file (use the stderr by default)
```

