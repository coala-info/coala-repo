# gapseq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gapseq_adapt | PASS | toy data shipped with gapseq (E. coli core proteome and toy models) |
| gapseq_doall | Not completed | too heavy for this machine: it searches all pathways and ran over 25 minutes on a 38 KB proteome without finishing |
| gapseq_draft | PASS | toy data shipped with gapseq (E. coli core proteome and toy models) |
| gapseq_fill | PASS | toy data shipped with gapseq (E. coli core proteome and toy models) |
| gapseq_find | PASS | toy data shipped with gapseq (E. coli core proteome and toy models) |
| gapseq_find-transport | PASS | toy data shipped with gapseq (E. coli core proteome and toy models) |
| gapseq_medium | PASS | toy data shipped with gapseq (E. coli core proteome and toy models) |
| gapseq_pan | PASS | toy data shipped with gapseq (E. coli core proteome and toy models) |

## gapseq_find

### Tool Description
Pathway analysis, try to find enzymes based on homology.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage
/usr/local/share/gapseq/src/gapseq_find.sh -p <keyword> / -e <EC> [-d <database>] [-t <taxonomy>] file.fasta
  -p keywords such as pathways or subsystems (for example amino,nucl,cofactor,carbo,polyamine)
  -e Search by ec numbers (comma separated)
  -r Search by enzyme name (colon separated)
  -d Database: vmh or seed (default: seed)
  -t Taxonomic range for reference sequences to be used. (Bacteria, Archaea, auto; default: Bacteria). See Details.
  -b Bit score cutoff for local alignment (default: 200)
  -i Identity cutoff for local alignment (default: 0)
  -c Coverage cutoff for local alignment (default: 75)
  -s Strict candidate reaction handling (do _not_ use pathway completeness, key kenzymes and operon structure to infere if imcomplete pathway could be still present (default: false)
  -u Suffix used for output files (default: pathway keyword)
  -a blast hits back against uniprot enzyme database
  -n Consider superpathways of metacyc database
  -l Select the pathway database (MetaCyc, KEGG, SEED, all; default: metacyc,custom)
  -o Only list pathways found for keyword (default: false)
  -x Do not blast only list pathways, reactions and check for available sequences (default: false)
  -q Include sequences of hits in log files (default: false)
  -v Verbose level, 0 for nothing, 1 for pathway infos, 2 for full (default: 1)
  -k Do not use parallel (Deprecated: use '-K 1' instead to disable multi-threading.)
  -g Exhaustive search, continue blast even when cutoff is reached (default: false)
  -z Quality of sequences for homology search: 1:only reviewed (swissprot), 2:unreviewed only if reviewed not available, 3:reviewed+unreviewed, 4:only unreviewed (default: 2)
  -m Limit pathways to taxonomic range (default: all)
  -w Use additional sequences derived from gene names (default: true)
  -y Print annotation genome coverage (default: false)
  -j Quit if output files already exist (default: false)
  -f Path to directory, where output files will be saved (default: current directory)
  -U Do not use gapseq sequence archive and update sequences from uniprot manually (very slow) (default: false)
  -T Set user-defined temporary folder (default: false)
  -O Force offline mode (default: false)
  -M Input genome mode. Either 'nucl', 'prot', or 'auto' (default 'auto')
  -K Number of threads for sequence alignments. If option is not provided, number of available CPUs will be automatically determined.

Details:
"-t": if 'auto', gapseq tries to predict if the organism is Bacteria or Archaea based on the provided genome sequence. The prediction is based on the 16S rRNA gene sequence using a classifier that was trained on 16S rRNA genes from organisms with known Gram-staining phenotype. In case no 16S rRNA gene was found, a k-mer based classifier is used instead.
```

## gapseq_find-transport

### Tool Description
Search for transporters based on homology.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage
/usr/local/share/gapseq/src/transporter.sh file.fasta.
  -b bit score cutoff for local alignment (default: 50)
  -i identity cutoff for local alignment (default: 0)
  -c coverage cutoff for local alignment (default: 75)
  -q Include sequences of hits in log files; default false
  -k do not use parallel
  -m only check for this keyword/metabolite (default: all)
  -f Path to directory, where output files will be saved (default: current directory)
  -v Verbose level, 0 for nothing, 1 for full (default 1)
  -M Input genome mode. Either 'nucl' or 'prot' (default 'auto')
  -K Number of threads for sequence alignments. If option is not provided, number of available CPUs will be automatically determined.
```

## gapseq_draft

### Tool Description
Draft model construction based on results from find and find-transport.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gapseq draft -r|--blast.res <character> [-t|--transporter.res <character>] [-b|--biomass <character>] [-n|--model.name <character>] [-c|--genome.seq <character>] [-u|--high.evi.rxn.BS <numeric>] [-l|--min.bs.for.core <numeric>] [-f|--output.dir <character>] [-o|--depr.output.dir <character>] [-s|--sbml.no.output] [-p|--pathway.pred <character>] [-h|--help]
    -r|--blast.res         Blast-results table generated by gapseq find.
    -t|--transporter.res   Blast-results table generated by gapseq find-transport.
    -b|--biomass           Biomass reaction for network model. Options: Gram "pos" OR "neg" OR "archaea" OR "auto" OR path to user-defined biomass reaction. Default: "auto". See Details.
    -n|--model.name        Name of draft model network. Default: the basename of "blast.res"
    -c|--genome.seq        If biomass "-b" is set to "auto", the genome sequence is required to predict the prokaryotic biomass reaction.
    -u|--high.evi.rxn.BS   Reactions with an associated blast-hit with a bitscore above this value will be added to the draft model as core reactions (i.e. high-sequence-evidence reactions)
    -l|--min.bs.for.core   Reactions with an associated blast-hit with a bitscore below this value will be considered just as reactions that have no blast hit.
    -f|--output.dir        Path to directory, where output files will be saved (default: current directory)
    -o|--depr.output.dir   deprecated. Use flag "-f" instead
    -s|--sbml.no.output    Do not save draft model as sbml file. Default: Save as SBML
    -p|--pathway.pred      Pathway-results table generated by gapseq find.
    -h|--help              help
(help text rebuilt from the option table in src/generate_GSdraft.R, because the script prints an R error instead of its usage with -h)
```

## gapseq_medium

### Tool Description
(gapfill-)Medium prediction based on results from find and draft.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/share/gapseq/src/predict_medium.R [-[-model|m] <character>] [-[-pathway.pred|p] <character>] [-[-manual.flux|c] [<character>]] [-[-output.file|o] [<character>]] [-[-output.dir|-f] [<character>]] [-[-help|h]]
    -m|--model           GapSeq(-Draft)-Model (RDS or SBML)
    -p|--pathway.pred    Pathway-results table generated by gapseq.sh.
    -c|--manual.flux     (optional, character) Specify fixed maxFlux
  			 values in medium for specific compounds.
  			 Format: [Compound 1]:[Compound 1 maxFlux];[Compound 2]:[Compound 2 maxFlux]
    -o|--output.file     (optional, character). File name for medium
  			 table in csv format. Default: Replacement of 'model' file extension 
  			 (eg. '.RDS' or '-draft.RDS') with '-medium.csv.
    --f|--output.dir      Path to directory, where output files will be saved (default: current directory)
    -h|--help            help
```

## gapseq_fill

### Tool Description
Gap filling of a model.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/share/gapseq/src/gf.suite.R [-[-model|m] <character>] [-[-help|h]] [-[-media|n] <character>] [-[-target.metabolite|t] [<character>]] [-[-rxn.weights.file|c] <character>] [-[-rxnXgene.table|g] <character>] [-[-bcore|b] [<double>]] [-[-output.dir|-f] [<character>]] [-[-depr.output.dir|o] [<character>]] [-[-sbml.no.output|s] [<logical>]] [-[-quick.gf|q] [<logical>]] [-[-limit|l] [<character>]] [-[-no.core|x] [<logical>]] [-[-verbose|v] [<logical>]] [-[-relaxed.constraints|r] [<logical>]] [-[-environment|e] [<character>]] [-[-write.cs.ferm|w] [<logical>]] [-[-min.obj.val|k] [<double>]]
    -m|--model                  gapseq-Draft-Model to be gapfilled (RDS or SBML)
    -h|--help                   help
    -n|--media                  tab- or komma separated table for media components. Requires three named columns: 1 - "compounds" (for metab. IDs), 2 - "name" (metab. name), 3 - "maxFlux" (maximum inflow flux)
    -t|--target.metabolite      ID (without compartment suffix) of metabolite that shall be produced. Default: cpd11416 (Biomass)
    -c|--rxn.weights.file       Reaction weights table generated by gapseq function "generate_GSdraft.R" (RDS format).
    -g|--rxnXgene.table         Table with gene-X-reaction associations as generated by the "generate_GSdraft.R" (RDS format)
    -b|--bcore                  Minimum bitscore for reaction associated blast hits to consider reactions as core/candidate reactions. Default: 50
    --f|--output.dir             Path to directory, where output files will be saved (default: current directory)
    -o|--depr.output.dir        deprecated. Use flag"-f" instead
    -s|--sbml.no.output         Do not save gapfilled model as sbml file. Default: Save as SBML
    -q|--quick.gf               perform only step 1 and 2. Default: FALSE
    -l|--limit                  Test metabolite to which search is limitted
    -x|--no.core                Use always all reactions instead of core reactions, which have sequence evidence. Default: FALSE
    -v|--verbose                Verbose output and printing of debug messages. Default: FALSE
    -r|--relaxed.constraints    Save final model as unconstraint network (i.e. all exchange reactions are open). Default: FALSE
    -e|--environment            Adjusting reaction directions according to specific environmental conditions. See documentation for details. CAUTION: experimental option!
    -w|--write.cs.ferm          Write a list with found carbon sources and fermentation products
    -k|--min.obj.val            Minimum growth rate that should be achieved by gap-filling. Default: 0.01
```

## gapseq_adapt

### Tool Description
Add or remove reactions or pathways.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/share/gapseq/src/adapt.R [-[-model|m] <character>] [-[-id|i] [<character>]] [-[-help|h]] [-[-add|a] [<character>]] [-[-remove|r] [<character>]] [-[-growth|w] [<character>]] [-[-rxn.weights.file|c] [<character>]] [-[-rxnXgene.table|g] [<character>]] [-[-rxn.blast.file|b] <character>] [-[-output.dir|f] [<character>]] [-[-min.growth|k] [<double>]] [-[-sbml.no.output|s] [<logical>]] [-[-verbose|v] [<logical>]]
    -m|--model               gapseq model to be extended (RDS or SBML)
    -i|--id                  Model identifier when provides model rds file is a list of many models
    -h|--help                help
    -a|--add                 reactions or pathways that should be added to the model (comma-separated)
    -r|--remove              reactions or pathways that should be removed from the model (comma-separated)
    -w|--growth              compounds for which growth or non-growth should be ensured (cpd00027:TRUE,cpd00017:FALSE)
    -c|--rxn.weights.file    Reaction weights table generated by gapseq function "generate_GSdraft.R" (RDS format; needed for 'growth' option).
    -g|--rxnXgene.table      Table with gene-X-reaction associations as generated by the "generate_GSdraft.R" (RDS format; needed for 'growth; option)
    -b|--rxn.blast.file      Blast-results table generated by gapseq find.
    -f|--output.dir          Path to directory, where output files will be saved (default: current directory)
    -k|--min.growth          Set minimum growth rate that should be achieved by gap-filling.
    -s|--sbml.no.output      Do not save gapfilled model as sbml file. Default: Save as SBML
    -v|--verbose             Verbose output and printing of debug messages. Default: FALSE
```

## gapseq_pan

### Tool Description
Reconstruct a pan-Draft from a list of models.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/share/gapseq/src/pan-draft.R [-[-help|h]] [-[-models_path|m] <character>] [-[-rxn.weights.files_path|c] [<character>]] [-[-rxnXgene.tables_path|g] [<character>]] [-[-pathways.table.path|w] [<character>]] [-[-min.rxn.freq.in.mods|t] [<double>]] [-[-only.binary.rxn.tbl|b] [<logical>]] [-[-output.dir|f] [<character>]] [-[-sbml.no.output|s] [<logical>]]
    -h|--help                      help
    -m|--models_path               list of filepaths (comma separated) to gapseq-Draft-Models (RDS format) to reconstruct the pan-Model;
                                    Input can also be provided using wildcards or path to a directory
    -c|--rxn.weights.files_path    list of filepaths (comma separated) to reaction weight tables generated by gapseq function "generate_GSdraft.R" (RDS format);
                                    Input can also be provided using wildcards or path to a directory
    -g|--rxnXgene.tables_path      list of paths to tables with gene-X-reaction associations as generated by the "generate_GSdraft.R" (RDS format);
                                    Input can also be provided using wildcards or path to a directory
    -w|--pathways.table.path       list of paths to all-Pathways tables as generated by the "gapseq_find.sh" (tbl format)
    -t|--min.rxn.freq.in.mods      minimum reaction frequency (mrf) to include the reactions in the pan-Draft. Default: 0.06
    -b|--only.binary.rxn.tbl       perform only models comparison to get a binary table summarizing rxn presence/absence. Default: FALSE
    -f|--output.dir                path to directory, where output files will be saved (default: current directory)
    -s|--sbml.no.output            Do not save model as sbml file. Default: Save as SBML
```

## gapseq_doall

### Tool Description
Combine find, find-transport, draft, (medium,) and fill.

### Metadata
- **Docker Image**: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
- **Homepage**: https://github.com/jotech/gapseq
- **Package**: https://anaconda.org/channels/bioconda/packages/gapseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  gapseq doall (genome) [medium] [Bacteria|Archaea]

Options:
  doall           Combine find, find-transport, draft, (medium,) and fill.
  -n              Enable noisy verbose mode.
  -K              Number of threads for sequence alignments. If option is not provided, number of available CPUs will be automatically determined.

Examples:
  gapseq doall toy/ecoli.faa.gz
  gapseq doall toy/myb71.fna.gz dat/media/TSBmed.csv
```

## Metadata
- **Skill**: generated
