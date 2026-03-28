[ngsderive](../..)

* [Home](../..)
* Subcommands
  + [strandedness](../strandedness/)
  + [instrument](../instrument/)
  + [readlen](./)
  + [encoding](../encoding/)
  + [junction-annotation](../junction_annotation/)

* Search
* [Previous](../instrument/)
* [Next](../encoding/)
* [Edit on GitHub](https://github.com/stjudecloud/ngsderive/edit/master/docs/subcommands/readlen.md)

* [readlen](#readlen)
  + [Algorithm](#algorithm)

# readlen

The `readlen` subcommand can be used to compute the read length used during sequencing can be estimated (or reported as inconclusive).

## Algorithm

At the time of writing, the algorithm used is roughly:

1. Compute distribution of read lengths for the first `--n-reads` reads in a file.
2. Assuming read length in the file can only decrease from the actual read length (from adapter trimming or similar), the putative maximum read length is considered to be the highest detected read length.
3. If the percentage of reads that are evidence for the putative maximum read length makes up at least `--majority-vote-cutoff`% of the reads, the putative read length is considered to be confirmed. If not, the consensus read length will be return as -1 (could not determine).
4. For example, if 100bp is the maximum read length detected and 85% percent of the reads support that claim, then we considered 100bp as the consensus read length. If only 30% of the reads indicated 100bp, the tool cannot report a consensus.

---

© 2020 St. Jude Children's Research Hospital

Documentation built with [MkDocs](https://www.mkdocs.org/).

#### Search

×Close

From here you can search these documents. Enter your search terms below.

#### Keyboard Shortcuts

×Close

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |