[![SeqAn](/assets/images/seqan.svg)](/)

[ ]

[News](/news/)
[Using SeqAn](/getting-started/)
[People](/people/)
[Applications](/apps/)
[Publications](/publications/)
[Contact](/contact/)

🌗

# Algorithms

SeqAn contains many efficient implementations of core bioinformatics algorithms. This starts with the standard dynamic programming based alignment algorithms with all its subtypes.

![](/assets/images/overlay/algorithms_stellar.png)

A depiction of the extension phase of the Stellar algorithm.

![](/assets/images/overlay/algorithms_fiona.png)

A depiction of the error correcting algorithm in the Fiona algorithm.

Global alignment, local alignment, banded and unbanded, for proteins or DNA,
using seeds or not, needing a traceback or not. Check out nearly 200 combinations of this module
which incidentally will soon be fully multithreaded and SIMD accelerated.

SeqAn contains algorithms for read mapping based on q-gram or string indices, multiple alignment algorithms,
filter algorithms for string search as well es error correction methods.

The algorithms are usually generic in the sense that they can be configured via template arguments
and usually work for many, if not arbitrary alphabets. SeqAn applications are usually short,
very maintainable combinations of those core algorithmic components.
Being well defined, the SeqAn components are quite amenable to optimisation and acceleration using multicore computing,
vectorisation or accelerators.

[Subscribe](/feed.xml)

#### Imprint

[![:de:](https://github.githubassets.com/images/icons/emoji/unicode/1f1e9-1f1ea.png ":de:") Impressum](https://www.fu-berlin.de/redaktion/impressum/index.html)
[![:gb:](https://github.githubassets.com/images/icons/emoji/unicode/1f1ec-1f1e7.png ":gb:") Legal Notice](https://www.fu-berlin.de/en/redaktion/impressum/index.html)

SeqAn is an open source C++ library of efficient algorithms and data structures for the analysis of sequences with the focus on biological data.