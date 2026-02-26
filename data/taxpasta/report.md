# taxpasta CWL Generation Report

## taxpasta_standardise

### Tool Description
Standardise a taxonomic profile (alias: 'standardize')

### Metadata
- **Docker Image**: quay.io/biocontainers/taxpasta:0.7.0--pyhdfd78af_1
- **Homepage**: https://github.com/taxprofiler/taxpasta
- **Package**: https://anaconda.org/channels/bioconda/packages/taxpasta/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxpasta/overview
- **Total Downloads**: 21.4K
- **Last updated**: 2025-11-18
- **GitHub**: https://github.com/taxprofiler/taxpasta
- **Stars**: N/A
### Original Help Text
```text
Usage: taxpasta standardise [OPTIONS] PROFILE                                  
                                                                                
 Standardise a taxonomic profile (alias: 'standardize').                        
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    profile      PATH  A file containing a taxonomic profile. [required]    │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --profiler            -p      [bracken|centrifuge|  The taxonomic         │
│                                  diamond|ganon|kaiju|  profiler used.        │
│                                  kmcp|kraken2|krakenu  [required]            │
│                                  niq|megan6|metaphlan                        │
│                                  |motus]                                     │
│ *  --output              -o      PATH                  The desired output    │
│                                                        file. By default, the │
│                                                        file extension will   │
│                                                        be used to determine  │
│                                                        the output format,    │
│                                                        but when setting the  │
│                                                        format explicitly     │
│                                                        using the             │
│                                                        --output-format       │
│                                                        option, automatic     │
│                                                        detection is          │
│                                                        disabled.             │
│                                                        [required]            │
│    --output-format               [tsv|csv|ods|xlsx|ar  The desired output    │
│                                  row|parquet]          format. Depending on  │
│                                                        the choice,           │
│                                                        additional package    │
│                                                        dependencies may      │
│                                                        apply. By default it  │
│                                                        will be parsed from   │
│                                                        the output file name  │
│                                                        but it can be set     │
│                                                        explicitly and will   │
│                                                        then disable the      │
│                                                        automatic detection.  │
│    --summarise-at,--su…          TEXT                  Summarise abundance   │
│                                                        profiles at higher    │
│                                                        taxonomic rank. The   │
│                                                        provided option must  │
│                                                        match a rank in the   │
│                                                        taxonomy exactly.     │
│                                                        This is akin to the   │
│                                                        clade assigned reads  │
│                                                        provided by, for      │
│                                                        example, kraken2,     │
│                                                        where the abundances  │
│                                                        of a whole taxonomic  │
│                                                        branch are assigned   │
│                                                        to a taxon at the     │
│                                                        desired rank. Please  │
│                                                        note that abundances  │
│                                                        above the selected    │
│                                                        rank are simply       │
│                                                        ignored. No attempt   │
│                                                        is made to            │
│                                                        redistribute those    │
│                                                        down to the desired   │
│                                                        rank. Some tools,     │
│                                                        like Bracken, were    │
│                                                        designed for this     │
│                                                        purpose but it        │
│                                                        doesn't seem like a   │
│                                                        problem we can        │
│                                                        generally solve here. │
│    --taxonomy                    PATH                  The path to a         │
│                                                        directory containing  │
│                                                        taxdump files. At     │
│                                                        least nodes.dmp and   │
│                                                        names.dmp are         │
│                                                        required. A           │
│                                                        merged.dmp file is    │
│                                                        optional.             │
│    --add-name                                          Add the taxon name to │
│                                                        the output.           │
│    --add-rank                                          Add the taxon rank to │
│                                                        the output.           │
│    --add-lineage                                       Add the taxon's       │
│                                                        entire lineage to the │
│                                                        output. These are     │
│                                                        taxon names separated │
│                                                        by semi-colons.       │
│    --add-id-lineage                                    Add the taxon's       │
│                                                        entire lineage to the │
│                                                        output. These are     │
│                                                        taxon identifiers     │
│                                                        separated by          │
│                                                        semi-colons.          │
│    --add-rank-lineage                                  Add the taxon's       │
│                                                        entire rank lineage   │
│                                                        to the output. These  │
│                                                        are taxon ranks       │
│                                                        separated by          │
│                                                        semi-colons.          │
│    --help                -h                            Show this message and │
│                                                        exit.                 │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## taxpasta_merge

### Tool Description
Standardise and merge two or more taxonomic profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxpasta:0.7.0--pyhdfd78af_1
- **Homepage**: https://github.com/taxprofiler/taxpasta
- **Package**: https://anaconda.org/channels/bioconda/packages/taxpasta/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: taxpasta merge [OPTIONS] [PROFILE1 PROFILE2 [...]]                      
                                                                                
 Standardise and merge two or more taxonomic profiles.                          
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   profiles      [PROFILE1 PROFILE2 [...]]  Two or more files containing      │
│                                            taxonomic profiles. Required      │
│                                            unless there is a sample sheet.   │
│                                            Filenames will be parsed as       │
│                                            sample names.                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --profiler          -p            [bracken|centrifug  The taxonomic       │
│                                      e|diamond|ganon|ka  profiler used. All  │
│                                      iju|kmcp|kraken2|k  provided profiles   │
│                                      rakenuniq|megan6|m  must come from the  │
│                                      etaphlan|motus]     same tool!          │
│                                                          [required]          │
│    --samplesheet       -s            FILE                A table with a      │
│                                                          header and two      │
│                                                          columns: the first  │
│                                                          column named        │
│                                                          'sample' which can  │
│                                                          be any string and   │
│                                                          the second column   │
│                                                          named 'profile'     │
│                                                          which must be a     │
│                                                          file path to an     │
│                                                          actual taxonomic    │
│                                                          abundance profile.  │
│                                                          If this option is   │
│                                                          provided, any       │
│                                                          arguments are       │
│                                                          ignored.            │
│    --samplesheet-for…                [tsv|csv|ods|xlsx|  The file format of  │
│                                      arrow|parquet]      the sample sheet.   │
│                                                          Depending on the    │
│                                                          choice, additional  │
│                                                          package             │
│                                                          dependencies may    │
│                                                          apply. Will be      │
│                                                          parsed from the     │
│                                                          sample sheet file   │
│                                                          name but can be set │
│                                                          explicitly.         │
│ *  --output            -o            PATH                The desired output  │
│                                                          file. By default,   │
│                                                          the file extension  │
│                                                          will be used to     │
│                                                          determine the       │
│                                                          output format, but  │
│                                                          when setting the    │
│                                                          format explicitly   │
│                                                          using the           │
│                                                          --output-format     │
│                                                          option, automatic   │
│                                                          detection is        │
│                                                          disabled.           │
│                                                          [required]          │
│    --output-format                   [tsv|csv|ods|xlsx|  The desired output  │
│                                      arrow|parquet|biom  format. Depending   │
│                                      ]                   on the choice,      │
│                                                          additional package  │
│                                                          dependencies may    │
│                                                          apply. By default   │
│                                                          it will be parsed   │
│                                                          from the output     │
│                                                          file name but it    │
│                                                          can be set          │
│                                                          explicitly and will │
│                                                          then disable the    │
│                                                          automatic           │
│                                                          detection.          │
│    --wide                  --long                        Output merged       │
│                                                          abundance data in   │
│                                                          either wide or      │
│                                                          (tidy) long format. │
│                                                          Ignored when the    │
│                                                          desired output      │
│                                                          format is BIOM.     │
│                                                          [default: wide]     │
│    --summarise-at,--…                TEXT                Summarise abundance │
│                                                          profiles at higher  │
│                                                          taxonomic rank. The │
│                                                          provided option     │
│                                                          must match a rank   │
│                                                          in the taxonomy     │
│                                                          exactly. This is    │
│                                                          akin to the clade   │
│                                                          assigned reads      │
│                                                          provided by, for    │
│                                                          example, kraken2,   │
│                                                          where the           │
│                                                          abundances of a     │
│                                                          whole taxonomic     │
│                                                          branch are assigned │
│                                                          to a taxon at the   │
│                                                          desired rank.       │
│                                                          Please note that    │
│                                                          abundances above    │
│                                                          the selected rank   │
│                                                          are simply ignored. │
│                                                          No attempt is made  │
│                                                          to redistribute     │
│                                                          those down to the   │
│                                                          desired rank. Some  │
│                                                          tools, like         │
│                                                          Bracken, were       │
│                                                          designed for this   │
│                                                          purpose but it      │
│                                                          doesn't seem like a │
│                                                          problem we can      │
│                                                          generally solve     │
│                                                          here.               │
│    --taxonomy                        PATH                The path to a       │
│                                                          directory           │
│                                                          containing taxdump  │
│                                                          files. At least     │
│                                                          nodes.dmp and       │
│                                                          names.dmp are       │
│                                                          required. A         │
│                                                          merged.dmp file is  │
│                                                          optional.           │
│    --add-name                                            Add the taxon name  │
│                                                          to the output.      │
│    --add-rank                                            Add the taxon rank  │
│                                                          to the output.      │
│    --add-lineage                                         Add the taxon's     │
│                                                          entire lineage to   │
│                                                          the output. These   │
│                                                          are taxon names     │
│                                                          separated by        │
│                                                          semi-colons.        │
│    --add-id-lineage                                      Add the taxon's     │
│                                                          entire lineage to   │
│                                                          the output. These   │
│                                                          are taxon           │
│                                                          identifiers         │
│                                                          separated by        │
│                                                          semi-colons.        │
│    --add-rank-lineage                                    Add the taxon's     │
│                                                          entire rank lineage │
│                                                          to the output.      │
│                                                          These are taxon     │
│                                                          ranks separated by  │
│                                                          semi-colons.        │
│    --ignore-errors                                       Ignore any          │
│                                                          metagenomic         │
│                                                          profiles with       │
│                                                          errors. Please note │
│                                                          that there must be  │
│                                                          at least two        │
│                                                          profiles without    │
│                                                          errors to merge.    │
│    --help              -h                                Show this message   │
│                                                          and exit.           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
