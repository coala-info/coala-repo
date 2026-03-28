[![SeqAn](/assets/images/seqan.svg)](/)

[ ]

[News](/news/)
[Using SeqAn](/getting-started/)
[People](/people/)
[Applications](/apps/)
[Publications](/publications/)
[Contact](/contact/)

🌗

# Parallelization

Since the end of 2015, SeqAn is also supported by Intel as part of an Intel Parallel Compute Center.
The goal is to parallelize core components of SeqAn using multiple cores as well as vectorization as much as possible.

![](/assets/images/overlay/parallelization_many_against_many.png)

Core loop of SeqAn’s new many against many alignment interface using vectorization.

![](/assets/images/overlay/parallelization_speedup.png)

Speedups achieved by prototype implementation using vectorization.

First results were achieved for pairwise alignments and will be incorporated into the next releases of SeqAn.

So stay tuned for more and more components that use accelerators and multiple cores.
Your application should benefit with no changes or only slight adaptions from serial to parallel interfaces.

[Subscribe](/feed.xml)

#### Imprint

[![:de:](https://github.githubassets.com/images/icons/emoji/unicode/1f1e9-1f1ea.png ":de:") Impressum](https://www.fu-berlin.de/redaktion/impressum/index.html)
[![:gb:](https://github.githubassets.com/images/icons/emoji/unicode/1f1ec-1f1e7.png ":gb:") Legal Notice](https://www.fu-berlin.de/en/redaktion/impressum/index.html)

SeqAn is an open source C++ library of efficient algorithms and data structures for the analysis of sequences with the focus on biological data.