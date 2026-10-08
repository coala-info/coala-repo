# meryl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| meryl_analyze | PASS | On Galaxy child.fasta k=7 counts, the -gc histogram matches an independent GC count of all 8192 kmers (1703 bins); -ga writes GA, TC and GA_TC histograms. |
| meryl_count | PASS | On Galaxy tools-iuc child.fasta k=7, the histogram matches the Galaxy expected output exactly. |
| meryl_count-forward | PASS | On Galaxy tools-iuc child.fasta k=7, forward 7-mer counts match an independent count and sum to the canonical counts. |
| meryl_count-reverse | PASS | On Galaxy tools-iuc child.fasta k=7, counts equal the forward counts of the reverse complements. |
| meryl_decrease | PASS | Output counts match the expected arithmetic on the Galaxy child.fasta 7-mer counts. |
| meryl_difference | PASS | Output matches a Python set computation on Galaxy child.fasta 7-mer databases (7447 kmers). |
| meryl_divide | PASS | Output counts match the expected arithmetic on the Galaxy child.fasta 7-mer counts. |
| meryl_divide-round | PASS | Output counts match the expected arithmetic on the Galaxy child.fasta 7-mer counts. |
| meryl_equal-to | PASS | Output kmers and counts match a Python filter of the Galaxy child.fasta 7-mer counts. |
| meryl_greater-than | PASS | Output kmers and counts match a Python filter of the Galaxy child.fasta 7-mer counts. |
| meryl_histogram | PASS | Histogram of the Galaxy read-db.meryldb matches the Galaxy expected output_24 exactly. |
| meryl_import | PASS | Round trip on Galaxy child.fasta k=7 counts: importing the meryl print output gave a database whose print output is identical (8192 kmers). |
| meryl_increase | PASS | Output counts match the expected arithmetic on the Galaxy child.fasta 7-mer counts. |
| meryl_intersect | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_intersect-max | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_intersect-min | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_intersect-sum | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_less-than | PASS | Output kmers and counts match a Python filter of the Galaxy child.fasta 7-mer counts. |
| meryl_lookup | PASS | Galaxy tools-iuc maternal.fasta reads against a sparse 7-mer database: -existence, -bed, -wig-count, -include and -exclude all match an independent Python check. |
| meryl_modulo | PASS | Output counts match the expected arithmetic on the Galaxy child.fasta 7-mer counts. |
| meryl_multiply | PASS | Output counts match the expected arithmetic on the Galaxy child.fasta 7-mer counts. |
| meryl_not-equal-to | PASS | Output kmers and counts match a Python filter of the Galaxy child.fasta 7-mer counts. |
| meryl_print | PASS | Prints all 8192 canonical 7-mers with counts identical for the CWL-built and Galaxy databases. |
| meryl_simple | Failed | tool bug: -M is accepted but writes no meryl database (the code is empty); the text dump and histogram on Galaxy child.fasta k=7 are correct. |
| meryl_statistics | PASS | Reports 8192 distinct and 1041448 total 7-mers for Galaxy child.fasta, matching the print output. |
| meryl_subtract | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_symmetric-difference | PASS | Output matches a Python set computation on Galaxy child.fasta 7-mer databases (6341 kmers). |
| meryl_union | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_union-max | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_union-min | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |
| meryl_union-sum | PASS | On Galaxy child/maternal/paternal 7-mer databases, output matches a Python set computation. |

## meryl_statistics

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Total Downloads**: 46.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marbl/meryl
- **Stars**: N/A
### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_histogram

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_count

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_count-forward

### Tool Description
Count the occurrences of forward kmers in the input.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_count-reverse

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_less-than

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_greater-than

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_equal-to

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_not-equal-to

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_increase

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_decrease

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_multiply

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_divide

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_divide-round

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_modulo

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_union

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_union-min

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_union-max

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_union-sum

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_intersect

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_intersect-min

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_intersect-max

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_intersect-sum

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_subtract

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_difference

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_symmetric-difference

### Tool Description
A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_print

### Tool Description
Display kmers on the screen as 'kmer<tab>count'; accepts exactly one input meryl database.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl ...

  A meryl command line is formed as a series of commands and files, possibly
  grouped using square brackets.  Each command operates on the file(s) that
  are listed after it.

  COMMANDS:

    statistics           display total, unique, distinct, present number of the kmers on the screen.  accepts exactly one input.
    histogram            display kmer frequency on the screen as 'frequency<tab>count'.  accepts exactly one input.
    print                display kmers on the screen as 'kmer<tab>count'.  accepts exactly one input.

    count                Count the occurrences of canonical kmers in the input.  must have 'output' specified.
    count-forward        Count the occurrences of forward kmers in the input.  must have 'output' specified.
    count-reverse        Count the occurrences of reverse kmers in the input.  must have 'output' specified.
      k=<K>              create mers of size K bases (mandatory).
      n=<N>              expect N mers in the input (optional; for precise memory sizing).
      memory=M           use no more than (about) M GB memory.
      threads=T          use no more than T threads.
      compress           compress homopolymer runs to a single letter.

    less-than N          return kmers that occur fewer than N times in the input.  accepts exactly one input.
    greater-than N       return kmers that occur more than N times in the input.  accepts exactly one input.
    equal-to N           return kmers that occur exactly N times in the input.  accepts exactly one input.
    not-equal-to N       return kmers that do not occur exactly N times in the input.  accepts exactly one input.

    increase X           add X to the count of each kmer.
    decrease X           subtract X from the count of each kmer.
    multiply X           multiply the count of each kmer by X.
    divide X             divide the count of each kmer by X.
    divide-round X       divide the count of each kmer by X and round results. count < X will become 1.
    modulo X             set the count of each kmer to the remainder of the count divided by X.

    union                return kmers that occur in any input, set the count to the number of inputs with this kmer.
    union-min            return kmers that occur in any input, set the count to the minimum count
    union-max            return kmers that occur in any input, set the count to the maximum count
    union-sum            return kmers that occur in any input, set the count to the sum of the counts

    intersect            return kmers that occur in all inputs, set the count to the count in the first input.
    intersect-min        return kmers that occur in all inputs, set the count to the minimum count.
    intersect-max        return kmers that occur in all inputs, set the count to the maximum count.
    intersect-sum        return kmers that occur in all inputs, set the count to the sum of the counts.

    subtract             return kmers that occur in the first input, substracting counts from the other inputs

    difference           return kmers that occur in the first input, but none of the other inputs
    symmetric-difference return kmers that occur in exactly one input

  MODIFIERS:

    output O             write kmers generated by the present command to an output  meryl database O
                         mandatory for count operations.

  EXAMPLES:

  Example:  Report 22-mers present in at least one of input1.fasta and input2.fasta.
            Kmers from each input are saved in meryl databases 'input1' and 'input2',
            but the kmers in the union are only reported to the screen.

            meryl print \
                    union \
                      [count k=22 input1.fasta output input1] \
                      [count k=22 input2.fasta output input2]

  Example:  Find the highest count of each kmer present in both files, save the kmers to
            database 'maxCount'.

            meryl intersect-max input1 input2 output maxCount

  Example:  Find unique kmers common to both files.  Brackets are necessary
            on the first 'equal-to' command to prevent the second 'equal-to' from
            being used as an input to the first 'equal-to'.

            meryl intersect [equal-to 1 input1] equal-to 1 input2

Can't interpret '--help': not a meryl command, option, or recognized input file.
```

## meryl_simple

### Tool Description
Count kmers in a FASTA file with the simple in-memory counter (meryl database, text dump and histogram).

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl-simple -k kmerSize -S input.fasta ...
  -k kmerSize
  -S input.fasta
  -M output.meryl
  -D output.dump
  -H output.histogram

  -m memLimit_in_MB
```

## meryl_import

### Tool Description
Load the kmers and values listed in a text file into a meryl kmer database.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl-import [...] -k <kmer-size> -kmers <input-kmers> -output <db.meryl>
  Loads the kmers and values listed in <input-kmers> into a meryl kmer database.

INPUTS and OUTPUTS
  -kmers <input-kmers>  A file consisting of kmers and values, one per line, separated
                        by white space ('AGTTGCC 4').  Order of kmers is not important.
                        Duplicate kmers will be handled according to the -multiset
                        option.

                        A persistent value can be specified as '#<value>' (e.g., '#3')
                        All kmers with no value after this line will use this value.

  -k <size>             The size of a kmer, in bases.  Setting this larger than the
                        kmers in the input will probably lead to a crash.  Setting it
                        smaller will result in only the left-most bases being used.

  -output <db.meryl>    Create (or overwrite) meryl database 'database.meryl'.

OPTIONS
  -multiset             Write duplicate kmers in the input to the database as individual
                        entries.  A kmer AGTTGCC in the input twice with values 4 and 7
                        will be listed in the output database twice, once with value 4,
                        and once with value 7.  Without this option, the values will be
                        summed: AGTTGCC will be listed once with value 11.

  -maxvalue <value>     An optional memory and time optimization, useful if your values
                        are randomly distributed and below some known maximum value.
                        For data whose values are the counts from actual data, it is
                        probably best to not set this option.

  -forward              By default, the canonical kmer is loaded into the database.  These
  -reverse              options force either the forward or reverse-complement kmer to be
                        loaded instead.  These options are mutually exclusive.

  -threads <t>          Use <t> compute threads when sorting and writing data.

  -memory <m>           (accepted, but not implemented, sorry)

No input kmer file (-kmers) supplied.
No output database name (-output) supplied.
No kmer size (-k) supplied.
```

## meryl_analyze

### Tool Description
Analyze a meryl database: histograms of G and C counts or of GA and TC microsatellite counts per kmer.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl-analyze -mers <meryldb> -prefix <prefix> (-ga | -gc) 

No query meryl database (-mers) supplied.
```

## meryl_lookup

### Tool Description
Compare kmers in input sequences against meryl databases and report BED, WIGGLE or existence results, or include and exclude sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/meryl:1.4.1--h9948957_2
- **Homepage**: https://github.com/marbl/meryl
- **Package**: https://anaconda.org/channels/bioconda/packages/meryl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: meryl-lookup <report-type> \
         -sequence <input1.fasta> [<input2.fasta>] \
         -output   <output1>      [<output2>] \
         -mers     <input1.meryl> [<input2.meryl>] [...] [-estimate] \
         -labels   <input1name>   [<input2name>]   [...]

  Compare kmers in input sequences against kmers in input meryl databases.

  Input sequences (-sequence) can be FASTA or FASTQ, uncompressed, or
  compressed with gzip, xz, or bzip2.

  To compute and report only estimated memory usage, add option '-estimate'.

  Report types:
    Run `meryl-lookup <report-type> -help` for details on each method.


  -bed:
     Generate a BED format file showing the location of kmers in
     any input database on each sequence in 'input1.fasta'.
     Each kmer is reported in a separate bed record.

  -bed-runs:
     Generate a BED format file showing the location of kmers in
     any input database on each sequence in 'input1.fasta'.
     Overlapping kmers are combined into a single bed record.

  -wig-count:
     Generate a WIGGLE format file showing the multiplicity of the
     kmer starting at each position in the sequence, if it exists in
     an input kmer database.

  -wig-depth:
     Generate a WIGGLE format file showing the number of kmers in
     any input database that cover each position in the sequence.

  -existence:
     Generate a tab-delimited line for each input sequence with the
     number of kmers in the sequence, in the database and common to both.

  -include:
  -exclude:
     Copy sequences from 'input1.fasta' (and 'input2.fasta') to the
     corresponding output file if the sequence has at least one kmer
     present (include) or no kmers present (exclude) in 'input1.meryl'.

No report-type (-bed, -wig-count, -wig-depth, -existence, -include, -exclude) supplied.
```

## Metadata
- **Skill**: not generated
