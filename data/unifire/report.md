# unifire CWL Generation Report

## unifire

### Tool Description
UniProt Functional annotation Inference Rule Engine

### Metadata
- **Docker Image**: quay.io/biocontainers/unifire:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/cmatKhan/unifire/
- **Package**: https://anaconda.org/channels/bioconda/packages/unifire/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unifire/overview
- **Total Downloads**: 143
- **Last updated**: 2025-08-11
- **GitHub**: https://github.com/cmatKhan/unifire
- **Stars**: N/A
### Original Help Text
```text
***************************************************************
   _    _       _  __ _           
  | |  | |     (_)/ _(_)          
  | |  | |_ __  _| |_ _  ___ _ __ 
  | |  | | '_ \| |  _| |/ _ \ '__|
  | |__| | | | | | | | |  __/ |   
   \____/|_| |_|_|_| |_|\___|_|  

     UniProt Functional annotation Inference Rule Engine
***************************************************************

# ------------------------------------------------------------
# Retrieving Unifire URML and template input files
# ------------------------------------------------------------

To download the URML and template input files, replace '2025_02'
with the version you need and run the following commands. If you are
using this in a container, then you will need to do this outside of the
container and then mount the data into the container.

wget ftp://ftp.ebi.ac.uk/pub/contrib/UniProt/UniFIRE/rules/arba-urml-2025_02.xml
wget ftp://ftp.ebi.ac.uk/pub/contrib/UniProt/UniFIRE/rules/unirule-urml-2025_02.xml
wget ftp://ftp.ebi.ac.uk/pub/contrib/UniProt/UniFIRE/rules/unirule-templates-2025_02.xml
wget ftp://ftp.ebi.ac.uk/pub/contrib/UniProt/UniFIRE/rules/unirule.pirsr-urml-2025_02.xml
wget https://proteininformationresource.org/pirsr/pirsr_data_latest.tar.gz

To extract the PIRSR data archive, run:

tar -xzf pirsr_data_latest.tar.gz

# ------------------------------------------------------------
# Running PIRSR
# ------------------------------------------------------------

**NOTE**: hmmeralign is provided in the environment/image. It is not necessary to
provide the `-a` flag when running `pirsr`

# ------------------------------------------------------------
# Retrieving taxa.sqlite for updateIPRScanWithTaxonomicLineage
# ------------------------------------------------------------

To get `taxa.sqlite`, follow the "NCBI Example" instructions at:

https://etetoolkit.github.io/ete/tutorial/tutorial_taxonomy.html#setting-up-local-copies-of-the-ncbi-and-gtdb-taxonomy-databases

provide it to the cmd via the `-t` flag. If you are using this in a container,
be sure to mount the directory containing the taxadb.

03:12:57.436 ERROR u.a.e.u.u.UniFireApp - Missing required options: r, i, o 
--------------------------------------------
usage: unifire -i <INPUT_FILE> -o <OUTPUT_FILE> -r <RULE_URML_FILE> [-f <OUTPUT_FORMAT>] [-n
       <INPUT_CHUNK_SIZE>] [-s <INPUT_SOURCE>] [-t <TEMPLATE_FACTS>] [-m <MAX_MEMORY>] [-h]
--------------------------------------------
     -i,--input <INPUT_FILE>                Input file (path) containing the proteins to annotate
                                            and required data, in the format specified by the -s
                                            option.
     -o,--output <OUTPUT_FILE>              Output file (path) containing predictions in the format
                                            specified in the -f option.
     -r,--rules <RULE_URML_FILE>            Rule base file (path) provided by UniProt (e.g UniRule
                                            or ARBA) (format: URML).
     -f,--output-format <OUTPUT_FORMAT>     Output file format. Supported formats are:
                                            - TSV (Tab-Separated Values)
                                            - XML (URML Fact XML)
                                            (default: TSV).
     -n,--chunksize <INPUT_CHUNK_SIZE>      Chunk size (number of proteins) to be batch processed
                                            simultaneously
                                            (default: 1000).
     -s,--input-source <INPUT_SOURCE>       Input source type. Supported input sources are:
                                            - InterProScan (InterProScan Output XML)
                                            - UniParc (UniParc XML)
                                            - XML (Input Fact XML)
                                            (default: InterProScan).
     -t,--templates <TEMPLATE_FACTS>        UniRule template sequence matches, provided by UniProt
                                            (format: Fact Model XML).
     -m <MAX_MEMORY>                        Max size of the memory allocation pool in MB (JVM -Xmx)
                                            (default: 4096 MB).
     -h,--help                              Print this usage.
--------------------------------------------
```

