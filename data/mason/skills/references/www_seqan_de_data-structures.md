[![SeqAn](/assets/images/seqan.svg)](/)

[ ]

[News](/news/)
[Using SeqAn](/getting-started/)
[People](/people/)
[Applications](/apps/)
[Publications](/publications/)
[Contact](/contact/)

🌗

# Data structures

SeqAn has numerous data structures that are helpful for analyzing biological sequences.
Those range from simple containers for strings that can be saved in different ways,
to collection of strings or compressed strings.

The Journaled string tree, for example allows the user to traverse all sequence contexts,
given a window of a certain size, that are present in a set of sequences.

![](/assets/images/overlay/datastructures.png)

A traversal of a JST for a given set of sequences.

Similar sequences are hence only traversed once, and the coordinate bookkeeping is all within the data structure.
This allows for example speedup of up to a 100x given sequences from the 1000 Genome project
and compared to traversing the sequences one after another.

Another strong side of SeqAn are its generic string indices. You can think “suffix tree”
but the implementations range from an enhanced suffix array to (bidirectional) FM-indices.

[Subscribe](/feed.xml)

#### Imprint

[![:de:](https://github.githubassets.com/images/icons/emoji/unicode/1f1e9-1f1ea.png ":de:") Impressum](https://www.fu-berlin.de/redaktion/impressum/index.html)
[![:gb:](https://github.githubassets.com/images/icons/emoji/unicode/1f1ec-1f1e7.png ":gb:") Legal Notice](https://www.fu-berlin.de/en/redaktion/impressum/index.html)

SeqAn is an open source C++ library of efficient algorithms and data structures for the analysis of sequences with the focus on biological data.