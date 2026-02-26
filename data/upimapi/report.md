# upimapi CWL Generation Report

## upimapi

### Tool Description
UniProt Id Mapping through API

### Metadata
- **Docker Image**: quay.io/biocontainers/upimapi:1.13.3--hdfd78af_0
- **Homepage**: https://github.com/iquasere/UPIMAPI
- **Package**: https://anaconda.org/channels/bioconda/packages/upimapi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/upimapi/overview
- **Total Downloads**: 112.2K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/iquasere/UPIMAPI
- **Stars**: N/A
### Original Help Text
```text
usage: upimapi [-h] [-i INPUT] [-o OUTPUT] [-ot OUTPUT_TABLE]
               [-rd RESOURCES_DIRECTORY] [-cols COLUMNS]
               [--from-db {UniProtKB AC/ID,UniParc,UniRef50,UniRef90,UniRef100,Gene Name,CRC64,CCDS,EMBL/GenBank/DDBJ,EMBL/GenBank/DDBJ CDS,GI number,PIR,RefSeq Nucleotide,RefSeq Protein,PDB,BioGRID,ComplexPortal,DIP,STRING,ChEMBL,DrugBank,GuidetoPHARMACOLOGY,SwissLipids,Allergome,ESTHER,MEROPS,PeroxiBase,REBASE,TCDB,GlyConnect,BioMuta,DMDM,CPTAC,ProteomicsDB,DNASU,Ensembl,Ensembl Genomes,Ensembl Genomes Protein,Ensembl Genomes Transcript,Ensembl Protein,Ensembl Transcript,GeneID,KEGG,PATRIC,UCSC,WBParaSite,WBParaSite Transcript/Protein,ArachnoServer,Araport,CGD,ClinPGx,ConoServer,dictyBase,EchoBASE,euHCVdb,FlyBase,GeneCards,GeneReviews,HGNC,LegioList,Leproma,MaizeGDB,MGI,MIM,OpenTargets,Orphanet,PomBase,PseudoCAP,RGD,SGD,TubercuList,VEuPathDB,VGNC,WormBase,WormBase Protein,WormBase Transcript,Xenbase,ZFIN,eggNOG,GeneTree,HOGENOM,OMA,OrthoDB,BioCyc,PlantReactome,Reactome,UniPathway,ChiTaRS,GeneWiki,GenomeRNAi,PHI-base,CollecTF,DisProt,IDEAL}]
               [--to-db {UniProtKB,UniProtKB/Swiss-Prot,UniParc,UniRef50,UniRef90,UniRef100,Gene Name,CRC64,CCDS,EMBL/GenBank/DDBJ,EMBL/GenBank/DDBJ CDS,GI number,PIR,RefSeq Nucleotide,RefSeq Protein,PDB,BioGRID,ComplexPortal,DIP,STRING,ChEMBL,DrugBank,GuidetoPHARMACOLOGY,SwissLipids,Allergome,ESTHER,MEROPS,PeroxiBase,REBASE,TCDB,GlyConnect,BioMuta,DMDM,CPTAC,ProteomicsDB,DNASU,Ensembl,Ensembl Genomes,Ensembl Genomes Protein,Ensembl Genomes Transcript,Ensembl Protein,Ensembl Transcript,GeneID,KEGG,PATRIC,UCSC,WBParaSite,WBParaSite Transcript/Protein,ArachnoServer,Araport,CGD,ClinPGx,ConoServer,dictyBase,EchoBASE,euHCVdb,FlyBase,GeneCards,GeneReviews,HGNC,LegioList,Leproma,MaizeGDB,MGI,MIM,OpenTargets,Orphanet,PomBase,PseudoCAP,RGD,SGD,TubercuList,VEuPathDB,VGNC,WormBase,WormBase Protein,WormBase Transcript,Xenbase,ZFIN,eggNOG,GeneTree,HOGENOM,OMA,OrthoDB,BioCyc,PlantReactome,Reactome,UniPathway,ChiTaRS,GeneWiki,GenomeRNAi,PHI-base,CollecTF,DisProt,IDEAL}]
               [--blast] [--full-id FULL_ID] [--fasta] [--step STEP]
               [--max-tries MAX_TRIES] [--sleep SLEEP] [--no-annotation]
               [--local-id-mapping] [--skip-id-mapping] [--skip-id-checking]
               [--skip-db-check] [--mirror {expasy,uniprot,ebi}] [-v]
               [-db DATABASE] [-t THREADS] [--evalue EVALUE] [--pident PIDENT]
               [--bitscore BITSCORE] [-mts MAX_TARGET_SEQS] [-b BLOCK_SIZE]
               [-c INDEX_CHUNKS] [--max-memory MAX_MEMORY] [--taxids TAXIDS]
               [--diamond-mode {fast,mid_sensitive,sensitive,more_sensitive,very_sensitive,ultra_sensitive}]
               [--show-available-fields]

UniProt Id Mapping through API

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input filename - can be: 1. a file containing a list
                        of IDs (comma-separated values, no spaces) 2. a BLAST
                        TSV result file (requires to be specified with the
                        --blast parameter 3. a protein FASTA file to be
                        annotated (requires the -db parameter) 4. nothing! If
                        so, will read input from command line, and parse as
                        CSV (id1,id2,...)
  -o, --output OUTPUT   Folder to store outputs
  -ot, --output-table OUTPUT_TABLE
                        Filename of table output, where UniProt info is
                        stored. If set, will override 'output' parameter just
                        for that specific file
  -rd, --resources-directory RESOURCES_DIRECTORY
                        Directory to store resources of UPIMAPI
                        [~/upimapi_resources]
  -cols, --columns COLUMNS
                        List of UniProt columns to obtain information from
                        (separated by &)
  --from-db {UniProtKB AC/ID,UniParc,UniRef50,UniRef90,UniRef100,Gene Name,CRC64,CCDS,EMBL/GenBank/DDBJ,EMBL/GenBank/DDBJ CDS,GI number,PIR,RefSeq Nucleotide,RefSeq Protein,PDB,BioGRID,ComplexPortal,DIP,STRING,ChEMBL,DrugBank,GuidetoPHARMACOLOGY,SwissLipids,Allergome,ESTHER,MEROPS,PeroxiBase,REBASE,TCDB,GlyConnect,BioMuta,DMDM,CPTAC,ProteomicsDB,DNASU,Ensembl,Ensembl Genomes,Ensembl Genomes Protein,Ensembl Genomes Transcript,Ensembl Protein,Ensembl Transcript,GeneID,KEGG,PATRIC,UCSC,WBParaSite,WBParaSite Transcript/Protein,ArachnoServer,Araport,CGD,ClinPGx,ConoServer,dictyBase,EchoBASE,euHCVdb,FlyBase,GeneCards,GeneReviews,HGNC,LegioList,Leproma,MaizeGDB,MGI,MIM,OpenTargets,Orphanet,PomBase,PseudoCAP,RGD,SGD,TubercuList,VEuPathDB,VGNC,WormBase,WormBase Protein,WormBase Transcript,Xenbase,ZFIN,eggNOG,GeneTree,HOGENOM,OMA,OrthoDB,BioCyc,PlantReactome,Reactome,UniPathway,ChiTaRS,GeneWiki,GenomeRNAi,PHI-base,CollecTF,DisProt,IDEAL}
                        Which database are the IDs from. If from UniProt,
                        default is fine [UniProtKB AC/ID]
  --to-db {UniProtKB,UniProtKB/Swiss-Prot,UniParc,UniRef50,UniRef90,UniRef100,Gene Name,CRC64,CCDS,EMBL/GenBank/DDBJ,EMBL/GenBank/DDBJ CDS,GI number,PIR,RefSeq Nucleotide,RefSeq Protein,PDB,BioGRID,ComplexPortal,DIP,STRING,ChEMBL,DrugBank,GuidetoPHARMACOLOGY,SwissLipids,Allergome,ESTHER,MEROPS,PeroxiBase,REBASE,TCDB,GlyConnect,BioMuta,DMDM,CPTAC,ProteomicsDB,DNASU,Ensembl,Ensembl Genomes,Ensembl Genomes Protein,Ensembl Genomes Transcript,Ensembl Protein,Ensembl Transcript,GeneID,KEGG,PATRIC,UCSC,WBParaSite,WBParaSite Transcript/Protein,ArachnoServer,Araport,CGD,ClinPGx,ConoServer,dictyBase,EchoBASE,euHCVdb,FlyBase,GeneCards,GeneReviews,HGNC,LegioList,Leproma,MaizeGDB,MGI,MIM,OpenTargets,Orphanet,PomBase,PseudoCAP,RGD,SGD,TubercuList,VEuPathDB,VGNC,WormBase,WormBase Protein,WormBase Transcript,Xenbase,ZFIN,eggNOG,GeneTree,HOGENOM,OMA,OrthoDB,BioCyc,PlantReactome,Reactome,UniPathway,ChiTaRS,GeneWiki,GenomeRNAi,PHI-base,CollecTF,DisProt,IDEAL}
                        To which database the IDs should be mapped. If only
                        interested in columns information (which include
                        cross-references), default is fine [UniProtKB]
  --blast               If input file is in BLAST TSV format (will consider
                        one ID per line if not set) [false]
  --full-id FULL_ID     If IDs in database are in 'full' format: tr|XXX|XXX
                        [auto]
  --fasta               Output will be generated in FASTA format [false]
  --step STEP           How many IDs to submit per request to the API [1000]
  --max-tries MAX_TRIES
                        How many times to try obtaining information from
                        UniProt before giving up [3]
  --sleep SLEEP         Time between requests (in seconds) [3]
  --no-annotation       Do not perform annotation - input must be in one of
                        BLAST result or TXT IDs file or STDIN [false]
  --local-id-mapping    Perform local ID mapping of SwissProt IDs. Advisable
                        if many IDs of SwissProt are present [false]
  --skip-id-mapping     If true, UPIMAPI will not perform ID mapping [false]
  --skip-id-checking    If true, UPIMAPI will not check if IDs are valid
                        before mapping [false]
  --skip-db-check       So UPIMAPI doesn't check for (FASTA) database
                        existence [false]
  --mirror {expasy,uniprot,ebi}
                        From where to download UniProt database [expasy]
  -v, --version         show program's version number and exit

DIAMOND arguments:
  -db, --database DATABASE
                        How the reference database is inputted to UPIMAPI. 1.
                        uniprot - UPIMAPI will download the entire UniProt and
                        use it as reference 2. swissprot - UPIMAPI will
                        download SwissProt and use it as reference 3. taxids -
                        Reference proteomes will be downloaded for the taxa
                        specified with the --taxids, and those will be used as
                        reference 4. a custom database - Input will be
                        considered as the database, and will be used as
                        reference
  -t, --threads THREADS
                        Number of threads to use in annotation steps [all
                        available]
  --evalue EVALUE       Maximum e-value to report annotations for [1e-3]
  --pident PIDENT       Minimum pident to report annotations for.
  --bitscore BITSCORE   Minimum bit score to report annotations for (overrides
                        e-value).
  -mts, --max-target-seqs MAX_TARGET_SEQS
                        Number of annotations to output per sequence inputed
                        [1]
  -b, --block-size BLOCK_SIZE
                        Billions of sequence letters to be processed at a time
                        [memory / 20]
  -c, --index-chunks INDEX_CHUNKS
                        Number of chunks for processing the seed index
                        [dependant on block size]
  --max-memory MAX_MEMORY
                        Maximum memory to use (in Gb) [all available]
  --taxids TAXIDS       Tax IDs to obtain protein sequences of for building a
                        reference database.
  --diamond-mode {fast,mid_sensitive,sensitive,more_sensitive,very_sensitive,ultra_sensitive}
                        Mode to run DIAMOND with [fast]

Special functions:
  --show-available-fields
                        Outputs the fields available from the API.

A tool for retrieving information from UniProt.
```

