# altree CWL Generation Report

## altree

### Tool Description
Perform association tests and localization of susceptibility loci using phylogenetic trees.

### Metadata
- **Docker Image**: biocontainers/altree:v1.3.1-4b2-deb_cv1
- **Homepage**: https://github.com/ALTree/bigfloat
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/altree/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/ALTree/bigfloat
- **Stars**: 26
### Original Help Text
```text
Usage:
    altree [options]

     Options:
        --version        program version
        --short-help|h   brief help message
        --help           help message with options descriptions
        --man            full documentation
        --association|a  perform the association test
        --s-localisation|l   perform the localisation using the S character
        --first-input-file|i result_file from phylogeny reconstruction programs
        --second-input-file|j file containing the nb of cases/controls carrying an haplotype
        --output-file|o output_file
        --data-type|t DNA|SNP
        --data-qual|q qualitative|quantitative
        --outgroup outgroup_name
        --remove-outgroup 
        --tree-building-program|p phylip|paup|paml
        --splitmode|s nosplit|chi2split
        --no-prolongation
        --chi2-threshold|n value
        --permutations|r number
        --number-of-trees-to-analyse number
        --tree-to-analyse number
        --s-site-number number
        --s-site-characters ancestral state -> derived state
        --co-evo|e simple|double
        --print-tree 
        --anc-seq ancestral sequence (only with phylip)
        --nb-files number of input files to analyse (only for association test)

Options:
    --version
            Print the program version and exits.

    --short-help
            Print a brief help message and exits.

    --help  Print a help message with options descriptions and exits.

    --man   Prints the manual page and exits.

    --association|a
            Perform the association test

    --s-localisation|l
            Localise the susceptibility locus using the "S-character method"

    --first-input-file|i result_file
            Input file 1 (paup, phylip or paml results file). If several
            input files are analysed, their names must be separated by
            colons. Example: input1:input2 etc

    --second-input-file|j correspond_file
            Input file 2, default correspond.txt. The number of input file 2
            must be the same as the number of input file 1. The name of the
            different input file 2 must be separated by colons

    --output-file|o outfile
            Output file

    --data-type|t "DNA"|"SNP"
            Type of data: DNA (ATGCU) or SNP (0-1)

    --data-qual|q "qualitative"|"quantitative"
            Analyse qualitative (case/control) or quantitative data

    --outgroup outgroup
            Root the tree with this outgroup

    --remove-outgroup
            Remove the outgroup of the tree before performing the tests

    --tree-building-program|p "phylip"|"paup"|"paml"
            Phylogeny reconstruction program

    --splitmode|s "nosplit"|"chi2split"
            how tests are performed from a level to another

    --no-prolongation
            No prolongation of branches in the tree

    --chi2-threshold|n value
            Significance threshold for chi2 (default value 0.01)

    --permutations|r number
            Number of permutations used to calculate exact p_values (Only
            for association test)

    --number-of-trees-to-analyse number
            Number of trees to analyse in the localisation analysis (only
            for localisation method using S-character)

    --tree-to-analyse number
            With this option, you can specify the tree to use (instead of
            random). Can be used several times to specify multiple trees.

    --s-site-number number
            Number of the S character site in the sequence (only for
            localisation method using S-character)

    --s-site-characters transition
            Character states for the S character: ancestral state -> derived
            state ex: G->C or 0->1 (only for localisation method using
            S-character)

    --co-evo|e "simple"|"double"
            Type of co-evolution indice simple: only the anc -> der
            transition of S is used double: the two possible transitions are
            used

    --print-tree
            If this option is selected, the tree will be printed to the
            output

    --anc-seq anc_seq
            With this option, you can specify the ancestral sequence. This
            option is only useful when the tree is reconstructed using the
            mix program of phylip with the ancestral states specified in the
            file "ancestors"

    --nb-files number
            With this option, you specify the number of input files (1 and
            2) to analyse This option only works for the association test.
            Be careful if the number of trees is not the same for the
            different input files: if the chosen tree doesn't exist in one
            file, the program wil not work correctly
```


## Metadata
- **Skill**: not generated
