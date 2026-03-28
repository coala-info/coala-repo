# gempipe CWL Generation Report

## gempipe_recon

### Tool Description
gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

### Metadata
- **Docker Image**: quay.io/biocontainers/gempipe:1.38.5--pyhdfd78af_0
- **Homepage**: https://github.com/lazzarigioele/gempipe
- **Package**: https://anaconda.org/channels/bioconda/packages/gempipe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gempipe/overview
- **Total Downloads**: 13.8K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/lazzarigioele/gempipe
- **Stars**: N/A
### Original Help Text
```text
usage: gempipe recon [-h] [-v] [-c] [-o] [--verbose] [--overwrite] [--dbs]
                     [-t] [-g] [-p] [-gb] [-s] [-b] [--buscoM] [--buscoF]
                     [--ncontigs] [--N50] [--identity] [--coverage] [-rm]
                     [-rp] [-rs] [-mc] [--tcdb] [--dedup] [--norec] [--dbmem]
                     [--sbml] [--nofig] [-md]

gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

options:
  -h, --help            Show this help message and exit.
  -v, --version         Show version number and exit.
  -c , --cores          Number of parallel processes to use. (default: 1)
  -o , --outdir         Main output directory (will be created if not
                        existing). (default: ./)
  --verbose             Make stdout messages more verbose, including debug
                        messages. (default: False)
  --overwrite           Delete the working/ directory at the startup.
                        (default: False)
  --dbs                 Path were the needed databases are stored (or
                        downloaded if not already existing). (default:
                        ./working/dbs/)
  -t , --taxids         Taxids of the species to model (comma separated, for
                        example '252393,68334'). (default: -)
  -g , --genomes        Input genome files or folder containing the genomes
                        (see documentation). (default: -)
  -p , --proteomes      Input proteome files or folder containing the
                        proteomes (see documentation). (default: -)
  -gb , --genbanks      Input genbank files (.gb, .gbff) or folder containing
                        the genbanks (see documentation). (default: -)
  -s , --staining       Gram staining, 'pos' or 'neg'. (default: neg)
  -b , --buscodb        Busco database to use ('show' to see the list of
                        available databases). (default: bacteria_odb10)
  --buscoM              Maximum number of missing Busco's single copy
                        orthologs (absolute or percentage). (default: 2%)
  --buscoF              Maximum number of fragmented Busco's single copy
                        orthologs (absolute or percentage). (default: 100%)
  --ncontigs            Maximum number of contigs allowed per genome.
                        (default: 200)
  --N50                 Minimum N50 allowed per genome. (default: 50000)
  --identity            Minimum percentage amino acidic sequence identity to
                        use when aligning against the BiGG gene database.
                        (default: 30)
  --coverage            Minimum percentage coverage to use when aligning
                        against the BiGG gene database. (default: 70)
  -rm , --refmodel      Model to be used as reference. (default: -)
  -rp , --refproteome   Proteome to be used as reference. (default: -)
  -rs , --refspont      Reference gene marking spontaneous reactions.
                        (default: spontaneous)
  -mc , --mancor        Manual corrections to apply during the reference
                        expansion. (default: -)
  --tcdb                Experimental feature: try to build transport reactions
                        using TCDB. (default: False)
  --dedup               Try to remove duplicate metabolites and reactions
                        using MNX annotation, when a reference is provided.
                        (default: False)
  --norec               Skip gene recovery when starting from genomes.
                        (default: False)
  --dbmem               Load the entire eggNOG-mapper database into memory
                        (should speed up the functional annotation step).
                        (default: False)
  --sbml                Save the output GSMMs in SBML format (L3V1 FBC2) in
                        addition to JSON. (default: False)
  --nofig               Skip the generation of figures. (default: False)
  -md , --metadata      Table for manual correction of genome metadata.
                        (default: -)
```


## gempipe_derive

### Tool Description
gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

### Metadata
- **Docker Image**: quay.io/biocontainers/gempipe:1.38.5--pyhdfd78af_0
- **Homepage**: https://github.com/lazzarigioele/gempipe
- **Package**: https://anaconda.org/channels/bioconda/packages/gempipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gempipe derive [-h] [-v] [-c] [-o] [--verbose] [-im] [-ip] [-ir] [-ig]
                      [-m] [--minflux] [--biolog] [--sbml] [--skipgf]
                      [--nofig] [--aux] [--cnps] [--cnps_minmed] [--biosynth]

gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

options:
  -h, --help           Show this help message and exit.
  -v, --version        Show version number and exit.
  -c , --cores         How many parallel processes to use. (default: 1)
  -o , --outdir        Main output directory (will be created if not
                       existing). (default: ./)
  --verbose            Make stdout messages more verbose, including debug
                       messages. (default: False)
  -im , --inpanmodel   Path to the input pan-model. (default: -)
  -ip , --inpam        Path to the input PAM. (default: -)
  -ir , --inreport     Path to the input report file. (default: -)
  -ig , --ingannots    Path to the input genes annotation file. (default: -)
  -m , --media         Medium definition file or folder containing media
                       definitions, to be used during the automatic gap-
                       filling. (default: -)
  --minflux            Minimum flux through the objective of strain-specific
                       models. (default: 0.1)
  --biolog             Simulate Biolog's utilization tests on strain-specific
                       models. (default: False)
  --sbml               Save the output GSMMs in SBML format (L3V1 FBC2) in
                       addition to JSON. (default: False)
  --skipgf             Skip the gap-filling step applied to the strain-
                       specific models. (default: False)
  --nofig              Skip the generation of figures. (default: False)
  --aux                Test auxotrophies for aminoacids and vitamins.
                       (default: False)
  --cnps               Sistematically simulate growth on all the available
                       C-N-P-S sources. (default: False)
  --cnps_minmed        Base the C-N-P-S simulations on a minimal medium
                       leading to the specified minimum objective value. If 0,
                       user-defined medium will be used. (default: 0.0)
  --biosynth           Check biosynthesis of each metabolite while granting
                       the specified minimum fraction of objective. If 0, this
                       step will be skipped. (default: 0.0)
```


## gempipe_autopilot

### Tool Description
gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

### Metadata
- **Docker Image**: quay.io/biocontainers/gempipe:1.38.5--pyhdfd78af_0
- **Homepage**: https://github.com/lazzarigioele/gempipe
- **Package**: https://anaconda.org/channels/bioconda/packages/gempipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gempipe autopilot [-h] [-v] [-c] [-o] [--verbose] [--overwrite] [--dbs]
                         [-t] [-g] [-p] [-gb] [-s] [-b] [--buscoM] [--buscoF]
                         [--ncontigs] [--N50] [--identity] [--coverage] [-rm]
                         [-rp] [-rs] [-mc] [--tcdb] [--dedup] [--norec]
                         [--dbmem] [--sbml] [--nofig] [-md] [-m] [--minflux]
                         [--minpanflux] [--biolog] [--aux] [--cnps]
                         [--cnps_minmed] [--biosynth]

gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

options:
  -h, --help            Show this help message and exit.
  -v, --version         Show version number and exit.
  -c , --cores          Number of parallel processes to use. (default: 1)
  -o , --outdir         Main output directory (will be created if not
                        existing). (default: ./)
  --verbose             Make stdout messages more verbose, including debug
                        messages. (default: False)
  --overwrite           Delete the working/ directory at the startup.
                        (default: False)
  --dbs                 Path were the needed databases are stored (or
                        downloaded if not already existing). (default:
                        ./working/dbs/)
  -t , --taxids         Taxids of the species to model (comma separated, for
                        example '252393,68334'). (default: -)
  -g , --genomes        Input genome files or folder containing the genomes
                        (see documentation). (default: -)
  -p , --proteomes      Input proteome files or folder containing the
                        proteomes (see documentation). (default: -)
  -gb , --genbanks      Input genbank files (.gb, .gbff) or folder containing
                        the genbanks (see documentation). (default: -)
  -s , --staining       Gram staining, 'pos' or 'neg'. (default: neg)
  -b , --buscodb        Busco database to use ('show' to see the list of
                        available databases). (default: bacteria_odb10)
  --buscoM              Maximum number of missing Busco's single copy
                        orthologs (absolute or percentage). (default: 2%)
  --buscoF              Maximum number of fragmented Busco's single copy
                        orthologs (absolute or percentage). (default: 100%)
  --ncontigs            Maximum number of contigs allowed per genome.
                        (default: 200)
  --N50                 Minimum N50 allowed per genome. (default: 50000)
  --identity            Minimum percentage amino acidic sequence identity to
                        use when aligning against the BiGG gene database.
                        (default: 30)
  --coverage            Minimum percentage coverage to use when aligning
                        against the BiGG gene database. (default: 70)
  -rm , --refmodel      Model to be used as reference. (default: -)
  -rp , --refproteome   Proteome to be used as reference. (default: -)
  -rs , --refspont      Reference gene marking spontaneous reactions.
                        (default: spontaneous)
  -mc , --mancor        Manual corrections to apply during the reference
                        expansion. (default: -)
  --tcdb                Experimental feature: try to build transport reactions
                        using TCDB. (default: False)
  --dedup               Try to remove duplicate metabolites and reactions
                        using MNX annotation, when a reference is provided.
                        (default: False)
  --norec               Skip gene recovery when starting from genomes.
                        (default: False)
  --dbmem               Load the entire eggNOG-mapper database into memory
                        (should speed up the functional annotation step).
                        (default: False)
  --sbml                Save the output GSMMs in SBML format (L3V1 FBC2) in
                        addition to JSON. (default: False)
  --nofig               Skip the generation of figures. (default: False)
  -md , --metadata      Table for manual correction of genome metadata.
                        (default: -)
  -m , --media          Medium definition file or folder containing media
                        definitions, to be used during the automatic gap-
                        filling. (default: -)
  --minflux             Minimum flux through the objective of strain-specific
                        models. (default: 0.1)
  --minpanflux          Minimum flux through the objective of the pan model.
                        (default: 0.3)
  --biolog              Simulate Biolog's utilization tests on strain-specific
                        models. (default: False)
  --aux                 Test auxotrophies for aminoacids and vitamins.
                        (default: False)
  --cnps                Sistematically simulate growth on all the available
                        C-N-P-S sources. (default: False)
  --cnps_minmed         Base the C-N-P-S simulations on a minimal medium
                        leading to the specified minimum objective value. If
                        0, user-defined medium will be used. (default: 0.0)
  --biosynth            Check biosynthesis of each metabolite while granting
                        the specified minimum fraction of objective. If 0,
                        this step will be skipped. (default: 0.0)
```


## Metadata
- **Skill**: not generated

## gempipe

### Tool Description
gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

### Metadata
- **Docker Image**: quay.io/biocontainers/gempipe:1.38.5--pyhdfd78af_0
- **Homepage**: https://github.com/lazzarigioele/gempipe
- **Package**: https://anaconda.org/channels/bioconda/packages/gempipe/overview
- **Validation**: PASS
### Original Help Text
```text
usage: gempipe [-h] [-v] {recon,derive,autopilot} ...

gempipe v1.38.5. Full documentation available at
https://gempipe.readthedocs.io/en/latest/index.html. Please cite: "Lazzari G.,
Felis G. E., Salvetti E., Calgaro M., Di Cesare F., Teusink B., Vitulo N.
Gempipe: a tool for drafting, curating, and analyzing pan and multi-strain
genome-scale metabolic models. mSystems. December 2025.
https://doi.org/10.1128/msystems.01007-25".

options:
  -h, --help            Show this help message and exit.
  -v, --version         Show version number and exit.

gempipe subcommands:
  {recon,derive,autopilot}
    recon               Reconstruct a draft pan-model and a PAM.
    derive              Derive strain- and species-specific models.
    autopilot           Run recon + derive, with automated pan-model gap-
                        filling. Use with consciousness!
```

