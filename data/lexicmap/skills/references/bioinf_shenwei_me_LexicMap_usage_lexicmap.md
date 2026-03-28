[Skip to main content](#main-content)

[ ]
[ ]

Open Navigation

Close Navigation

[![](/LexicMap/logo.svg)
LexicMap: efficient sequence alignment against millions of prokaryotic genomes​](https://bioinf.shenwei.me/LexicMap/)

[GitHub](https://github.com/shenwei356/LexicMap)

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

[Back to homepage](https://bioinf.shenwei.me/LexicMap/)

Close Menu Bar

Open Menu Bar

## Navigation

* [ ]

  [Introduction](/LexicMap/introduction/)
* [ ]

  [Installation](/LexicMap/installation/)
* [ ]

  [Releases](/LexicMap/releases/)
* [ ]

  Tutorials
  + [ ]

    [Step 1. Building a database](/LexicMap/tutorials/index/)
  + [ ]

    [Step 2. Searching](/LexicMap/tutorials/search/)
  + [ ]

    More

    - [ ]

      [Indexing GTDB](/LexicMap/tutorials/misc/index-gtdb/)
    - [ ]

      [Indexing GenBank+RefSeq](/LexicMap/tutorials/misc/index-genbank/)
    - [ ]

      [Indexing AllTheBacteria](/LexicMap/tutorials/misc/index-allthebacteria/)
    - [ ]

      [Indexing GlobDB](/LexicMap/tutorials/misc/index-globdb/)
    - [ ]

      [Indexing UHGG](/LexicMap/tutorials/misc/index-uhgg/)
* [ ]

  Usage
  + [ ]

    [lexicmap](/LexicMap/usage/lexicmap/)
  + [ ]

    [index](/LexicMap/usage/index/)
  + [ ]

    [search](/LexicMap/usage/search/)
  + [ ]

    [utils](/LexicMap/usage/utils/)

    - [ ]

      [2blast](/LexicMap/usage/utils/2blast/)
    - [ ]

      [2sam](/LexicMap/usage/utils/2sam/)
    - [ ]

      [merge-search-results](/LexicMap/usage/utils/merge-search-results/)
    - [ ]

      [masks](/LexicMap/usage/utils/masks/)
    - [ ]

      [kmers](/LexicMap/usage/utils/kmers/)
    - [ ]

      [genomes](/LexicMap/usage/utils/genomes/)
    - [ ]

      [subseq](/LexicMap/usage/utils/subseq/)
    - [ ]

      [seed-pos](/LexicMap/usage/utils/seed-pos/)
    - [ ]

      [reindex-seeds](/LexicMap/usage/utils/reindex-seeds/)
    - [ ]

      [remerge](/LexicMap/usage/utils/remerge/)
    - [ ]

      [edit-genome-ids](/LexicMap/usage/utils/edit-genome-ids/)
* [ ]

  [FAQs](/LexicMap/faqs/)
* [ ]

  Notes
  + [ ]

    [Motivation](/LexicMap/notes/motivation/)

## More

* [ ]

  [More tools](https://github.com/shenwei356)

2. /
3. [Usage](/LexicMap/usage/)
4. /
5. lexicmap

# lexicmap

```
$ lexicmap -h

   LexicMap: efficient sequence alignment against millions of prokaryotic genomes

    Version: v0.9.0
  Documents: https://bioinf.shenwei.me/LexicMap
Source code: https://github.com/shenwei356/LexicMap
Please cite: https://doi.org/10.1038/s41587-025-02812-8 Nature Biotechnology (2025)

Usage:
  lexicmap [command]

Available Commands:
  autocompletion Generate shell autocompletion scripts
  index          Generate an index from FASTA/Q sequences
  search         Search sequences against an index
  utils          Some utilities
  version        Print version information and check for update

Flags:
  -h, --help                 help for lexicmap
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 16)

Use "lexicmap [command] --help" for more information about a command.
```

[*gdoc\_arrow\_left\_alt*
Indexing UHGG](/LexicMap/tutorials/misc/index-uhgg/ "Indexing UHGG")

[index
*gdoc\_arrow\_right\_alt*](/LexicMap/usage/index/ "index")

Built with [Hugo](https://gohugo.io/) and

Back to top