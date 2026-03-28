# [chemfp](https://chemfp.com/index.html)

* [Features](https://chemfp.com/features/)
* [Download](https://chemfp.com/download/)
* [Datasets](https://chemfp.com/datasets/)
* [License](https://chemfp.com/license/)
* [News](https://chemfp.com/news/)
* [Contact](https://chemfp.com/contact/)

* [High Performance Search](/performance/)
* [FPS Format](/fps_format/)
* [FPB Format](/fpb_format/)
* [FPC Format](/fpc_format/)
* [• Datasets](/datasets/)
* [Multiple Toolkit Support](/toolkits/)
* [Documentation:](/docs/)
* [• Command-line Tools](/docs/tools.html)
* [• Python API](/docs/chemfp_api.html)
* [• Example Programs](https://hg.sr.ht/~dalke/chemfp_examples)

## FPB format specification

The FPB format is a binary format designed for fast load times into
chemfp. The data is laid out in such a way that most of it can be
memory-mapped directly into the chemfp's arena data structure.

It was orginally developed to help with web application and web
services development. Usually you make a change to the code and
restart the server. If the web app uses an FPS file then it needs to
reload the file, which may take a few seconds for a typical corporate
collection. A few seconds doesn't seem so bad at the start of a long
clustering job, but it is really noticable if you just want to see if
the new color looks right.

With the FPB format, the reload time is measured in milliseconds.

The load performance is also useful on the command-line. A
[simsearch](/docs/simsearch_command)
query of a 1M fingerprint data set takes less than 1/4th of a second,
and if the file is already in the file system cache then it takes less
than 1/10th of a second. (The limiting factor is the Python startup
cost.)

If you are looking for a text-based fingerprint format which is easier to read and write
then you should look at the [FPS format](/fps_format/).

## Design limits

The FPB format was designed for the typical corporate collection of
~5-10M compounds. It can handle "PubChem sized" data sets, on the
order of 100-200M fingerprints.

Design limitations prevent it from scaling to significantly larger
sizes. For example, quadratic behavior in the hash table
implementation limits it to at most about 2-3 billion fingerprints,
assuming evenly distributed hash values.

Specially chosen identifiers may cause quadratic behavior with a
smaller number of values, and may overflow one of the hash tables
after roughly 260M entries. A cautious implementation may add extra
checks for a possible [algorithmic complexity
attack](https://en.wikipedia.org/wiki/Algorithmic_complexity_attack).
Chemfp does not currently implement these checks.

## Overall layout

The FPB file is organized as a
[FourCC](https://en.wikipedia.org/wiki/FourCC) file.

The first 8 bytes are "FPB1\r\n\0\0", which is a signature that the
file followed version 1 of the FPB format.

After the signature is a sequence of chunks. Each chunk contains an
8-byte length field followed a 4-byte identifier followed by *n* bytes
of data, where *n* is the value of the length field. The length field
bytes are intepreted as a uint64 (unsigned 64-bit integer) in
little-endian byte order. (All integer values in the file are are in
little-endian byte order.)

For example, the value 17179935247 is represented as the 8 byte
sequence "\x0f\x02\x01\x00\x04\x00\x00\x00". The corresponding Python
struct format is "<Q".

This specification defines nine chunk types:

* [META](#meta) - the metadata chunk stores the metadata section of the FPS header
* [TEXT](#text) - the text chunk stores the labeled readable text
* [AREN](#aren) - the arena chunk stores the fingerprints as a sequence of bytes.
* [POPC](#popc) - the popcount chunk stores an index to ranges of fingerprints in the AREN chunk
* [FPID](#fpid) - the fpid chunk stores the fingerprint identifiers in sequential order
* [HASH](#hash) - the id hash table chunk stores hash table to look up record position given its identifier
* [HSH2](#hsh2) - a variant of the HASH format which
  supports more identifiers
* [CFPL](#cfpl) - the cfpl chunk stores the authorization key for a licensed FPB file
* [FEND](#fend) - the end chunk indicates that chunk processing ends at this point

The META, TEXT, POPC, HASH, HSH2, and FEND chunks are optional, but
the META chunk should be present. Only one of HASH and HSH2 may be
present. The AREN, FPID, and FEND chunks are required. The FEND must
be the last chunk.

The META chunk should be the first chunk because in practice it's nice
to be able to `od -c` or `strings` on the file and see the fingerprint
type in the first page of output.

The TEXT chunks should go next, for the same reason.

Otherwise there is no required order.

Extensions to this specification may define new chunk types. These
chunks may be ignored without affecting the interpretation of the
chunks defined by this specification.

Bytes present after the last chunk should be ignored.

## META chunk

The META chunk is a UTF-8 encoded string formatted as the metadata
section of the FPS file. That is, it is a sequence of lines where the
first character of the line is a '#' and and the line ends with either
the newline character "\n" or the two character sequence of carriage-return
followed by newline, "\r\n".

The line is further decomposed into "<key>=<value>" pairs.

For details, see the [FPS specification](/fps_format/).

## TEXT chunk

The TEXT chunk stores labeled human-readable text, such as copyright
and license information. A TEXT chunk contains a label containing a
sequence of printable ASCII characters, followed by a newline,
followed by the UTF-8 encoded text.

The following labels are predefined and should be used where
appropriate:

* Title - Short (one line) title
* Description - Description
* Copyright - Copyright notice
* Attribution - How to cite the use of the data set
* License - License terms
* Notice - A legal notice, such as notice that changes were made to the original work.
* Comment - Miscellaneous comment

Other labels may be defined for other purposes, following the
guidelines for [PNG keywords](https://www.w3.org/TR/PNG/#11keywords).

## AREN chunk

The AREN chunk stores the fingerprint information as a contiguous
block. The ARENA chunk is laid out as follows:

1. `num_bits`, 4 bytes as an unsigned 32-bit integer
2. `storage_size`, 4 bytes as an unsigned 32-bit integer
3. `spacer_size`, 1 byte as an unsigned 8-bit integer
4. <`spacer_size`> NUL bytes as a spacer
5. the contiguous block of fingerprints

A fingerprint is a sequence of `num_bytes` bytes. Each fingerprint is
stored in a storage block of size `storage_size` bytes. The
fingerprint is left-aligned in the storage block. The storage block
may be larger than the fingerprint for improved alignment. For
example, a 166-bit MACCS fingerprint requires only 21 bytes, but it
may be stored in a 24 byte storage block to take advantage of
operations which may require 32-bit or 64-bit word alignment.

Word alignment is important for some processors because the
high-performance popcount implementation may either require
word-aligned data, or have worse performance when reading unaligned
data. Chemfp works best with 8-byte aligned data, so the FPB format
should be 8-byte aligned.

The FPB format is designed to be used as a memory-mapped file, which
means the location of the first fingerprint must also be word aligned
with respect to its position in the FPB file. This is done by adding a
spacer just before the first fingerprint. The spacer is a sequence of
`spacer_size` NUL bytes where `0 <= spacer_size < 256`.

The number of fingerprints in the chunk is:

```
 (chunk size - 4 bytes - 4 bytes - 1 byte - spacer_size bytes) / storage_size
```

No extra bytes are allowed after the final fingerprint.

## POPC chunk

The POPC chunk stores the start and end range of all the fingerprints
with a given population count. This chunk may only be present if the
fingerprints are sorted in popcount order such that all fingerprints
with no bits set come first, then all fingerprints with one bit set, etc.

The chunk contains a set of `N` index offsets in sorted order such
that all fingerprints with population count `popc` have an index `i`
such that `offset[popc]<= i < offset[popc+1]`. The first offset is
always 0. If there are no fingerprints with population count `popc`
then `offset[popc] == offset[popc+1]`.

The value of `N` must be either `num_bits+2`, where `num_bits` is the
number of bits in the fingerprint as specified in the META chunk, or
`8*num_bytes + 2` where `num_bytes` is specified in the AREN chunk.

Each index offset is stored as 4 bytes, interpreted as an unsigned
32-bit integer.

## FPID chunk

The FPID chunk stores the fingerprint identifiers in the same order as
the corresponding fingerprint in the AREN chunk. The overall layout of
this chunk is:

1. `num_4byte_elements`, 4 bytes as an unsigned 32-bit integer
2. `num_8byte_elements`, 4 bytes as an unsigned 32-bit integer
3. the 4-byte offset table
4. the 8-byte offset table
5. the identifier block

The identifiers are stored as a sequence of `num_elements` UTF-8
encoded strings terminated by the NUL character (ASCII 0), where
`num_elements = num_4byte_records + num_8byte_records`. Duplicate
identifiers are allowed.

For documentation purposes, the identifier block starts at offset
`offset_start` in the chunk, which can be computed from the number of
4- and 8-byte elements.

An offset table provides O(1) indexing into the identifier block. The
identifier for record `0<= i < num_elements` starts at position
`offset_start + offset_table[i]` and the terminal NUL is at position
`offset_start + offset_table[i+1]-1`.

The offset table is stored in two sub-tables, the first with
`num_4byte_elements` 4-byte offsets and the second with
`num_8byte_elements` 8-byte offsets. The offsets are stored as
32-bit and 64-bit unsigned integers, respectively.

This unusual design was chosen in order to minimize wasted space for
the common use-case of fingerprint data sets with fewer than 10M
entries while also allowing PubChem-sized data sets with over 100M
records. The latter may require more than 32-bits to index into the
identifier block, but an 8-byte offset table is overkill for most data
sets.

## HASH chunk

The HASH chunk implements a static hash table to make it possible to
find all records with a given identifier in (typically) O(1) time.

The format is heavily influenced by the
"[cdb](http://cr.yp.to/cdb.html)" data format of Daniel J. Bernstein.
See also [Wikipedia](http://en.wikipedia.org/wiki/Cdb_%28software%29) and
a
[description by Yusuke Shinyama](http://www.unixuser.org/~euske/doc/cdbinternals/index.html).

The overall layout of this chunk is:

1. a main table with 256 entries describing the hash tables
2. 256 hash tables mapping a hash value to an offset in the FPID chunk

The implementation uses the cdb hash function `h = ((h << 5) + h) ^ c`,
with a starting hash of 5381. `h` is an unsigned 32-bit integer
and `c` takes on the successive characters in the UTF-8 encoded
identifier. The hash values for "Andrew" and "chemfp" are respectively
2489760750 and 1547934480. The hash-value for the Greek small letter
beta ("β"), which is UTF-8 encoded as the two bytes '\xce\xb2', is
5857913.

The main table contains 256 entries. Each entry contains 8 bytes. The
first 4 bytes, `P[i]`, is a 32-bit unsigned integer giving the byte
offset from the end of the main table to the start of hash table `i`.
The second 4 bytes, `E[i]`, is the number of slots in hash table `i`.
`E[i]` is always twice the number of entries in the hash table, that
is, the load factor is 50%.

After the main table are 256 subtables. Given a hash H for the query
identifier, the lowest 8 bits (`H % 256`) are used as the index into
the list of subtables.

Each subtable `i` contains `E[i]` slots. Each slot contains 8 bytes. A
slot may be occupied, in which case the first 4 bytes contains the
hash value and of the record id in the FPID chunk and the second 4
bytes contains the record offset in the FPID chunk. An empty slot
contains the 8 bytes "`\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF`".

To find the record or records which match the query identifier, start
by computing the initial probe value of `H % E[i]`. If the
corresponding slot is unoccupied then the identifier is not present.
Otherwise, if the hash value H matches the first 4 bytes of the slot
then use the second 4 bytes as an offset index into FPID to get the
record identifier. If it matches the query indentifier then a matching
record was found.

The hash table uses linear probing. If the hash or identifier does not
match, or to see if there are multiple records which match the query
identifier, then advance the prove value by 1, modulo `E[i]`, and try
the next slot.

## HSH2 chunk

The HSH2 chunk is a minor variation of the HASH chunk which handles
more identifiers.

The main table in the HASH chunk stores byte offsets to the start of
the corresponding subtable as unsigned 32-bit integers. The length of
each subtable is a multiple of 16, which means the offset to the last
table can be at most `2**31-1`, which occurs if the first 255
tables contain 268,435,455 (`(2**31-1)/16)`) identifiers.

This limited the FPB format to just under 270 million entries,
assuming the cdb hash function does a good job of distributing the
hash values.

The main table in the HSH2 chunk contains 257 unsigned long long (64
byte) entries containing `P[0]`, `P[1]`, ... `P[255]`, `P[256]` where
`P[i]` for `i <= 255` contains the start offset to subtable `i` and
where `E[i]` is computing as `P[i+1] - P[i]`.

The HSH2 chunk is 8 bytes longer than the HASH2 chunk but is no longer
limited to ~270 million entries.

Other parts of the FPB format assume 32-bit indexing, which limits the
size to about 4 billion fingerprints. Chemfp's FPB support has only
been tested up to 1 billion fingerprints.

Chemfp 5.0 added support for the HSH2 chunk. The reader handles both
chunks. The writer uses the HASH chuck if there are fewer than 250
million fingerprint, otherwise it uses the HSH2 chunk.

## CFPL chunk

The CFPL chunk contains an authorization key which unlocks chemfp
search functionality for [licensed FPB files](/datasets/). The details
are not part of the FPB specification.

## FEND chunk

This chunk contains no data. The entire chunk with length and chunk id
is the 12 byte sequence `\x00\x00\x00\x00\x00\x00\x00\x00\x00FEND`.

## Changes

15 Aug 2025: Documented the HSH2 chunk.

Copyright © 2012-2025 Andrew Dalke Scientific AB