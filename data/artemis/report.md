# artemis CWL Generation Report

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


## artemis_bamview

### Tool Description
Starting BamView with arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
- **Homepage**: http://sanger-pathogens.github.io/Artemis/
- **Package**: https://anaconda.org/channels/bioconda/packages/artemis/overview
- **Validation**: PASS

### Original Help Text
```text
Starting BamView with arguments: -mx2g -ms100m -noverify -Djdbc.drivers=org.postgresql.Driver -Dartemis.environment=UNIX  --help
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


## Metadata
- **Skill**: generated
