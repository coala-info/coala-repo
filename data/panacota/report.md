# panacota CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| panacota_align | PASS |  |
| panacota_annotate | Failed | image problem: matplotlib cannot import (libtiff.so.5 missing), so annotate crashes before annotation |
| panacota_corepers | PASS |  |
| panacota_pangenome | PASS |  |
| panacota_prepare | PASS |  |
| panacota_tree | PASS |  |

## panacota_prepare

### Tool Description
Prepare draft dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gem-pasteur/PanACoTA
- **Package**: https://anaconda.org/channels/bioconda/packages/panacota/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PanACoTA prepare [-T NCBI_SPECIES_TAXID] [-t NCBI_TAXID] [-S STRAINS]
                        [-g NCBI_SPECIES_NAME] [-s {refseq,genbank}]
                        [-l LEVELS] [-o OUTDIR] [--tmp TMP_DIR] [--cutn CUTN]
                        [--l90 L90] [--nbcont NBCONT] [--min_dist MIN_DIST]
                        [--max_dist MAX_DIST] [-p PARALLEL] [--norefseq]
                        [-d DB_DIR] [-M] [--info INFO_FILE] [-v] [-q] [-h]

 ___                 _____  ___         _____  _____
(  _`\              (  _  )(  _`\      (_   _)(  _  )
| |_) )  _ _   ___  | (_) || ( (_)   _   | |  | (_) |
| ,__/'/'_` )/' _ `\|  _  || |  _  /'_`\ | |  |  _  |
| |   ( (_| || ( ) || | | || (_( )( (_) )| |  | | | |
(_)   `\__,_)(_) (_)(_) (_)(____/'`\___/'(_)  (_) (_)

       Large scale comparative genomics tools

     -------------------------------------------

=> Prepare draft dataset

General arguments:
  -T NCBI_SPECIES_TAXID
                        Species taxid to download, corresponding to the
                        'species taxid' provided by the NCBI. This will
                        download all sequences of this species and all its
                        sub-species.A comma-separated list of species taxids
                        can also be provided. (Ex: -T 573 for Klebsiella
                        pneumoniae)
  -t NCBI_TAXID         Taxid to download. This can be the taxid of a sub-
                        species, or of a specific strain. A taxid of a
                        subspecies will download all strains in this
                        subspecies EXCEPT the ones which have a specific
                        taxid.A comma-separated list of taxids can also be
                        provided.Ex: '-t 72407' will download all 'general' K.
                        pneumoniae subsp. pneumoniae strains, and '-t 1123862'
                        will download the strain K. pneumoniae subsp.
                        pneumoniae Kp13 (not included in -t 72407, as it is a
                        strain of the subspecies with a specific taxid).
  -S STRAINS            List of strains to download. A comma-separated list of
                        strain names is possible, as well as a path to a
                        filename containing one name per line.Ex: '-S SB2390,
                        IA565' for Klebsiella pneumoniae SB2390 and Klebsiella
                        pneumoniae IA565 strainsEx: '-S path/to/list.txt' path
                        to file with strain names, one per line.
  -g NCBI_SPECIES_NAME  Species to download, corresponding to the 'organism
                        name' provided by the NCBI. Give name between quotes
                        (for example "escherichia coli")
  -s {refseq,genbank}   NCBI section to download: all genbank, or only refseq
                        (default)
  -l LEVELS, --assembly_level LEVELS
                        Assembly levels of genomes to download (default: all).
                        Possible levels are: 'all', 'complete', 'chromosome',
                        'scaffold', 'contig'.You can also provide a comma-
                        separated list of assembly levels. For ex:
                        'complete,chromosome'
  -o OUTDIR             Give the path to the directory where you want to save
                        the downloaded database. In the given directory, it
                        will create a folder 'Database_init' containing all
                        fasta files that will be sent to the control
                        procedure, as well as a folder 'refseq' with all
                        original compressed files downloaded from refseq. By
                        default, this output dir name is the ncbi_species name
                        if given, or ncbi_species_taxid or ncbi_taxid
                        otherwise.
  --tmp TMP_DIR         Specify where the temporary files (sequence split by
                        rows of 'N', sequence with new contig names etc.) must
                        be saved. By default, it will be saved in your
                        out_dir/tmp_files.
  --cutn CUTN           By default, each genome will be cut into new contigs
                        when at least 5 'N' in a row are found in its
                        sequence. If you don't want to cut genomes into new
                        contigs when there are rows of 'N', put 0 to this
                        option. If you want to cut from a different number of
                        'N' in a row, put this value to this option.
  --l90 L90             Maximum value of L90 allowed to keep a genome. Default
                        is 100.
  --nbcont NBCONT       Maximum number of contigs allowed to keep a genome.
                        Default is 999.
  --min_dist MIN_DIST   By default, genomes whose distance to the reference is
                        not between 1e-4 and 0.06 are discarded. You can
                        specify your own lower limit (instead of 1e-4) with
                        this option.
  --max_dist MAX_DIST   By default, genomes whose distance to the reference is
                        not between 1e-4 and 0.06 are discarded. You can
                        specify your own lower limit (instead of 0.06) with
                        this option.
  -p PARALLEL, --threads PARALLEL
                        Run 'N' downloads in parallel (default=1). Put 0 if
                        you want to use all cores of your computer.

Alternatives:
  --norefseq            If you already downloaded refseq genomes and do not
                        want to check them, add this option to directly go to
                        the next steps:quality control (L90, number of
                        contigs...) and mash filter. Don't forget to specify
                        the db_dir (-d option) where you already have your
                        genome sequences.
  -d DB_DIR             If your already downloaded sequences are not in the
                        default directory (outdir/Database_init), you can
                        specify here the path to those fasta files.
  -M, --only-mash       Add this option if you already downloaded complete and
                        refseq genomes, and ran quality control (you have, a
                        file containing all genome names, as well as their
                        genome size, number of contigs and L90 values). It
                        will then get information on genomes quality from this
                        file, and run mash steps.
  --info INFO_FILE      If you already ran the quality control, specify from
                        which file PanACoTA can read this information, in
                        order to proceed to the mash step. This file must
                        contain at least 4 columns, tab separated, with the
                        following headers: 'to_annotate', 'gsize', 'nb_conts',
                        'L90'. Any other column will be ignored.

Others:
  -v, --verbose         Increase verbosity in stdout/stderr and log files.
  -q, --quiet           Do not display anything to stdout/stderr. log files
                        will still be created.
  -h, --help            show this help message and exit

For more details, see PanACoTA documentation.
```

## panacota_annotate

### Tool Description
Quality control and annotation of genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gem-pasteur/PanACoTA
- **Package**: https://anaconda.org/channels/bioconda/packages/panacota/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PanACoTA annotate [-d DB_PATH] -r RES_PATH [-l LIST_FILE] [-n NAME]
                         [-Q] [--info FROM_INFO] [--prodigal] [--small]
                         [--l90 L90] [--nbcont NBCONT] [--cutn CUTN]
                         [--date DATE] [--tmp TMPDIR] [--annot_dir ANNOTDIR]
                         [-F] [--threads THREADS] [-v] [-q] [-h]

 ___                 _____  ___         _____  _____
(  _`\              (  _  )(  _`\      (_   _)(  _  )
| |_) )  _ _   ___  | (_) || ( (_)   _   | |  | (_) |
| ,__/'/'_` )/' _ `\|  _  || |  _  /'_`\ | |  |  _  |
| |   ( (_| || ( ) || | | || (_( )( (_) )| |  | | | |
(_)   `\__,_)(_) (_)(_) (_)(____/'`\___/'(_)  (_) (_)

       Large scale comparative genomics tools

     -------------------------------------------

=> Quality control and annotation of genomes

Required arguments:
  -d DB_PATH            Path to folder containing all multifasta genome files
  -r RES_PATH           Path to folder where output annotated genomes must be
                        saved

Optional arguments:
  -l LIST_FILE          File containing the list of genome filenames to
                        annotate (1 genome per line). Each genome must be in
                        multi-fasta format. You can specify the species name
                        (4 characters) you want to give to some genome, as
                        well as the download (or any other reason) date of
                        your choice. Format 'genome_name :: name.date'. name
                        and date are optional. See doc for more information on
                        this file format. If you want to run this module from
                        'prepare_module' results, use '--info' instead.
  -n NAME               Choose a name for your annotated genomes. This name
                        should contain 4 alphanumeric characters. Generally,
                        they correspond to the 2 first letters of genus, and 2
                        first letters of species, e.g. ESCO for Escherichia
                        Coli.
  -Q                    Add this option if you want only to do quality control
                        on your genomes (cut at 5N if asked, calculate L90 and
                        number of contigs and plot their distributions). This
                        allows you to check which genomes would be annotated
                        with the given parameters, and to modify those
                        parameters if you want, before you launch the
                        annotation and formatting steps.
  --info FROM_INFO      If you already ran the 'prepare' data module, or
                        already calculated yourself the L90 and number of
                        contigs for each genome, you can give this
                        information, to go directly to annotation and
                        formatting steps. This file contains at least 4
                        columns, tab separated, with the following headers:
                        'to_annotate', 'gsize', 'nb_conts', 'L90'. Any other
                        column will be ignored.
  --prodigal            Add this option if you only want syntactical
                        annotation, given by prodigal, and not functional
                        annotation requiring prokka and is slower.
  --small               If you use Prodigal to annotate genomes, if you
                        sequences are too small (less than 20000 characters),
                        it cannot annotate them with the default options. Add
                        this option to use 'meta' procedure.
  --l90 L90             Maximum value of L90 allowed to keep a genome. Default
                        is 100.
  --nbcont NBCONT       Maximum number of contigs allowed to keep a genome.
                        Default is 999.
  --cutn CUTN           By default, each genome will be cut into new contigs
                        when at least 5 'N' in a row are found in its
                        sequence. If you don't want to cut genomes into new
                        contigs when there are rows of 'N', put 0 to this
                        option. If you want to cut from a different number of
                        'N' occurrences, put this value to this option.
  --date DATE           Specify the date (MMYY) to give to your annotated
                        genomes. By default, will give today's date. The only
                        requirement on the given date is that it is 4
                        characters long. You can use letters if you want. But
                        the common way is to use 4 digits, corresponding to
                        MMYY.
  --tmp TMPDIR          Specify where the temporary files (sequence split by
                        rows of 'N', sequence with new contig names etc.) must
                        be saved. By default, it will be saved in your
                        result_directory/tmp_files.
  --annot_dir ANNOTDIR  Specify in which directory the prokka/prodigal output
                        files (1 folder per genome, called
                        <genome_name>-[prokka, Prodigal]Res) must be saved. By
                        default, they are saved in the same directory as your
                        temporary files (see --tmp option to change it).
  -F, --force           Force run: Add this option if you want to (re)run
                        annotation and formatting steps for all genomes even
                        if their result folder (for annotation step) or files
                        (for format step) already exist: override existing
                        results. Without this option, if there already are
                        results in the given result folder, the program stops.
                        If there are no results, but prokka/prodigal folder
                        already exists, prokka/prodigal won't run again, and
                        the formating step will use the already existing
                        folder if correct, or skip the genome if there are
                        problems in prokka/prodigal folder.
  --threads THREADS     Specify how many threads can be used (default=1)

Others:
  -v, --verbose         Increase verbosity in stdout/stderr.
  -q, --quiet           Do not display anything to stdout/stderr. log files
                        will still be created.
  -h, --help            show this help message and exit

For more details, see PanACoTA documentation.
```

## panacota_pangenome

### Tool Description
Generate a pan-genome of your dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gem-pasteur/PanACoTA
- **Package**: https://anaconda.org/channels/bioconda/packages/panacota/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PanACoTA pangenome -l LSTINFO_FILE -n DATASET_NAME -d DBPATH -o OUTDIR
                          [-i MIN_ID] [-f OUTFILE] [-c {0,1,2}] [-s SPEDIR]
                          [--threads THREADS] [-v] [-q] [-h]

 ___                 _____  ___         _____  _____
(  _`\              (  _  )(  _`\      (_   _)(  _  )
| |_) )  _ _   ___  | (_) || ( (_)   _   | |  | (_) |
| ,__/'/'_` )/' _ `\|  _  || |  _  /'_`\ | |  |  _  |
| |   ( (_| || ( ) || | | || (_( )( (_) )| |  | | | |
(_)   `\__,_)(_) (_)(_) (_)(____/'`\___/'(_)  (_) (_)

       Large scale comparative genomics tools

     -------------------------------------------

=> Generate a pan-genome of your dataset

Required arguments:
  -l LSTINFO_FILE    File containing the list of all genomes to include in the
                     pan-genome, 1 genome per line: it can be the
                     LSTINFO-<list_file>.lst file of 'PanACoTA annotate'
                     module.Here, only the first column (genome name without
                     extension) will be used. All proteins of all these
                     genomes will be concatenated in a file called
                     <dataset_name>.All.prt. The column header must be
                     'gembase_name'.
  -n DATASET_NAME    Name of the dataset which will be clustered (for example,
                     SAEN1234 for 1234 Salmonella enterica genomes). This name
                     will be used to name the protein databank, a well as the
                     pangenome files.
  -d DBPATH          Path to the folder containing all protein files
                     corresponding to the genomes of the dataset (output
                     directory 'Proteins' of 'PanACoTA annotate' module).
  -o OUTDIR          Output directory, where all results must be saved
                     (including tmp folder)

Optional arguments:
  -i MIN_ID          Minimum sequence identity to be considered in the same
                     cluster (float between 0 and 1). Default is 0.8.
  -f OUTFILE         Use this option if you want to give the name of the
                     pangenome output file (without path). Otherwise, by
                     default, it is called PanGenome-mmseq_<given_dataset_name
                     >.All.prt_<information_on_parameters>.lst
  -c {0,1,2}         Choose the clustering mode: 0 for 'set cover', 1 for
                     'single-linkage', 2 for 'CD-Hit'. Default is 'single-
                     linkage' (1)
  -s SPEDIR          use this option if you want to save the concatenated
                     protein databank in another directory than the one
                     containing all individual protein files ('Proteins'
                     folder).
  --threads THREADS  add this option if you want to parallelize on several
                     threads. Indicate on how many threads you want to
                     parallelize. By default, it uses 1 thread. Put 0 if you
                     want to use all threads of your computer.

Others:
  -v, --verbose      Increase verbosity in stdout/stderr.
  -q, --quiet        Do not display anything to stdout/stderr. log files will
                     still be created.
  -h, --help         show this help message and exit

For more details, see PanACoTA documentation.
```

## panacota_corepers

### Tool Description
Compute a Core or Persistent genome of your dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gem-pasteur/PanACoTA
- **Package**: https://anaconda.org/channels/bioconda/packages/panacota/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PanACoTA corepers -p PANGENOME -o OUTPUTDIR [-t TOL] [-M] [-X] [-F]
                         [-l LSTINFO_FILE] [-v] [-q] [-h]

 ___                 _____  ___         _____  _____
(  _`\              (  _  )(  _`\      (_   _)(  _  )
| |_) )  _ _   ___  | (_) || ( (_)   _   | |  | (_) |
| ,__/'/'_` )/' _ `\|  _  || |  _  /'_`\ | |  |  _  |
| |   ( (_| || ( ) || | | || (_( )( (_) )| |  | | | |
(_)   `\__,_)(_) (_)(_) (_)(____/'`\___/'(_)  (_) (_)

       Large scale comparative genomics tools

     -------------------------------------------

=> Compute a Core or Persistent genome of your dataset

Required arguments:
  -p PANGENOME       PanGenome file (1 line per family, first column is fam
                     number)
  -o OUTPUTDIR       Specify the output directory for your core/persistent
                     genome.

Optional arguments:
  -t TOL, --tol TOL  min % of genomes having at least 1 member in a family to
                     consider the family as persistent (between 0 and 1,
                     default is 1 = 100% of genomes = Core genome).By default,
                     the minimum number of genomes will be ceil('tol'*N) (N
                     being the total number of genomes). If you want to use
                     floor('tol'*N) instead, add the '-F' option.
  -M                 Add this option if you allow several members in any
                     genome of a family. By default, only 1 (or 0 if tol<1)
                     member per genome are allowed in all genomes. If you want
                     to allow exactly 1 member in 'tol'% of the genomes, and
                     0, 1 or several members in the '1-tol'% left, use the
                     option -X instead of this one: -M and -X options are not
                     compatible.
  -X                 Add this option if you want to allow families having
                     several members only in '1-tol'% of the genomes. In the
                     other genomes, only 1 member exactly is allowed. This
                     option is not compatible with -M (which is allowing
                     multigenic families: having several members in any number
                     of genomes).
  -F                 When you specify the '-tol' option, with a number lower
                     than 1, you can add this option to use floor('tol'*N) as
                     a minimum number of genomes instead of ceil('tol'*N)
                     which is the default behavior.
  -l LSTINFO_FILE    By default, the core/persistent genome will include all
                     genomes found in the given pangenome file. If you want to
                     do a core/persistent genome on a subset of those genomes,
                     give a file with this list of genomes. This file must
                     have 1 line per genome, only the first column (genome
                     name without extension) will be used.

Others:
  -v, --verbose      Increase verbosity in stdout/stderr.
  -q, --quiet        Do not display anything to stdout/stderr. log files will
                     still be created.
  -h, --help         show this help message and exit

For more details, see PanACoTA documentation.
```

## panacota_align

### Tool Description
Align Core/Persistent families

### Metadata
- **Docker Image**: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gem-pasteur/PanACoTA
- **Package**: https://anaconda.org/channels/bioconda/packages/panacota/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PanACoTA align -c COREPERS -l LIST_GENOMES -n DATASET_NAME -d DBPATH -o
                      OUTDIR [--threads THREADS] [-F] [-P] [-v] [-q] [-h]

 ___                 _____  ___         _____  _____
(  _`\              (  _  )(  _`\      (_   _)(  _  )
| |_) )  _ _   ___  | (_) || ( (_)   _   | |  | (_) |
| ,__/'/'_` )/' _ `\|  _  || |  _  /'_`\ | |  |  _  |
| |   ( (_| || ( ) || | | || (_( )( (_) )| |  | | | |
(_)   `\__,_)(_) (_)(_) (_)(____/'`\___/'(_)  (_) (_)

       Large scale comparative genomics tools

     -------------------------------------------

=> Align Core/Persistent families

Required arguments:
  -c COREPERS        Core or persistent genome whose families must be aligned.
  -l LIST_GENOMES    File containing the list of all the genomes you want to
                     align from their core/persistent families. 1 genome per
                     line: it can be the LSTINFO-<list_file>.lst file of
                     'PanACoTA annotate' module. Here, only the first column
                     (genome name without extension) will be used. The final
                     alignment file will contain 1 alignment per genome in
                     this file.
  -n DATASET_NAME    Name of the dataset which will be aligned (for example,
                     SAEN1234 for 1234 Salmonella enterica genomes). This name
                     will be used to name the alignment file.
  -d DBPATH          Path to the folder containing the directories 'Proteins'
                     and 'Genes', created by 'PanACoTA annotate'.
  -o OUTDIR          Output directory, where all results must be saved

Optional arguments:
  --threads THREADS  add this option if you want to parallelize on several
                     threads. Indicate on how many threads you want to
                     parallelize. By default, it uses 1 thread. Put 0 if you
                     want to use all threads of your computer.
  -F, --force        Force run: Add this option if you want to redo all
                     alignments for all families, even if their result file
                     already exists. Without this option, if an alignment file
                     already exists, it will be used for the next step. If you
                     want to redo only a given alignment, just delete its
                     file, without using this option.
  -P                 Add this option if you also need the aa alignment of the
                     concatenation of all persistent proteins. By default,
                     PanACoTA only gives the nucleic alignment.

Others:
  -v, --verbose      Increase verbosity in stdout/stderr.
  -q, --quiet        Do not display anything to stdout/stderr. log files will
                     still be created.
  -h, --help         show this help message and exit

For more details, see PanACoTA documentation.
```

## panacota_tree

### Tool Description
Infer phylogenetic tree based on core/persistent genome

### Metadata
- **Docker Image**: quay.io/biocontainers/panacota:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gem-pasteur/PanACoTA
- **Package**: https://anaconda.org/channels/bioconda/packages/panacota/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PanACoTA tree -a ALIGNMENT -o OUTDIR
                     [-s {fasttree,fastme,quicktree,iqtree,iqtree2}] [-b BOOT]
                     [--threads THREADS] [-m MODEL] [-B] [-M] [--mem MEMORY]
                     [-fast] [-v] [-q] [-h]

 ___                 _____  ___         _____  _____
(  _`\              (  _  )(  _`\      (_   _)(  _  )
| |_) )  _ _   ___  | (_) || ( (_)   _   | |  | (_) |
| ,__/'/'_` )/' _ `\|  _  || |  _  /'_`\ | |  |  _  |
| |   ( (_| || ( ) || | | || (_( )( (_) )| |  | | | |
(_)   `\__,_)(_) (_)(_) (_)(____/'`\___/'(_)  (_) (_)

       Large scale comparative genomics tools

     -------------------------------------------

=> Infer phylogenetic tree based on core/persistent genome

Required arguments:
  -a ALIGNMENT          Alignment file in multi-fasta: each header will be a
                        leaf of the inferred tree.
  -o OUTDIR             Directory where tree results will be saved.

Choose soft to use (default is IQtree2):
  -s {fasttree,fastme,quicktree,iqtree,iqtree2}, --soft {fasttree,fastme,quicktree,iqtree,iqtree2}
                        Choose with which software you want to infer the
                        phylogenetic tree. Default is IQtree2 (versions 2.x of
                        IQtree). If you want version 1.x of IQtree, use '-s
                        iqtree'

Optional arguments:
  -b BOOT, --boot BOOT  Indicate how many bootstraps you want to compute. By
                        default, no bootstrap is calculated. For IQtree, it
                        will use ultrafast bootstrap (>=1000).
  --threads THREADS     add this option if you want to parallelize on several
                        threads. Indicate on how many threads you want to
                        parallelize. By default, it uses 1 thread. Put 0 if
                        you want to use all threads of your computer. Not
                        available with quicktree.
  -m MODEL, --model MODEL
                        Choose your DNA substitution model. Default for
                        FastTree and IQtree: GTR. Default for FastME: F84. For
                        FastTree, the choices are 'GTR' and 'JC'. For FastME,
                        choices are: 'p-distance' (or 'p'), 'RY symmetric' (or
                        'Y'), 'RY' (or 'R'), 'JC69' (or 'J'), 'K2P' (or 'K'),
                        'F81' (or '1'), 'F84' (or '4'), 'TN93' (or 'T'),
                        'LogDet' (or 'L'). For IQtree, choices are HKY, JC,
                        F81, K2P, K3P, K81uf, TNef, TIM, TIMef, TVM, TVMef,
                        SYM, GTR, TEST. TEST to run standard model selection.
  -B                    Add this option if you want to write all bootstrap
                        pseudo-trees. Only available with FastME and IQtree.
  -M                    Add this option if you want to write the distance
                        matrix. Only available with FastME.
  --mem MEMORY          Maximal RAM usage in GB | MB. Only available with
                        iqtree.
  -fast                 Use -fast option with iqtree.

Others:
  -v, --verbose         Increase verbosity in stdout/stderr.
  -q, --quiet           Do not display anything to stdout/stderr. log files
                        will still be created.
  -h, --help            show this help message and exit

For more details, see PanACoTA documentation.
```
