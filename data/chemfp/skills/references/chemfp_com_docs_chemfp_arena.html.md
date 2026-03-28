[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* [Command-line examples for sparse count fingerprints](count_tools.html)
* [The chemfp command-line tools](tool_help.html)
* [Getting started with the API](getting_started_api.html)
* [Fingerprint family and type examples](fingerprint_types.html)
* [Toolkit API examples](toolkit.html)
* [Text toolkit examples](text_toolkit.html)
* [chemfp API](chemfp_api.html)
  + [chemfp top-level](chemfp_toplevel.html)
  + chemfp.arena
    - [`FingerprintArena`](#chemfp.arena.FingerprintArena)
      * [`FingerprintArena.metadata`](#chemfp.arena.FingerprintArena.metadata)
      * [`FingerprintArena.alignment`](#chemfp.arena.FingerprintArena.alignment)
      * [`FingerprintArena.num_bits`](#chemfp.arena.FingerprintArena.num_bits)
      * [`FingerprintArena.num_bytes`](#chemfp.arena.FingerprintArena.num_bytes)
      * [`FingerprintArena.start_padding`](#chemfp.arena.FingerprintArena.start_padding)
      * [`FingerprintArena.end_padding`](#chemfp.arena.FingerprintArena.end_padding)
      * [`FingerprintArena.storage_size`](#chemfp.arena.FingerprintArena.storage_size)
      * [`FingerprintArena.arena`](#chemfp.arena.FingerprintArena.arena)
      * [`FingerprintArena.popcount_indices`](#chemfp.arena.FingerprintArena.popcount_indices)
      * [`FingerprintArena.start`](#chemfp.arena.FingerprintArena.start)
      * [`FingerprintArena.end`](#chemfp.arena.FingerprintArena.end)
      * [`FingerprintArena.fingerprints`](#chemfp.arena.FingerprintArena.fingerprints)
      * [`FingerprintArena.close()`](#chemfp.arena.FingerprintArena.close)
      * [`FingerprintArena.copy()`](#chemfp.arena.FingerprintArena.copy)
      * [`FingerprintArena.count_tanimoto_hits_arena()`](#chemfp.arena.FingerprintArena.count_tanimoto_hits_arena)
      * [`FingerprintArena.count_tanimoto_hits_fp()`](#chemfp.arena.FingerprintArena.count_tanimoto_hits_fp)
      * [`FingerprintArena.count_tversky_hits_fp()`](#chemfp.arena.FingerprintArena.count_tversky_hits_fp)
      * [`FingerprintArena.get_bit_counts()`](#chemfp.arena.FingerprintArena.get_bit_counts)
      * [`FingerprintArena.get_bit_counts_as_numpy()`](#chemfp.arena.FingerprintArena.get_bit_counts_as_numpy)
      * [`FingerprintArena.get_by_id()`](#chemfp.arena.FingerprintArena.get_by_id)
      * [`FingerprintArena.get_fingerprint()`](#chemfp.arena.FingerprintArena.get_fingerprint)
      * [`FingerprintArena.get_fingerprint_by_id()`](#chemfp.arena.FingerprintArena.get_fingerprint_by_id)
      * [`FingerprintArena.get_index_by_id()`](#chemfp.arena.FingerprintArena.get_index_by_id)
      * [`FingerprintArena.get_popcount_counts()`](#chemfp.arena.FingerprintArena.get_popcount_counts)
      * [`FingerprintArena.get_popcount_offsets()`](#chemfp.arena.FingerprintArena.get_popcount_offsets)
      * [`FingerprintArena.ids`](#chemfp.arena.FingerprintArena.ids)
      * [`FingerprintArena.iter_arenas()`](#chemfp.arena.FingerprintArena.iter_arenas)
      * [`FingerprintArena.knearest_tanimoto_search_arena()`](#chemfp.arena.FingerprintArena.knearest_tanimoto_search_arena)
      * [`FingerprintArena.knearest_tanimoto_search_fp()`](#chemfp.arena.FingerprintArena.knearest_tanimoto_search_fp)
      * [`FingerprintArena.knearest_tversky_search_fp()`](#chemfp.arena.FingerprintArena.knearest_tversky_search_fp)
      * [`FingerprintArena.random_choice()`](#chemfp.arena.FingerprintArena.random_choice)
      * [`FingerprintArena.sample()`](#chemfp.arena.FingerprintArena.sample)
      * [`FingerprintArena.save()`](#chemfp.arena.FingerprintArena.save)
      * [`FingerprintArena.threshold_tanimoto_search_arena()`](#chemfp.arena.FingerprintArena.threshold_tanimoto_search_arena)
      * [`FingerprintArena.threshold_tanimoto_search_fp()`](#chemfp.arena.FingerprintArena.threshold_tanimoto_search_fp)
      * [`FingerprintArena.threshold_tversky_search_fp()`](#chemfp.arena.FingerprintArena.threshold_tversky_search_fp)
      * [`FingerprintArena.to_numpy_array()`](#chemfp.arena.FingerprintArena.to_numpy_array)
      * [`FingerprintArena.to_numpy_bitarray()`](#chemfp.arena.FingerprintArena.to_numpy_bitarray)
      * [`FingerprintArena.train_test_split()`](#chemfp.arena.FingerprintArena.train_test_split)
    - [`FingerprintList`](#chemfp.arena.FingerprintList)
      * [`FingerprintList.clear()`](#chemfp.arena.FingerprintList.clear)
      * [`FingerprintList.random_choice()`](#chemfp.arena.FingerprintList.random_choice)
  + [chemfp.base\_toolkit](chemfp_base_toolkit.html)
  + [chemfp.bitops](chemfp_bitops.html)
  + [chemfp.cdk\_toolkit](chemfp_cdk_toolkit.html)
  + [chemfp.cdk\_types](chemfp_cdk_types.html)
  + [chemfp.clustering](chemfp_clustering.html)
  + [chemfp.countops module](chemfp_countops.html)
  + [Core count fingerprint datatypes](chemfp_countops.html#core-count-fingerprint-datatypes)
  + [Parse a string to create a count fingerprint](chemfp_countops.html#parse-a-string-to-create-a-count-fingerprint)
  + [Create a string given a count fingerprint](chemfp_countops.html#create-a-string-given-a-count-fingerprint)
  + [Convert a count fingerprint to a byte fingerprint](chemfp_countops.html#convert-a-count-fingerprint-to-a-byte-fingerprint)
  + [Functions which work on count fingerprints](chemfp_countops.html#functions-which-work-on-count-fingerprints)
  + [Work with RDKit fingerprint binary strings](chemfp_countops.html#work-with-rdkit-fingerprint-binary-strings)
  + [chemfp.csv\_readers](chemfp_csv_readers.html)
  + [chemfp.diversity](chemfp_diversity.html)
  + [chemfp.encodings](chemfp_encodings.html)
  + [chemfp.fpb\_io](chemfp_fpb_io.html)
  + [chemfp.fps\_io](chemfp_fps_io.html)
  + [chemfp.fps\_search](chemfp_fps_search.html)
  + [chemfp.highlevel.arena\_tools](chemfp_highlevel_arena_tools.html)
  + [chemfp.highlevel.clustering](chemfp_highlevel_clustering.html)
  + [chemfp.highlevel.conversion](chemfp_highlevel_conversion.html)
  + [chemfp.highlevel.diversity](chemfp_highlevel_diversity.html)
  + [chemfp.highlevel.simarray](chemfp_highlevel_simarray.html)
  + [chemfp.highlevel.similarity](chemfp_highlevel_similarity.html)
  + [chemfp.io](chemfp_io.html)
  + [chemfp.jcmapper\_types](chemfp_jcmapper_types.html)
  + [chemfp.openbabel\_toolkit](chemfp_openbabel_toolkit.html)
  + [chemfp.openbabel\_types](chemfp_openbabel_types.html)
  + [chemfp.openeye\_toolkit](chemfp_openeye_toolkit.html)
  + [chemfp.openeye\_types](chemfp_openeye_types.html)
  + [chemfp.rdkit\_toolkit](chemfp_rdkit_toolkit.html)
  + [chemfp.rdkit\_types](chemfp_rdkit_types.html)
  + [chemfp.search](chemfp_search.html)
  + [chemfp.simarray\_io](chemfp_simarray_io.html)
  + [chemfp.text\_records](chemfp_text_records.html)
  + [chemfp.text\_toolkit](chemfp_text_toolkit.html)
  + [chemfp.toolkit](chemfp_toolkit.html)
  + [chemfp.types](chemfp_types.html)
  + [Overview](chemfp_api.html#overview)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* [chemfp API](chemfp_api.html)
* chemfp.arena module

---

# chemfp.arena module[](#module-chemfp.arena "Link to this heading")

Algorithms and data structure for working with a FingerprintArena.

This is an internal chemfp module. It should not be imported by
programs which use the public API. (Let me know if anything else
should be part of the public API.)

This module contains class definitions for a objects which are returned
as part of the public API. A [`FingerprintArena`](#chemfp.arena.FingerprintArena "chemfp.arena.FingerprintArena") stores
fingerprints in a contiguous block of memory, along with their
associated ids. A [`FingerprintList`](#chemfp.arena.FingerprintList "chemfp.arena.FingerprintList") provides a list-like view to
the fingerprints.

class chemfp.arena.FingerprintArena(*metadata: \_typing.Metadata*, *alignment: int*, *start\_padding: int*, *end\_padding: int*, *storage\_size: int*, *arena: \_typing.ArenaBytes*, *popcount\_indices: bytes*, *arena\_ids: \_typing.IdList*, *start: int = 0*, *end: \_typing.Optional[int] = None*, *id\_lookup: \_typing.OptionalIdLookupFunc = None*, *num\_bits: \_typing.Optional[int] = None*, *num\_bytes: \_typing.Optional[int] = None*, *license\_key: bytes = b''*)[](#chemfp.arena.FingerprintArena "Link to this definition")
:   Bases: [`Fingerprints`](chemfp_toplevel.html#chemfp.Fingerprints "chemfp.Fingerprints")

    Store fingerprints in a contiguous block of memory for fast searches

    A FingerprintArena implements the [`chemfp.FingerprintReader`](chemfp_toplevel.html#chemfp.FingerprintReader "chemfp.FingerprintReader") API.

    The fingerprints in a continuous block of memory so the per-molecule
    overhead is very low. The block is named [`arena`](#chemfp.arena.FingerprintArena.arena "chemfp.arena.FingerprintArena.arena"). The first
    fingerprint starts at the offset [`start_padding`](#chemfp.arena.FingerprintArena.start_padding "chemfp.arena.FingerprintArena.start_padding") and each
    fingerprint takes [`storage_size`](#chemfp.arena.FingerprintArena.storage_size "chemfp.arena.FingerprintArena.storage_size") bytes, so fingerprint i is
    located at:

    ```
    self.arena[self.start_padding +   i   * self.storage_size:
               self.start_padding + (i+1) * self.storage_size ]
    ```

    The fingerprints can be sorted by popcount, so the fingerprints
    with no bits set come first, followed by those with 1 bit, etc.
    If `self.popcount_indices` is a non-empty string then the string
    contains information about the start and end offsets for all the
    fingerprints with a given popcount. This information is used for
    the BitBound search algorithm.

    A FingerprintArena is its own context manager, but it does nothing
    on context exit. The derived [`FPBFingerprintArena`](chemfp_fpb_io.html#chemfp.fpb_io.FPBFingerprintArena "chemfp.fpb_io.FPBFingerprintArena") may
    use a memory-mapped FPB file, which will be closed by the
    context manager or by an explicit call to close().

    The public attributes are:

    > metadata: [chemfp.Metadata](chemfp_toplevel.html#chemfp.Metadata "chemfp.Metadata")[](#chemfp.arena.FingerprintArena.metadata "Link to this definition")
    > :   A [`chemfp.Metadata`](chemfp_toplevel.html#chemfp.Metadata "chemfp.Metadata") with information about the fingerprints.
    >
    > alignment: int[](#chemfp.arena.FingerprintArena.alignment "Link to this definition")
    > :   The fingerprint memory alignment.
    >
    > num\_bits: int[](#chemfp.arena.FingerprintArena.num_bits "Link to this definition")
    > :   The number of bits in each fingerprint. Must be
    >     `(num_bytes-1)*8 < num_bits <= num_bytes*8`.
    >
    > num\_bytes: int[](#chemfp.arena.FingerprintArena.num_bytes "Link to this definition")
    > :   The number of bytes in each fingerprint (must be <= storage\_size).
    >
    > start\_padding: int[](#chemfp.arena.FingerprintArena.start_padding "Link to this definition")
    > :   The number of bytes to the first fingerprint in the arena block.
    >
    > end\_padding: int[](#chemfp.arena.FingerprintArena.end_padding "Link to this definition")
    > :   The number of bytes after the last fingerprint in the arena block.
    >
    > storage\_size: int[](#chemfp.arena.FingerprintArena.storage_size "Link to this definition")
    > :   The number of bytes used to store a fingerprint. This may
    >     be larger than the fingerprint num\_bytes due to padding.
    >     The padding is supposed to be zeros.
    >
    > arena: bytes[](#chemfp.arena.FingerprintArena.arena "Link to this definition")
    > :   A contiguous block of memory containing the fingerprints
    >     and possible other data. This is typically a byte string
    >     or memory-map.
    >
    > popcount\_indices: bytes[](#chemfp.arena.FingerprintArena.popcount_indices "Link to this definition")
    > :   A byte string containing the offset indices for
    >     fingerprints sorted by popcount. You should use
    >     [`get_popcount_offsets()`](#chemfp.arena.FingerprintArena.get_popcount_offsets "chemfp.arena.FingerprintArena.get_popcount_offsets") instead of this
    >     string. It is b”” if there is no index.
    >
    > start: int[](#chemfp.arena.FingerprintArena.start "Link to this definition")
    > :   The index for the first fingerprint in the arena. May be
    >     greater than 0 if this is a subarena starting after the
    >     start of the arena. (It is not a byte position!)
    >
    > end: int[](#chemfp.arena.FingerprintArena.end "Link to this definition")
    > :   If a subarena, one more than the index of the last fingerprint
    >     relative to the start of the parent arena. Will be the number
    >     of total fingerprints if this is not a subarena.
    >
    > fingerprints: [FingerprintList](#chemfp.arena.FingerprintList "chemfp.arena.FingerprintList")[](#chemfp.arena.FingerprintArena.fingerprints "Link to this definition")
    > :   Provide a [`FingerprintList`](#chemfp.arena.FingerprintList "chemfp.arena.FingerprintList") list-like access to
    >     the fingerprints, in index order.

    close()[](#chemfp.arena.FingerprintArena.close "Link to this definition")
    :   Remove any resources associated with this arena

        If the arena uses a memory-mapped file (eg, an FPB file)
        then this will close the file. If this arena loads the
        data into memory then that the reference to that data
        will be removed, which should deallocate the data.

        The arena fingerprints and identifiers will no longer
        be available after calling close().

    copy(*indices: \_typing.Optional[\_typing.Sequence[int]] = None*, *reorder: \_typing.Optional[bool] = None*, *metadata: \_typing.OptionalMetadata = None*, *ids: \_typing.Optional[\_typing.Sequence[str]] = None*) → [FingerprintArena](#chemfp.arena.FingerprintArena "chemfp.arena.FingerprintArena")[](#chemfp.arena.FingerprintArena.copy "Link to this definition")
    :   Create a new arena using either all or some of the fingerprints in this arena

        By default this create a new arena. The fingerprint data block and ids may
        be shared with the original arena, which makes this a shallow copy. If the
        original arena is a slice, or “sub-arena” of an arena, then the copy will
        allocate new space to store just the fingerprints in the slice and use its
        own list for the ids.

        The *indices* parameter, if not None, is an iterable which contains the
        indicies of the fingerprint records to copy. Duplicates are allowed, though
        discouraged.

        If *indices* are specified then the default *reorder* value of None, or
        the value True, will reorder the f