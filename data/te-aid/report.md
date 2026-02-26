# te-aid CWL Generation Report

## te-aid_TE-Aid

### Tool Description
TE+Aid is a tool to help the manual curation of transposable elements (TE). It requires a TE consensus sequence and a reference genome both in fasta format.

### Metadata
- **Docker Image**: quay.io/biocontainers/te-aid:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/clemgoub/TE-Aid/tree/v{version}
- **Package**: https://anaconda.org/channels/bioconda/packages/te-aid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/te-aid/overview
- **Total Downloads**: 118
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/clemgoub/TE-Aid
- **Stars**: N/A
### Original Help Text
```text
***********************************
   Error! No mandatory arguments given
   ***********************************

  _______  ______               _      _ 
 |__   __||  ____| _     /\    (_)    | |
    | |   | |__  _| |_  /  \    _   __| |
    | |   |  __||_   _|/ /\ \  | | / _` |
    | |   | |____ |_| / ____ \ | || (_| |
    |_|   |______|   /_/    \_\|_| \__,_|
  
                   v.1.1-dev

   This is a developmental version, please report bugs to goubert.clement@gmail.com

   **************************************

   TE+Aid is a tool to help the manual curation of transposable elements (TE).
   It requires a TE consensus sequence and a reference genome both in fasta format.

   Full Documentation: https://github.com/clemgoub/TE-Aid                             
                                      
   ***************************************

   Usage: ./TE-Aid [-q|--query <TE.fasta>] [-g|--genome <genome.fasta>] [options]

   mandatory arguments:
    
    -q, --query                   TE consensus to blast (fasta file)
    -g, --genome                  Reference genome (fasta file)

   optional arguments:
    
    -h, --help                    show this help message and exit
    
    -o, --output                  output folder (default "./")
    -t, --tables                  write features coordinates in tables (self dot-plot, ORFs and protein hits coordinates)
    -T, --all-Tables              same as -t plus write the genomic blastn table. 
                                  Warning: can be very large if your TE is highly repetitive!
    -r, --remove-redundant        remove redundant hits from genomic blastn table and a title of the first plot
    
    -e, --e-value                 genome blastn: e-value threshold to keep hit (default: 10e-8)
    -f, --full-length-threshold   genome blastn: min. proportion (hit_size)/(consensus_size) to be considered "full length" (0-1; default: 0.9)

    -m, --min-orf                 getorf: minimum ORF size (in bp)
    -R, --no-reverse-orfs         getorf: don't use ORFs in ther reverse complement of your sequence

    -a, --alpha                   graphical: transparency value for blastn hit (0-1; default 0.3)
    -F, --full-length-alpha       graphical: transparency value for full-length blastn hits (0-1; default 1)
    -y, --auto-y                  graphical: manual override for y lims (default: TRUE; otherwise: -y NUM)

    -D | --emboss-dotmatcher      Produce a dotplot with EMBOSS dotmatcher
```

