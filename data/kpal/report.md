# kpal CWL Generation Report

## kpal_convert

### Tool Description
Save k-mer profiles from files in the old plaintext format (used by kPAL versions < 1.0.0) to a k-mer profile file in the current HDF5 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kpal/overview
- **Total Downloads**: 12.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LUMC/kPAL
- **Stars**: N/A
### Original Help Text
```text
usage: kpal convert [-h] [-p NAME [NAME ...]] [INPUT [INPUT ...]] OUTPUT

Save k-mer profiles from files in the old plaintext format (used by kPAL
versions < 1.0.0) to a k-mer profile file in the current HDF5 format.

positional arguments:
  INPUT                 input file (default: stdin)
  OUTPUT                output k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names for the saved k-mer profiles, one per INPUT
                        (default: profiles are named according to the input
                        filenames, or numbered consecutively from 1 if no
                        filenames are available)
```


## kpal_cat

### Tool Description
Save k-mer profiles from several files to one k-mer profile file.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal cat [-h] [-p NAME [NAME ...]] [-x PREFIX [PREFIX ...]]
                INPUT [INPUT ...] OUTPUT

Save k-mer profiles from several files to one k-mer profile file.

positional arguments:
  INPUT                 input k-mer profile file
  OUTPUT                output k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles per INPUT, in alphabetical order)
  -x PREFIX [PREFIX ...], --prefixes PREFIX [PREFIX ...]
                        prefixes to use for the saved k-mer profile names, one
                        per INPUT (default: profile names are assumed to be
                        disjoint and no prefix is used)
```


## kpal_count

### Tool Description
Make k-mer profiles from FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal count [-h] [-p NAME [NAME ...]] [-k SIZE] [--by-record]
                  [INPUT [INPUT ...]] OUTPUT

Make k-mer profiles from FASTA files.

positional arguments:
  INPUT                 input file (default: stdin)
  OUTPUT                output k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names for the created k-mer profiles, one per INPUT
                        (default: profiles are named according to the input
                        filenames, or numbered consecutively from 1 if no
                        filenames are available)
  -k SIZE               k-mer size (int default: 9)
  --by-record, -r       make a k-mer profile per FASTA record instead of a
                        k-mer profile per FASTA file (profiles are named by
                        the record names and prefixed according to --profiles
                        if more than one INPUT is given)
```


## kpal_merge

### Tool Description
Merge k-mer profiles. If the files contain more than one profile, they are linked by name and merged pairwise. The resulting profile name is set to that of the original profiles if they match, or to their concatenation otherwise.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal merge [-h] [-l NAME [NAME ...]] [-r NAME [NAME ...]]
                  [-m {int,sum,xor,nint}] [-c STRING]
                  INPUT_LEFT INPUT_RIGHT OUTPUT

Merge k-mer profiles. If the files contain more than one profile, they are
linked by name and merged pairwise. The resulting profile name is set to that
of the original profiles if they match, or to their concatenation otherwise.

positional arguments:
  INPUT_LEFT            input k-mer profile file (left)
  INPUT_RIGHT           input k-mer profile file (right)
  OUTPUT                output k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -l NAME [NAME ...], --profiles-left NAME [NAME ...]
                        names of the k-mer profiles to consider (left)
                        (default: all profiles in INPUT_LEFT, in alphabetical
                        order
  -r NAME [NAME ...], --profiles-right NAME [NAME ...]
                        names of the k-mer profiles to consider (right)
                        (default: all profiles in INPUT_RIGHT, in alphabetical
                        order)
  -m {int,sum,xor,nint}
                        merge function (default: sum)
  -c STRING, --custom-merger STRING
                        custom Python merge function, specified either by an
                        expression over the two NumPy ndarrays "left" and
                        "right" (e.g., "np.add(left, right)"), or an
                        importable name (e.g., "package.module.merge") that
                        can be called with two ndarrays as arguments
```


## kpal_balance

### Tool Description
Balance k-mer profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal balance [-h] [-p NAME [NAME ...]] INPUT OUTPUT

Balance k-mer profiles.

positional arguments:
  INPUT                 input k-mer profile file
  OUTPUT                output k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
```


## kpal_showbalance

### Tool Description
Show the balance of k-mer profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal showbalance [-h] [-p NAME [NAME ...]] [-n INT] INPUT

Show the balance of k-mer profiles.

positional arguments:
  INPUT                 input k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
  -n INT                precision in number of decimals (default: 10)
```


## kpal_stats

### Tool Description
Show the mean and standard deviation of k-mer profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal stats [-h] [-p NAME [NAME ...]] [-n INT] INPUT

Show the mean and standard deviation of k-mer profiles.

positional arguments:
  INPUT                 input k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
  -n INT                precision in number of decimals (default: 10)
```


## kpal_distr

### Tool Description
Calculate the distribution of the values in k-mer profiles. Every output line
has the name of the profile, the count and the number of k-mers with this
count.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal distr [-h] [-p NAME [NAME ...]] INPUT OUTPUT

Calculate the distribution of the values in k-mer profiles. Every output line
has the name of the profile, the count and the number of k-mers with this
count.

positional arguments:
  INPUT                 input k-mer profile file
  OUTPUT                output file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
```


## kpal_info

### Tool Description
Print some information about k-mer profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal info [-h] [-p NAME [NAME ...]] INPUT

Print some information about k-mer profiles.

positional arguments:
  INPUT                 input k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
```


## kpal_getcount

### Tool Description
Retrieve the counts in k-mer profiles for a particular word.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal getcount [-h] [-p NAME [NAME ...]] INPUT WORD

Retrieve the counts in k-mer profiles for a particular word.

positional arguments:
  INPUT                 input k-mer profile file
  WORD                  the word in question

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
```


## kpal_positive

### Tool Description
Only keep counts that are positive in both k-mer profiles. If the files contain more than one profile, they are linked by name and processed pairwise.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal positive [-h] [-l NAME [NAME ...]] [-r NAME [NAME ...]]
                     INPUT_LEFT INPUT_RIGHT OUTPUT_LEFT OUTPUT_RIGHT

Only keep counts that are positive in both k-mer profiles. If the files
contain more than one profile, they are linked by name and processed pairwise.

positional arguments:
  INPUT_LEFT            input k-mer profile file (left)
  INPUT_RIGHT           input k-mer profile file (right)
  OUTPUT_LEFT           output k-mer profile file (left)
  OUTPUT_RIGHT          output k-mer profile file (right)

optional arguments:
  -h, --help            show this help message and exit
  -l NAME [NAME ...], --profiles-left NAME [NAME ...]
                        names of the k-mer profiles to consider (left)
                        (default: all profiles in INPUT_LEFT, in alphabetical
                        order
  -r NAME [NAME ...], --profiles-right NAME [NAME ...]
                        names of the k-mer profiles to consider (right)
                        (default: all profiles in INPUT_RIGHT, in alphabetical
                        order)
```


## kpal_scale

### Tool Description
Scale two profiles such that the total number of k-mers is equal. If the files contain more than one profile, they are linked by name and processed pairwise.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal scale [-h] [-l NAME [NAME ...]] [-r NAME [NAME ...]] [-d]
                  INPUT_LEFT INPUT_RIGHT OUTPUT_LEFT OUTPUT_RIGHT

Scale two profiles such that the total number of k-mers is equal. If the files
contain more than one profile, they are linked by name and processed pairwise.

positional arguments:
  INPUT_LEFT            input k-mer profile file (left)
  INPUT_RIGHT           input k-mer profile file (right)
  OUTPUT_LEFT           output k-mer profile file (left)
  OUTPUT_RIGHT          output k-mer profile file (right)

optional arguments:
  -h, --help            show this help message and exit
  -l NAME [NAME ...], --profiles-left NAME [NAME ...]
                        names of the k-mer profiles to consider (left)
                        (default: all profiles in INPUT_LEFT, in alphabetical
                        order
  -r NAME [NAME ...], --profiles-right NAME [NAME ...]
                        names of the k-mer profiles to consider (right)
                        (default: all profiles in INPUT_RIGHT, in alphabetical
                        order)
  -d                    scale down
```


## kpal_shrink

### Tool Description
Shrink k-mer profiles, effectively reducing k.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal shrink [-h] [-p NAME [NAME ...]] [-f INT] INPUT OUTPUT

Shrink k-mer profiles, effectively reducing k.

positional arguments:
  INPUT                 input k-mer profile file
  OUTPUT                output k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
  -f INT, --factor INT  shrinking factor (default: 1)
```


## kpal_shuffle

### Tool Description
Randomise k-mer profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal shuffle [-h] [-p NAME [NAME ...]] INPUT OUTPUT

Randomise k-mer profiles.

positional arguments:
  INPUT                 input k-mer profile file
  OUTPUT                output k-mer profile file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
```


## kpal_smooth

### Tool Description
Smooth two profiles by collapsing sub-profiles. If the files contain more than one profile, they are linked by name and processed pairwise.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal smooth [-h] [-l NAME [NAME ...]] [-r NAME [NAME ...]]
                   [-s {average,median,min}] [-M STRING] [-t INT]
                   INPUT_LEFT INPUT_RIGHT OUTPUT_LEFT OUTPUT_RIGHT

Smooth two profiles by collapsing sub-profiles. If the files contain more than
one profile, they are linked by name and processed pairwise.

positional arguments:
  INPUT_LEFT            input k-mer profile file (left)
  INPUT_RIGHT           input k-mer profile file (right)
  OUTPUT_LEFT           output k-mer profile file (left)
  OUTPUT_RIGHT          output k-mer profile file (right)

optional arguments:
  -h, --help            show this help message and exit
  -l NAME [NAME ...], --profiles-left NAME [NAME ...]
                        names of the k-mer profiles to consider (left)
                        (default: all profiles in INPUT_LEFT, in alphabetical
                        order
  -r NAME [NAME ...], --profiles-right NAME [NAME ...]
                        names of the k-mer profiles to consider (right)
                        (default: all profiles in INPUT_RIGHT, in alphabetical
                        order)
  -s {average,median,min}
                        summary function for dynamic smoothing (default: min)
  -M STRING, --custom-summary STRING
                        custom Python summary function, specified either by an
                        expression over the NumPy ndarray "values" (e.g.,
                        "np.max(values)"), or an importable name (e.g.,
                        "package.module.summary") that can be called with an
                        ndarray as argument
  -t INT                threshold for the summary function (default: 0)
```


## kpal_distance

### Tool Description
Calculate the distance between two k-mer profiles. If the files contain more than one profile, they are linked by name and processed pairwise.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal distance [-h] [-l NAME [NAME ...]] [-r NAME [NAME ...]] [-d]
                     [-s {average,median,min}] [-M STRING] [-t INT] [-n INT]
                     [-b] [--positive] [-S] [-m]
                     [-D {default,euclidean,cosine}] [-P {sum,prod}]
                     [-f STRING]
                     INPUT_LEFT INPUT_RIGHT

Calculate the distance between two k-mer profiles. If the files contain more
than one profile, they are linked by name and processed pairwise.

positional arguments:
  INPUT_LEFT            input k-mer profile file (left)
  INPUT_RIGHT           input k-mer profile file (right)

optional arguments:
  -h, --help            show this help message and exit
  -l NAME [NAME ...], --profiles-left NAME [NAME ...]
                        names of the k-mer profiles to consider (left)
                        (default: all profiles in INPUT_LEFT, in alphabetical
                        order
  -r NAME [NAME ...], --profiles-right NAME [NAME ...]
                        names of the k-mer profiles to consider (right)
                        (default: all profiles in INPUT_RIGHT, in alphabetical
                        order)
  -d                    scale down
  -s {average,median,min}
                        summary function for dynamic smoothing (default: min)
  -M STRING, --custom-summary STRING
                        custom Python summary function, specified either by an
                        expression over the NumPy ndarray "values" (e.g.,
                        "np.max(values)"), or an importable name (e.g.,
                        "package.module.summary") that can be called with an
                        ndarray as argument
  -t INT                threshold for the summary function (default: 0)
  -n INT                precision in number of decimals (default: 10)
  -b, --balance         balance the profiles
  --positive            use only positive values
  -S, --scale           scale the profiles
  -m, --smooth          smooth the profiles
  -D {default,euclidean,cosine}
                        choose distance function (default: default)
  -P {sum,prod}         paiwise distance function for the multiset distance
                        (default: prod)
  -f STRING, --pairwise-function STRING
                        custom Python pairwise function, specified either by
                        an expression over the two NumPy ndarrays "left" and
                        "right" (e.g., "abs(left - right) / (left + right +
                        1)"), or an importable name (e.g.,
                        "package.module.pairwise") that can be called with two
                        ndarrays as arguments
```


## kpal_matrix

### Tool Description
Make a distance matrix between any number of k-mer profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/kpal:2.1.1--py27_0
- **Homepage**: https://github.com/LUMC/kPAL
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: kpal matrix [-h] [-p NAME [NAME ...]] [-d] [-s {average,median,min}]
                   [-M STRING] [-t INT] [-n INT] [-b] [--positive] [-S] [-m]
                   [-D {default,euclidean,cosine}] [-P {sum,prod}] [-f STRING]
                   INPUT OUTPUT

Make a distance matrix between any number of k-mer profiles.

positional arguments:
  INPUT                 input k-mer profile file
  OUTPUT                output file

optional arguments:
  -h, --help            show this help message and exit
  -p NAME [NAME ...], --profiles NAME [NAME ...]
                        names of the k-mer profiles to consider (default: all
                        profiles in INPUT, in alphabetical order)
  -d                    scale down
  -s {average,median,min}
                        summary function for dynamic smoothing (default: min)
  -M STRING, --custom-summary STRING
                        custom Python summary function, specified either by an
                        expression over the NumPy ndarray "values" (e.g.,
                        "np.max(values)"), or an importable name (e.g.,
                        "package.module.summary") that can be called with an
                        ndarray as argument
  -t INT                threshold for the summary function (default: 0)
  -n INT                precision in number of decimals (default: 10)
  -b, --balance         balance the profiles
  --positive            use only positive values
  -S, --scale           scale the profiles
  -m, --smooth          smooth the profiles
  -D {default,euclidean,cosine}
                        choose distance function (default: default)
  -P {sum,prod}         paiwise distance function for the multiset distance
                        (default: prod)
  -f STRING, --pairwise-function STRING
                        custom Python pairwise function, specified either by
                        an expression over the two NumPy ndarrays "left" and
                        "right" (e.g., "abs(left - right) / (left + right +
                        1)"), or an importable name (e.g.,
                        "package.module.pairwise") that can be called with two
                        ndarrays as arguments
```


## Metadata
- **Skill**: generated
