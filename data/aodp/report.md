# aodp CWL Generation Report

## aodp

### Tool Description
Automated Oligonucleotide Design Pipeline generates oligonucleotide signatures for sequences in FASTA format and for all groups in a phylogeny in the Newick tree format.

### Metadata
- **Docker Image**: quay.io/biocontainers/aodp:2.5.0.2--pl5321h9f5acd7_1
- **Homepage**: https://github.com/peterk87/aodp
- **Package**: https://anaconda.org/channels/bioconda/packages/aodp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aodp/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/peterk87/aodp
- **Stars**: N/A
### Original Help Text
```text
NAME
     aodp - Automated Oligonucleotide Design Pipeline version "2.5.0.2"

SYNOPSIS
    aodp [*options*] *output* *fasta-sequence-file...*

DESCRIPTION
    "aodp" generates oligonucleotide signatures for sequences in FASTA
    format and for all groups in a phylogeny in the Newick tree format.

INPUT
    Multiple input sequence files in the FASTA format can be specified
    anywhere on the command line. The usual file name wildcards can be used.
    Any command line argument without the prefix "--" will be treated as a
    file name.

    Each FASTA file can contain multiple sequences. Sequence identifiers are
    read from the FASTA description lines (lines starting with "">).
    Everything on the description line following a space is ignored.

    Multiple occurrences of sequences with the same identifier are
    considered as the same sequence, with several discountiguous sections.

    If any of the specified *fasta-sequence-file*-s cannot be open or
    completely parsed, aodp will terminate with an error.

OUTPUT
    At least one output option is required. For each output option, if
    file-name is not specified, the result is written to standard output.

    --strings[=file-name]
        Writes all oligo strings grouped by sequence or group

    --positions[=file-name]
        Output for Array Designer (tab-separated list of oligo sites)

    --ranges[=file-name]
        All ranges of sites of oligos grouped by sequence or group

    --fasta[=file-name]
        All oligos in FASTA format

    --gff[=file-name]
        All oligos in GFF format

    --newick[=file-name]
        Writes a phylogeny (Newick tree format), with exactly the same
        structure as the input tree, with generated labels for internal
        nodes.

        Requires a --tree-file input

    --node-list[=file-name]
        List of sequences for every internal node in the phylogeny

        Requires a --tree-file input

    --lineage[=file-name]
        Lineage of every sequence in the phylogeny

        Requires a --tree-file input

    --fold[=file-name]
        Predicted secondary structure and calculated two-state melting
        temperature for all oligonucleotide signature candidates discarded
        because of higher melting temperature than --max-melting

        If the option --max-melting is not specified, will print the
        predicted secondary structure for all oligonucleotide candidates.
        Melting temperatures below 0C or over 100C will be indicated as "*".

    --cladogram=(file-name)
        printout in the eps format of a cladogram associated with the
        annotated phylogeny tree. All nodes with identified oligos are
        marked with a "*" and these nodes and their descendents are coloured
        red.

        Requires a --tree-file option and a file-name

    --time[=file-name]
        Tab-separated "user", "system", "elapsed" time and maximum memory
        usage for various phases of processing

    --basename=(name)
        All oligos in the following formats:

        * "name.oligo.strings" strings grouped by sequence and/or group

        * "name.oligo.fasta" FASTA

        * "name.oligo.gff" GFF

        * "name.oligo.tab" tab-separated

        * "name.oligo.positions" positions

        * "name.oligo.ranges" ranges

        If the option --tree-file is specified (phylogeny tree), the
        following output files will also be generated:

        * "name.newick" phylogeny tree with labeled internal nodes

        * "name.node-list" list of sequences for every internal node

        * "name.lineage" lineage of every sequence in the phylogeny

        * "name.cladogram.eps" cladogram associated with the annotated
          phylogeny tree

        The output options --strings, --fasta, --gff, --tab, --positions,
        --ranges --newick, --node-list, --lineage and --cladogram are
        incompatible with --basename.

    --cluster-list[=file-name]
        Generates the list of clusters: groupings of sequences that can be
        identified by at least one oligonucleotide signature (cluster
        oligonucleotide signature).

        The output contains the following tab-separated columns:

        * Numeric identifier of the cluster. This is a generated value.

        * Space-separated list of all identifiers of sequences contained in
          the cluster

        * If the cluster matches exactly a target node (leaf node or
          internal phylogeny node), an additional column with the name of
          this node is included

    --cluster-oligos[=file-name]
        Generates the list of all oligonucleotide signatures for all
        clusters identified. The output contains the following tab-separated
        columns:

        * Numeric identifier of the cluster. This matches the value in
          --cluster-list.

        * String representation of the cluster oligonucleotide signature

    --clusters=(name)
        Generates a file of cluster nodes ("name.cluster-list") and a file
        of cluster oligonucleotide signatures ("name.cluster-oligos")

        The output options --cluster-list and --cluster-oligos are
        incompatible with --clusters.

    --match=(target-FASTA-file)
        Finds the closest matching source sequence for each sequence from
        the target-FASTA-file. Works as follows:

        * Build the smallest set of sequences ("minimum-set") that can
          explain the largest portion of each target sequence based on
          matching cluster oligonucleotide signatures.

        * Align (using a modified Needleman-Wunsch global alignment
          algorithm) each sequence in the "minimum-set" with the target
          sequence and calculate the percentage similarity. Multiple source
          sequences may have the same percentage similarity with the target
          sequence.

        For each source sequence with maximum percentage similarity to the
        target sequence, prints to standard output or to the file specified
        by --match-output the following tab-delimited fields:

        * Target sequence identifier

        * Source sequence identifier or - if no matching source sequence was
          found

        * Percentage similarity

        * Length (bp) of the portion of the target sequence that matches
          perfectly the source sequence

        * Length of the target sequence

        * Size of the "minimum-set" (affects the running time)

        * Size of the "maximum-set" of sequences contained in any clusters
          matched by the target sequence

        Suggestion: --max-homolo=0 must be specified, otherwise matches
        containing homopolymers will be ignored and the match percentage
        will be lowered

    --match-output=(output-file)
        Redirect the output from --match to the output file

        Requires a --match input

OPTIONS
    Other command line parameters are optional.

    --help
        Display this command summary then exit.

    --version
        Display version and copyright information

    --oligo-size=(size[-size])
        Look for oligonucleotide signatures of sizes within the specified
        range

    --tree-file=(relative-file-name)
        Use the phylogeny file in the Newick tree format that groups the
        sequences in the input; oligos will also be sought for all nodes in
        the phylogeny

    --outgroup-file=(relative-file-name)
        The outgroup list is a case-sensitive list of species (sequence
        names) that are to be excluded from the final output. They will
        still be used in the generation of oligos, but oligos specific to
        them will be omitted.

        Will terminate with an error if a sequence name in the
        --outgroup-file is not found in any *fasta-sequence-file*.

    --isolation-file=(relative-file-name)
        A list of taxa or sequences to isolate (one item per line).
        Sequences whose name match (case-sensitive) as a complete substring
        any of the items in the --isolation-file will be the targets of the
        oligo search. Only oligos for sequences that match items on the list
        or nodes that have sequences that match items on the list will be
        sought. Individual entries in the --isolation-file may match more
        than one sequence. For example, "carotovorum" will match the
        following sequences:

        * "Pectobacterium_carotovorum_actinidae"

        * "Pectobacterium_carotovorum_brasiliense"

        Will terminate with an error if an item in the --isolation-file does
        not match any sequence in any *fasta-sequence-file*.

    --database=(file)
        Validate the resulting oligos against a reference database in the
        FASTA format. This option requires specifying a corresponding
        --taxonomy option.

        Will terminate with an error if the database file contains sequence
        names that are not specified in the taxonomy file.

        Requires a --taxonomy input.

    --taxonomy=(file)
        Taxonomy information associated with the sequences in the reference
        database. Each line has tab-separated sequence name and lineage,
        ending in species name ("s__Genus_species_...").

        The species name (Genus species) of all input sequences encoded as
        "XX_9999_Genus_species_..." will be extracted. Oligos for input
        sequences that don't match any sequence or match only sequences in
        the reference database for the same species will be kept
        (super-specific oligos); sequence oligos that match reference
        sequences with no species name or with another species name will be
        discarded.

        Oligos for internal nodes (group oligos) that match reference
        sequences with a species name other than any of the species names in
        the group (from the input sequences) will also be discarded.

        Requires a --database input.

    --ignore-SNP
        Single polymorphism sites (SNP) will be ignored in the design of
        oligos. --ignore-SNP will generate less oligos in more time

    --reverse-complement
        Will take into account the reverse complement of all sequences
        (default=no):

        * SO will also be generated for the reverse complement of each
          sequence

        * All generated SO will be validated against all direct and reverse
          complement of all sequences

    --crowded=(yes/no)
        Indicates whether for the --ranges and --positions outputs an oligo
        range is populated with intermediary sites (default "no")

              |<--range with signature oligos-->|
      
                        middle of range
         =====|================|================|=====  nucleotide sequence

              *                *                *       --crowded=no
              * *    *    *    *    *    *    * *       --crowded=yes>
               |                      |
         --first-site-gap    --inter-site-gap

    --first-site-gap=(gap-size)
        For a --crowded display, the size of the gap between the border of
        the range and the first interior site (default 5)

    --inter-site-gap=(gap-size)
        For a --crowded display, indicates the size of the gap between sites
        inside an oligo range (default 5).

        This parameter cannot be set to 0.

    --ambiguous-sources=(yes/no)
        Whether sequences containing ambiguities are considered in the
        analysis. The names of these sequences will be written to a file
        called excluded.fasta in the current directory; default "yes"

    --threads=(count)
        The maximum number of threads for multiprocessor systems. By
        default, aodp will detect the number of available processors/cores
        ("n") and will use "n-1" threads, or one thread on single processor
        systems.

    --max-ambiguities=(count)
        Indicates the maximum number of ambiguous bases (default 5).
        Sequences with more than this number of ambiguous bases will not be
        included in further processing. Their names will be written to a
        file called excluded.fasta in the current directory. If this
        parameter is not specified, no sequences will be filtered out based
        on the number of their ambiguous bases.

    --max-crowded-ambiguities=(count)
        Indicates the maximum number of ambiguous bases within an oligo
        size. Sequences with more than this number of ambiguous bases
        anywhere within a window will not be included in further pro
        cessing. Their names will be written to a file called excluded.fasta
        in the current directory. If this parameter is not specified, no
        sequences will be filtered out based on the number of their
        ambiguous bases.

    --ambiguous-oligos=(yes/no)
        Whether oligos containing ambiguous bases will be sought in the
        analysis; default "no"

    --max-homolo=(size)
        Maximum length of a homopolymer (e.g. only "A"s) in any oligo;
        default 4; 0 means no oligos with homopolymers will be removed

    --max-melting=(temperature-C)
        Maximum melting temperature (Celsius) for any discovered oligo.
        Oligos with higher melting temperature will be removed from the
        result. If this option is not specified, all oligos are reported.

        The two-state melting temperature is calculated using the NN model
        (SantaLucia and Hicks 2004), applied to the most stable
        single-strand self-folding configuration at temperature
        --max-melting.

          ----------------------------------------------
         | Tm = DH x ( DS + R x ln ( CT / x )) + 273.15 |
          ----------------------------------------------
               (SantaLucia and Hicks 2004; eq. 3)

        Use --salt to specify the salt (NaCl) concentration and --strand to
        specify the strand concentration (CT). In melting temperature
        calculations for oligonucleotide signatures, x is always 1.

        Since a given strand may have a number of competing self-folding
        configurations, the actual melting temperature will be consistently
        lower for multi-state coupled equlibria than the calculated
        two-state melting temperature.

        The options --max-melting and --ambiguous-oligos=yes are
        incompatible.

    --salt=(Na+ concentration in M)
        Na+ concentration (default "1M"). Valid values are between "0.05M"
        and "1.1M"

        The Na+ concentration is used in entropy calculations:

          -----------------------------------------------
         | DS[Na+] = DS[1M NaCl] x 0.368 x N/2 x ln[Na+] |
          -----------------------------------------------
               (SantaLucia and Hicks 2004; eq. 5)

        "N" is the total number of phosphates in the folded configuration.
        For self-folding configurations, "N" is the strand length in
        nucleotides minus 1.

    --strand=(single strand concentration in "mM")
        strand concentration (default 0.1) in mM used in (SantaLucia and
        Hicks 2004; eq. 3). Valid values are between 0.01 and 100.

        In melting temperature calculations for oligonucleotide signatures,
        x is ALWAYS 1.

EXAMPLES
    By default, output from "aodp" is directed to the standard console:

                 output type
                  =======
         $ aodp --strings Anisogramma.fasta
                          =================
                           input database

    Wildcards are supported for the files in the input database:

         $ aodp --strings fasta/*

    By specifying a phylogeny tree in the Newick format, oligonucleotide
    signatures will also be sought for internal nodes of the phylogeny:

         $ aodp --strings --tree-file=Anisogramma.tre Anisogramma.fasta
                                      ===============
                           phylogeny tree for input database

    A number of output types (in separate files with the same prefix) will
    be automatically generated by using the option "--basename":

                           output file prefix
                           ==================
         $ aodp --basename=Anisogramma.output Anisogramma.fasta

    The target oligonucleotide signature length (in base pairs) can be
    specified as a number:

         $ aodp --strings --oligo-size=32 Anisogramma.fasta

    ...or as a range:

         $ aodp --strings --oligo-size=24-32 Anisogramma.fasta

    Oligonucleotide signatures containing ambiguous base pairs can be
    sought:

         $ aodp --strings --ambiguous-oligos=yes Anisogramma.fasta

    Sequences with ambiguities in the input database can be filtered out
    using the options --ambiguous-sources, --max-ambiguities and
    --max-crowded-ambiguities:

         $ aodp --strings --max-crowded-ambiguities=8 Anisogramma.fasta

    Specific sequences or groups of sequences can be excluded from the
    output using an *outgroup* file:

         $ aodp --strings --outgroup-file=A.outgroup Anisogramma.fasta

    The output can be restricted to only sequences specified within an
    *isolation* file:

         $ aodp --strings --isolation-file=A.iso Anisogramma.fasta

    The output can be filtered for maximum melting temperature (Celsius):

         $ aodp --strings --oligo-size=48 --max-melting=45 Anisogramma.fasta

    Additional parametes (strand concentration in mM and salt concentration
    in M) for the calculation of the melting temperature can be included:

         $ aodp --strings --oligo-size=48 --max-melting=45 Anisogramma.fasta
                --salt=0.1 --strand=2

    Actual melting temperature and folding configuration for the resulting
    oligonucleotide signatures can be displayed:

         $ aodp --strings --oligo-size=48 --max-melting=45 Anisogramma.fasta
                --fold --salt=0.1 --strand=2

    The output of "aodp" can be cross-referenced against a reference
    database, by using the --taxonomy and --database options:

         $ aodp --tree-file=Anisogramma.tre Anisogramma.fasta
                --database=UNITE_public_mothur_full_10.09.2014
                --taxonomy=UNITE_public_mothur_full_10.09.2014_taxonomy.txt

SEE ALSO
    clado
      generates an eps file from a phylogeny tree file in a Newick format.
      Nodes that have names ending in "*" are colored red.

    clus
      interprets the results of matches of experimental samples against
      cluster oligo signatures generated by "aodp"

    DNA thermodynamics
      SantaLucia J Jr, Hicks D. 2004. The Thermodynamics of DNA Structural
      Motifs. Annu. Rev. Biophys. 33:415-40

COPYRIGHT
    This file is part of "aodp" (the Automated Oligonucleotide Design
    Pipeline)

     (C) HER MAJESTY THE QUEEN IN RIGHT OF CANADA (2014-2018)
     (C) Manuel Zahariev mz@alumni.sfu.ca (2000-2008,2014-2018)

    "aodp" is free software: you can redistribute it and/or modify it under
    the terms of version 3 of the GNU General Public License as published by
    the Free Software Foundation.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
    Public License (version 3) for more details.

    You should have received a copy of the GNU General Public License
    (version 3) along with this program. If not, see
    http://www.gnu.org/licenses/.

AUTHORS
    Manuel Zahariev (mz@alumni.sfu.ca) Wen Chen (wen.chen@agr.gc.ca)
```


## Metadata
- **Skill**: not generated
