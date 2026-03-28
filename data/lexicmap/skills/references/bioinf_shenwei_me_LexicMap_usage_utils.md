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
  + [x]

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
5. utils

# utils

```
$ lexicmap utils
Some utilities

Usage:
  lexicmap utils [command]

Available Commands:
  2blast               Convert the default search output to blast-style format
  2sam                 Convert the default search output to SAM format
  edit-genome-ids      Edit genome IDs in the index via a regular expression
  genomes              View genome IDs in the index
  kmers                View k-mers captured by the masks
  masks                View masks of the index or generate new masks randomly
  merge-search-results Merge a query's search results from multiple indexes
  reindex-seeds        Recreate indexes of k-mer-value (seeds) data
  remerge              Rerun the merging step for an unfinished index
  seed-pos             Extract and plot seed positions via reference name(s)
  subseq               Extract subsequence via 1) reference name, sequence ID, position and strand, or 2) search result

Flags:
  -h, --help   help for utils

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 16)
```

Subcommands:

* [2blast](2blast/)
* [2sam](2sam/)
* [merge-search-results](merge-search-results/)
* [masks](masks/)
* [kmers](kmers/)
* [genomes](genomes/)
* [subseq](subseq/)
* [seed-pos](seed-pos/)
* [reindex-seeds](reindex-seeds/)
* [remerge](remerge/)
* [edit-genome-ids](edit-genome-ids/)

[*gdoc\_arrow\_left\_alt*
search](/LexicMap/usage/search/ "search")

[2blast
*gdoc\_arrow\_right\_alt*](/LexicMap/usage/utils/2blast/ "2blast")

Built with [Hugo](https://gohugo.io/) and

Back to top