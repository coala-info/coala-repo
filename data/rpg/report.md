# rpg CWL Generation Report

## rpg

### Tool Description
This software takes protein sequences as input (-i option). All sequences will be cleaved according to selected enzymes (-e option) and given miscleavage percentage (-m option). Cleaving can be sequential or concurrent (-d option). Resulting peptides are outputted in a file (-o option) in fasta, csv or tsv format (-f option). Classical enzymes are included (-l option to print available enzymes) but it is possible to define other enzymes (-a option). See https://gitlab.pasteur.fr/nmaillet/rpg/ and https://rapid-peptide- generator.readthedocs.io for more informations.

### Metadata
- **Docker Image**: biocontainers/rpg:v1.1.0_cv1
- **Homepage**: https://github.com/jynew/jynew
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rpg/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/jynew/jynew
- **Stars**: N/A
### Original Help Text
```text
usage: rpg [-h] [-a] [-d] [-e  [...]] [-f] [-i] [-l] [-s] [-m  [...]] [-n]
           [-p] [-o  | -r] [-q | -v] [--version]

This software takes protein sequences as input (-i option). All sequences will
be cleaved according to selected enzymes (-e option) and given miscleavage
percentage (-m option). Cleaving can be sequential or concurrent (-d option).
Resulting peptides are outputted in a file (-o option) in fasta, csv or tsv
format (-f option). Classical enzymes are included (-l option to print
available enzymes) but it is possible to define other enzymes (-a option). See
https://gitlab.pasteur.fr/nmaillet/rpg/ and https://rapid-peptide-
generator.readthedocs.io for more informations.

optional arguments:
  -h, --help            show this help message and exit
  -a, --addenzyme       Create a new enzyme. See https://rapid-peptide-
                        generator.readthedocs.io for more informations
  -d , --digest         Digestion mode. Either 's', 'sequential', 'c' or
                        'concurrent' (default: s)
  -e  [ ...], --enzymes  [ ...]
                        Id of enzyme(s) to use (i.e. -e 0 5 10 to use enzymes
                        0, 5 and 10). Use -l first to get enzyme ids
  -f , --fmt            Output file format. Either 'fasta', 'csv', or 'tsv'
                        (default: fasta)
  -i , --inputdata      Input file, in fasta / fastq format
  -l, --list            Display the list of available enzymes
  -s , --sequence       Input a single protein sequence without commentary
  -m  [ ...], --miscleavage  [ ...]
                        Percentage of miscleavage, between 0 and 100, by
                        enzyme(s). It should be in the same order than
                        -enzymes options (i.e. -m 15 5 10). Only for
                        sequential digestion (default: 0)
  -n, --noninteractive  Non-interactive mode. No standard output, only
                        error(s) (--quiet enable, overwrite -v). If output
                        filename already exists, output file will be
                        overwritten.
  -p , --pka            Define pKa values. Either 'ipc' or 'stryer' (default:
                        ipc)
  -o , --outputfile     Optional result file to output result peptides.
  -r, --randomname      Random (not used) output file name
  -q, --quiet           No standard output, only error(s)
  -v, --verbose         Increase output verbosity. -vv will increase more than
                        -v
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated
