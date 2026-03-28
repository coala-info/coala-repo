Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[hictk documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[hictk documentation](../index.html)

Installation

* [Installation](../installation.html)
* [Installation (source)](../installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](../faq.html)

Getting Started

* [Quickstart (CLI)](../quickstart_cli.html)
* [Quickstart (API)](../quickstart_api.html)
* [Downloading test datasets](../downloading_test_datasets.html)
* [File validation](../file_validation.html)
* [File metadata](../file_metadata.html)
* [Format conversion](../format_conversion.html)
* [Reading interactions](../reading_interactions.html)
* [Creating .cool and .hic files](../creating_cool_and_hic_files.html)
* [Creating multi-resolution files (.hic and .mcool)](../creating_multires_files.html)
* [Balancing Hi-C matrices](../balancing_matrices.html)

How-Tos

* [Reorder chromosomes](../tutorials/reordering_chromosomes.html)
* [Dump interactions to .cool or .hic file](../tutorials/dump_interactions_to_cool_hic_file.html)

CLI and API Reference

* [CLI Reference](../cli_reference.html)
* [C++ API Reference](index.html)[x]
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](../telemetry.html)

Back to top

[View this page](../_sources/cpp_api/transformers.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Pixel transformers[¶](#pixel-transformers "Link to this heading")

The transformer library provides a set of common algorithms used to manipulate streams of pixels.
Classes in defined in this library take a pair of pixel iterators or [`PixelSelector`](generic.html#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector")s directly and transform and/or aggregate them in different ways.

## Common types[¶](#common-types "Link to this heading")

enum class QuerySpan[¶](#_CPPv4N5hictk12transformers9QuerySpanE "Link to this definition")
:   enumerator lower\_triangle[¶](#_CPPv4N5hictk12transformers9QuerySpan14lower_triangleE "Link to this definition")

    enumerator upper\_triangle[¶](#_CPPv4N5hictk12transformers9QuerySpan14upper_triangleE "Link to this definition")

    enumerator full[¶](#_CPPv4N5hictk12transformers9QuerySpan4fullE "Link to this definition")

## Coarsening pixels[¶](#coarsening-pixels "Link to this heading")

template<typename PixelIt> class CoarsenPixels[¶](#_CPPv4I0EN5hictk12transformers13CoarsenPixelsE "Link to this definition")
:   Class used to coarsen pixels read from a pair of pixel iterators.
    The underlying sequence of pixels are expected to be sorted by their genomic coordinates.
    Coarsening is performed in a streaming fashion, minimizing the number of pixels that are kept into memory at any given time.

    CoarsenPixels( : [PixelIt](#_CPPv4I0EN5hictk12transformers13CoarsenPixelsE "hictk::transformers::CoarsenPixels::PixelIt") first\_pixel, : [PixelIt](#_CPPv4I0EN5hictk12transformers13CoarsenPixelsE "hictk::transformers::CoarsenPixels::PixelIt") last\_pixel, : std::shared\_ptr<const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")> source\_bins, : std::size\_t factor );[¶](#_CPPv4N5hictk12transformers13CoarsenPixels13CoarsenPixelsE7PixelIt7PixelItNSt10shared_ptrIK8BinTableEENSt6size_tE "Link to this definition")
    :   Constructor for [`CoarsenPixels`](#_CPPv4I0EN5hictk12transformers13CoarsenPixelsE "hictk::transformers::CoarsenPixels") class.
        `first_pixel` and `last_pixels` should be a pair of iterators pointing to the stream of pixels to be coarsened.
        `source_bins` is a shared pointer to the bin table to which `first_pixel` and `last_pixel` refer to.
        `factor` should be an integer value greater than 1, and is used to determine the properties of the `target_bins` [`BinTable`](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable") used for coarsening.

    **Accessors**

    [[nodiscard]] const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable") &src\_bins() const noexcept;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels8src_binsEv "Link to this definition")

    [[nodiscard]] const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable") &dest\_bins() const noexcept;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels9dest_binsEv "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")> src\_bins\_ptr() const noexcept;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels12src_bins_ptrEv "Link to this definition")

    [[nodiscard]] std::shared\_ptr<const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")> dest\_bins\_ptr() const noexcept;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels13dest_bins_ptrEv "Link to this definition")

    [`BinTable`](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable") accessors.

    **Iteration**

    [[nodiscard]] begin() const -> iterator;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels5beginEv "Link to this definition")

    [[nodiscard]] end() const -> iterator;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels3endEv "Link to this definition")

    [[nodiscard]] cbegin() const -> iterator;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels6cbeginEv "Link to this definition")

    [[nodiscard]] cend() const -> iterator;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels4cendEv "Link to this definition")

    Return an [InputIterator](https://en.cppreference.com/w/cpp/named_req/InputIterator) to traverse the coarsened pixels.

    **Others**

    [[nodiscard]] auto read\_all() const -> std::vector<[ThinPixel](shared.html#_CPPv4I0EN5hictk9ThinPixelE "hictk::ThinPixel")<N>>;[¶](#_CPPv4NK5hictk12transformers13CoarsenPixels8read_allEv "Link to this definition")

## Selecting pixels overlapping with a band around the matrix diagonal[¶](#selecting-pixels-overlapping-with-a-band-around-the-matrix-diagonal "Link to this heading")

template<typename PixelIt> class DiagonalBand[¶](#_CPPv4I0EN5hictk12transformers12DiagonalBandE "Link to this definition")
:   Class used to select pixels overlapping with a band around the matrix diagonal.

    DiagonalBand([PixelIt](#_CPPv4I0EN5hictk12transformers12DiagonalBandE "hictk::transformers::DiagonalBand::PixelIt") first\_pixel, [PixelIt](#_CPPv4I0EN5hictk12transformers12DiagonalBandE "hictk::transformers::DiagonalBand::PixelIt") last\_pixel, std::uint64\_t num\_bins);[¶](#_CPPv4N5hictk12transformers12DiagonalBand12DiagonalBandE7PixelIt7PixelItNSt8uint64_tE "Link to this definition")
    :   Constructor for [`DiagonalBand`](#_CPPv4I0EN5hictk12transformers12DiagonalBandE "hictk::transformers::DiagonalBand") class.
        `first_pixel` and `last_pixels` should be a pair of iterators pointing to the stream of pixels to be processed.
        `num_bins` should correspond to the width of the band around the matrix diagonal.
        As all filtering operations are performed based on bin IDs, this transformer is unsuitable for processing pixels
        originating from files with bin tables of non-uniform size.

    **Iteration**

    [[nodiscard]] begin() const -> iterator;[¶](#_CPPv4NK5hictk12transformers12DiagonalBand5beginEv "Link to this definition")

    [[nodiscard]] end() const -> iterator;[¶](#_CPPv4NK5hictk12transformers12DiagonalBand3endEv "Link to this definition")

    [[nodiscard]] cbegin() const -> iterator;[¶](#_CPPv4NK5hictk12transformers12DiagonalBand6cbeginEv "Link to this definition")

    [[nodiscard]] cend() const -> iterator;[¶](#_CPPv4NK5hictk12transformers12DiagonalBand4cendEv "Link to this definition")

    Return an [InputIterator](https://en.cppreference.com/w/cpp/named_req/InputIterator) to traverse the pixels after filtering.

    **Others\***

    [[nodiscard]] auto read\_all() const -> std::vector<[Pixel](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")<N>>;[¶](#_CPPv4NK5hictk12transformers12DiagonalBand8read_allEv "Link to this definition")

## Transforming COO pixels to BG2 pixels[¶](#transforming-coo-pixels-to-bg2-pixels "Link to this heading")

template<typename PixelIt> class JoinGenomicCoords[¶](#_CPPv4I0EN5hictk12transformers17JoinGenomicCoordsE "Link to this definition")
:   Class used to join genomic coordinates onto COO pixels, effectively transforming [`ThinPixel`](shared.html#_CPPv4I0EN5hictk9ThinPixelE "hictk::ThinPixel")s into [`Pixel`](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")s.

    JoinGenomicCoords( : [PixelIt](#_CPPv4I0EN5hictk12transformers17JoinGenomicCoordsE "hictk::transformers::JoinGenomicCoords::PixelIt") first\_pixel, : [PixelIt](#_CPPv4I0EN5hictk12transformers17JoinGenomicCoordsE "hictk::transformers::JoinGenomicCoords::PixelIt") last\_pixel, : std::shared\_ptr<const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")> bins );[¶](#_CPPv4N5hictk12transformers17JoinGenomicCoords17JoinGenomicCoordsE7PixelIt7PixelItNSt10shared_ptrIK8BinTableEE "Link to this definition")
    :   Constructor for [`JoinGenomicCoords`](#_CPPv4I0EN5hictk12transformers17JoinGenomicCoordsE "hictk::transformers::JoinGenomicCoords") class.
        `first_pixel` and `last_pixels` should be a pair of iterators pointing to the stream of pixels to be processed.
        `bins` is a shared pointer to the bin table to which `first_pixel` and `last_pixel` refer to.

    **Iteration**

    [[nodiscard]] begin() const -> iterator;[¶](#_CPPv4NK5hictk12transformers17JoinGenomicCoords5beginEv "Link to this definition")

    [[nodiscard]] end() const -> iterator;[¶](#_CPPv4NK5hictk12transformers17JoinGenomicCoords3endEv "Link to this definition")

    [[nodiscard]] cbegin() const -> iterator;[¶](#_CPPv4NK5hictk12transformers17JoinGenomicCoords6cbeginEv "Link to this definition")

    [[nodiscard]] cend() const -> iterator;[¶](#_CPPv4NK5hictk12transformers17JoinGenomicCoords4cendEv "Link to this definition")

    Return an [InputIterator](https://en.cppreference.com/w/cpp/named_req/InputIterator) to traverse the [`Pixel`](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")s.

    **Others\***

    [[nodiscard]] auto read\_all() const -> std::vector<[Pixel](shared.html#_CPPv4I0EN5hictk5PixelE "hictk::Pixel")<N>>;[¶](#_CPPv4NK5hictk12transformers17JoinGenomicCoords8read_allEv "Link to this definition")

## Merging streams of pre-sorted pixels[¶](#merging-streams-of-pre-sorted-pixels "Link to this heading")

template<typename PixelIt> class PixelMerger[¶](#_CPPv4I0EN5hictk12transformers11PixelMergerE "Link to this definition")
:   Class used to merge streams of pre-sorted pixels, yielding a sequence of unique pixels sorted by their genomic coordinates.
    Merging is performed in a streaming fashion, minimizing the number of pixels that are kept into memory at any given time.

    Duplicate pixels are aggregated by summing their corresponding interactions.
    Pixel merging also affects duplicate pixels coming from the same stream.

    PixelMerger(std::vector<[PixelIt](#_CPPv4I0EN5hictk12transformers11PixelMergerE "hictk::transformers::PixelMerger::PixelIt")> head, std::vector<[PixelIt](#_CPPv4I0EN5hictk12transformers11PixelMergerE "hictk::transformers::PixelMerger::PixelIt")> tail);[¶](#_CPPv4N5hictk12transformers11PixelMerger11PixelMergerENSt6vectorI7PixelItEENSt6vectorI7PixelItEE "Link to this definition")

    template<typename ItOfPixelIt> PixelMerger( : [ItOfPixelIt](#_CPPv4I0EN5hictk12transformers11PixelMerger11PixelMergerE11ItOfPixelIt11ItOfPixelIt11ItOfPixelIt "hictk::transformers::PixelMerger::PixelMerger::ItOfPixelIt") first\_head, : [ItOfPixelIt](#_CPPv4I0EN5hictk12transformers11PixelMerger11PixelMergerE11ItOfPixelIt11ItOfPixelIt11ItOfPixelIt "hictk::transformers::PixelMerger::PixelMerger::ItOfPixelIt") last\_head, : [ItOfPixelIt](#_CPPv4I0EN5hictk12transformers11PixelMerger11PixelMergerE11ItOfPixelIt11ItOfPixelIt11ItOfPixelIt "hictk::transformers::PixelMerger::PixelMerger::ItOfPixelIt") first\_tail );[¶](#_CPPv4I0EN5hictk12transformers11PixelMerger11PixelMergerE11ItOfPixelIt11ItOfPixelIt11ItOfPixelIt "Link to this definition")

    Constructors taking either two vectors of [InputIterators](https://en.cppreference.com/w/cpp/named_req/InputIterator) or pairs of iterators to [InputIterators](https://en.cppreference.com/w/cpp/named_req/InputIterator).

    The `head` and `tail` vectors should contain the iterators pointing to the beginning and end of [`ThinPixel`](shared.html#_CPPv4I0EN5hictk9ThinPixelE "hictk::ThinPixel") streams, respectively.

    **Iteration**

    [[nodiscard]] auto begin() const -> iterator;[¶](#_CPPv4NK5hictk12transformers11PixelMerger5beginEv "Link to this definition")

    [[nodiscard]] auto end() const noexcept -> iterator;[¶](#_CPPv4NK5hictk12transformers11PixelMerger3endEv "Link to this definition")

    Return an [InputIterator](https://en.cppreference.com/w/cpp/named_req/InputIterator) to traverse the stream [`ThinPixel`](shared.html#_CPPv4I0EN5hictk9ThinPixelE "hictk::ThinPixel")s after merging.

    **Others**

    [[nodiscard]] auto read\_all() const -> std::vector<PixelT>;[¶](#_CPPv4NK5hictk12transformers11PixelMerger8read_allEv "Link to this definition")

## Computing common statistics[¶](#computing-common-statistics "Link to this heading")

template<typename PixelIt> [[nodiscard]] double avg( : [PixelIt](#_CPPv4I0EN5hictk12transformers3avgEd7PixelIt7PixelIt "hictk::transformers::avg::PixelIt") first, : [PixelIt](#_CPPv4I0EN5hictk12transformers3avgEd7PixelIt7PixelIt "hictk::transformers::avg::PixelIt") last );[¶](#_CPPv4I0EN5hictk12transformers3avgEd7PixelIt7PixelIt "Link to this definition")

template<typename PixelIt, typename N> [[nodiscard]] [N](#_CPPv4I00EN5hictk12transformers3maxE1N7PixelIt7PixelIt "hictk::transformers::max::N") max( : [PixelIt](#_CPPv4I00EN5hictk12transformers3maxE1N7PixelIt7PixelIt "hictk::transformers::max::PixelIt") first, : [PixelIt](#_CPPv4I00EN5hictk12transformers3maxE1N7PixelIt7PixelIt "hictk::transformers::max::PixelIt") last );[¶](#_CPPv4I00EN5hictk12transformers3maxE1N7PixelIt7PixelIt "Link to this definition")

template<typename PixelIt> [[nodiscard]] std::size\_t nnz( : [PixelIt](#_CPPv4I0EN5hictk12transformers3nnzENSt6size_tE7PixelIt7PixelIt "hictk::transformers::nnz::PixelIt") first, : [PixelIt](#_CPPv4I0EN5hictk12transformers3nnzENSt6size_tE7PixelIt7PixelIt "hictk::transformers::nnz::PixelIt") last );[¶](#_CPPv4I0EN5hictk12transformers3nnzENSt6size_tE7PixelIt7PixelIt "Link to this definition")

template<typename PixelIt, typename N> [[nodiscard]] [N](#_CPPv4I00EN5hictk12transformers3sumE1N7PixelIt7PixelIt "hictk::transformers::sum::N") sum( : [PixelIt](#_CPPv4I00EN5hictk12transformers3sumE1N7PixelIt7PixelIt "hictk::transformers::sum::PixelI