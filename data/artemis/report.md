# artemis CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| artemis_act | Not completed | ACT is an interactive Java GUI genome browser that needs a display and cannot run as a batch job. |
| artemis_art | Not completed | Artemis is an interactive Java GUI genome browser that needs a display and cannot run as a batch job. |
| artemis_dnaplotter | Not completed | DNAPlotter is an interactive Java GUI program that fails headless and cannot run as a batch job. |
| artemis_writedb_entry | Not completed | writedb_entry exports entries from a Chado PostgreSQL database; no Chado server is available, so the run only logged 'Connection refused'. |

## artemis_art

### Tool Description
Artemis: Genome Browser and Annotation Tool

### Metadata
- **Docker Image**: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
- **Homepage**: http://sanger-pathogens.github.io/Artemis/
- **Package**: https://anaconda.org/channels/bioconda/packages/artemis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/artemis/overview
- **Total Downloads**: 34.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS
        Artemis: Genome Browser and Annotation Tool
USAGE
        /usr/local/bin/art [options] <SEQUENCE_FILE> [+FEATURE_FILE ...]
OPTIONS
        SEQUENCE_FILE                  An EMBL, GenBank, FASTA, or GFF3 file
        FEATURE_FILE                   An Artemis TAB file, or GFF file

        -options FILE                  Read a text file of options from FILE
        -chado                         Connect to a Chado database (using PGHOST, PGPORT, PGDATABASE, PGUSER environment variables)

        -Dblack_belt_mode=?            Keep warning messages to a minimum [true,false]
        -Doffset=XXX                   Open viewer at base position XXX [integer >= 1]
        -Duserplot=FILE[,FILE2]        Open one or more userplots
        -Dloguserplot=FILE[,FILE2]     Open one or more userplots, take log(data)
        -Dbam=FILE[,FILE2,...]         Open one or more BAM, CRAM, VCF or BCF files
        -DbamClone=n                   Open all BAM, CRAM, VCF or BCF files in multiple (n > 1) panels
        -Dbam[1,2,..]=FILE[,FILE2,..]  Open BAM, CRAM, VCF or BCF files in separate panels
        -Dshow_snps                    Show SNP marks in BamView
        -Dshow_snp_plot                Open SNP plot in BamView
        -Dshow_cov_plot                Open coverage plot in BamView
        -Dshow_forward_lines=?         Hide/show forward frame lines [true,false]
        -Dshow_reverse_lines=?         Hide/show reverse frame lines [true,false]
        -Dchado="h:p/d?u"              Get Artemis to open this CHADO database
        -Dread_only                    Open CHADO database read-only
EXAMPLES
        % art AJ006275.embl
        % art contigs.fa +annotation.gff +islands.tab
        % art -Dblack_belt_mode=true -Dbam=ecoli_hiseq.bam E_coli_K12.gbk
        % art -Duserplot=repeatmap.plot,geecee.plot Plasmid.gff3
HOMEPAGE
        http://www.sanger.ac.uk/science/tools/artemis
```


## artemis_act

### Tool Description
Genome Comparison Tool

### Metadata
- **Docker Image**: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
- **Homepage**: http://sanger-pathogens.github.io/Artemis/
- **Package**: https://anaconda.org/channels/bioconda/packages/artemis/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS
       Artemis Comparison Tool (ACT): Genome Comparison Tool
USAGE
        /usr/local/bin/act [options] <SEQUENCE_1> <COMPARISON_1_2> <SEQUENCE_2> ...
OPTIONS
        SEQUENCE                   An EMBL, GenBank, FASTA, or GFF3 file
        FEATURE                    An Artemis TAB file, or GFF file
        COMPARISON                 A BLAST comparison file in tabular format

        -options FILE              Read a text file of options from FILE
        -chado                     Connect to a Chado database (using PGHOST, PGPORT, PGDATABASE, PGUSER environment variables)

        -Dblack_belt_mode=?         Keep warning messages to a minimum [true,false]
        -DuserplotX=FILE[,FILE2]    For sequence 'X' open one or more userplots
        -DloguserplotX=FILE[,FILE2] For sequence 'X' open one or more userplots, take log(data)
        -DbamX=FILE[,FILE2,...]     For sequence 'X' open one or more BAM, CRAM, VCF, or BCF files
        -Dchado="h:p/d?u"           Get ACT to open this CHADO database
        -Dread_only                 Open CHADO database read-only
EXAMPLES
        % act
        % act af063097.embl af063097_v_b132222.crunch b132222.embl
        % act -Dblack_belt_mode=true -Dbam1=MAL_0h.bam -Dbam2=MAL_7h.bam,var.raw.new.bcf
        % act -Duserplot2=/pathToFile/userPlot

HOMEPAGE
        http://www.sanger.ac.uk/science/tools/artemis-comparison-tool-act
```


## artemis_dnaplotter

### Tool Description
DNA Image Generation Tool

### Metadata
- **Docker Image**: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
- **Homepage**: http://sanger-pathogens.github.io/Artemis/
- **Package**: https://anaconda.org/channels/bioconda/packages/artemis/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS
        DNA Plotter: DNA Image Generation Tool
USAGE
        /usr/local/bin/dnaplotter [options]
OPTIONS
        -t FILE      Read a template file

EXAMPLES
        % dnaplotter
        % dnaplotter -t <template file>

HOMEPAGE
        http://www.sanger.ac.uk/science/tools/dnaplotter/
```


## artemis_writedb_entry

### Tool Description
Reads entries from a Chado database and writes them out as EMBL or GFF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
- **Homepage**: http://sanger-pathogens.github.io/Artemis/
- **Package**: https://anaconda.org/channels/bioconda/packages/artemis/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/artemis/overview
- **Total Downloads**: 34.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A

### Original Help Text
```text
openjdk version "11.0.9.1-internal" 2020-11-04 OpenJDK Runtime Environment (build 11.0.9.1-internal+0-adhoc..src) OpenJDK 64-Bit Server VM (build 11.0.9.1-internal+0-adhoc..src, mixed mode)
Starting writedb_entry with arguments:   -mx2048m -ms20m -Djdbc.drivers=org.postgresql.Driver -Dibatis 
Using classpath: /usr/local/share/artemis-18.2.0-0/etc/..:/usr/local/share/artemis-18.2.0-0/etc/../target/jars/artemis.jar:/usr/local/share/artemis-18.2.0-0/etc/../dist/artemis.jar
-h	show help
-f	[y|n] flatten the gene model, default is y
-flt	space separated list of qualifiers to ignore (GFF only)
-i	[y|n] ignore obsolete features, default is y
-s	space separated list of sequences to read and write out
-o	[EMBL|GFF] output format, default is EMBL
Advanced parameters:
-l	location of EMBL mapping files (qualifier_mapping and key_mapping)
-z	[y|n] gzip output, default is y
-a	[y|n] for EMBL submission format change to n, default is y
-pp	[y|n] read polypeptide domain features, default is n
-r	[y|n] remove product qualifiers from pseudogene (only for EMBL submission format), default is n
-c	the URL for your Chado database e.g. server_name:port/database_name?user (if not using default)
-u	[swing|console|script] the UI mode : run in swing (with popup dialog boxes) mode, run in console mode (choices entered in the console window), or in script mode (all choices default to continue, all parameters passed on command line) 
-p	the password for connecting to the Chado database
-fp	 the file path (the folder you want to save the files in)
-np	[y|n] do not write out private qualifiers, default is y
```

## Metadata
- **Skill**: generated
