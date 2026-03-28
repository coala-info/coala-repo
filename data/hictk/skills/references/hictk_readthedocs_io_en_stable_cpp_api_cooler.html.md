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

[View this page](../_sources/cpp_api/cooler.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Cooler API[¶](#cooler-api "Link to this heading")

API to operate on .cool files. Compared to the generic API, this API provides:

* more control over how files are opened
* direct access to HDF5 group and datasets
* lower overhead
* support for creating .cool files
* support for opening collections of Coolers (e.g. .mcool and .scool files)

## Single-resolution Cooler (.cool)[¶](#single-resolution-cooler-cool "Link to this heading")

class File[¶](#_CPPv4N5hictk6cooler4FileE "Link to this definition")
:   **Constructors**

    File(const [File](#_CPPv4N5hictk6cooler4File4FileERK4File "hictk::cooler::File::File") &other) = delete;[¶](#_CPPv4N5hictk6cooler4File4FileERK4File "Link to this definition")

    File([File](#_CPPv4N5hictk6cooler4File4FileERR4File "hictk::cooler::File::File") &&other) noexcept = default;[¶](#_CPPv4N5hictk6cooler4File4FileERR4File "Link to this definition")

    [[nodiscard]] explicit File( : std::string\_view uri, : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : bool validate = true );[¶](#_CPPv4N5hictk6cooler4File4FileENSt11string_viewENSt6size_tEb "Link to this definition")

    [[nodiscard]] explicit File( : RootGroup entrypoint, : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : bool validate = true );[¶](#_CPPv4N5hictk6cooler4File4FileE9RootGroupNSt6size_tEb "Link to this definition")

    **Factory functions**

    [[nodiscard]] static [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") open\_random\_access( : RootGroup entrypoint, : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : bool validate = true );[¶](#_CPPv4N5hictk6cooler4File18open_random_accessE9RootGroupNSt6size_tEb "Link to this definition")

    [[nodiscard]] static [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") open\_read\_once( : RootGroup entrypoint, : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : bool validate = true );[¶](#_CPPv4N5hictk6cooler4File14open_read_onceE9RootGroupNSt6size_tEb "Link to this definition")

    template<typename PixelT = DefaultPixelT> [[nodiscard]] static [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") create( : RootGroup entrypoint, : const [Reference](shared.html#_CPPv4N5hictk9ReferenceE "hictk::Reference") &chroms, : std::uint32\_t bin\_size, : Attributes attributes = Attributes::init<[PixelT](#_CPPv4I0EN5hictk6cooler4File6createE4File9RootGroupRK9ReferenceNSt8uint32_tE10AttributesNSt6size_tENSt8uint32_tE "hictk::cooler::File::create::PixelT")>(0), : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : std::uint32\_t compression\_lvl = DEFAULT\_COMPRESSION\_LEVEL );[¶](#_CPPv4I0EN5hictk6cooler4File6createE4File9RootGroupRK9ReferenceNSt8uint32_tE10AttributesNSt6size_tENSt8uint32_tE "Link to this definition")

    template<typename PixelT = DefaultPixelT> [[nodiscard]] static [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") create( : std::string\_view uri, : const [Reference](shared.html#_CPPv4N5hictk9ReferenceE "hictk::Reference") &chroms, : std::uint32\_t bin\_size, : bool overwrite\_if\_exists = false, : Attributes attributes = Attributes::init<[PixelT](#_CPPv4I0EN5hictk6cooler4File6createE4FileNSt11string_viewERK9ReferenceNSt8uint32_tEb10AttributesNSt6size_tENSt8uint32_tE "hictk::cooler::File::create::PixelT")>(0), : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : std::uint32\_t compression\_lvl = DEFAULT\_COMPRESSION\_LEVEL );[¶](#_CPPv4I0EN5hictk6cooler4File6createE4FileNSt11string_viewERK9ReferenceNSt8uint32_tEb10AttributesNSt6size_tENSt8uint32_tE "Link to this definition")

    **Open/close methods**

    [[nodiscard]] static [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") open\_random\_access( : std::string\_view uri, : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : bool validate = true );[¶](#_CPPv4N5hictk6cooler4File18open_random_accessENSt11string_viewENSt6size_tEb "Link to this definition")

    [[nodiscard]] static [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") open\_read\_once( : std::string\_view uri, : std::size\_t cache\_size\_bytes = DEFAULT\_HDF5\_CACHE\_SIZE \* 4, : bool validate = true );[¶](#_CPPv4N5hictk6cooler4File14open_read_onceENSt11string_viewENSt6size_tEb "Link to this definition")

    void close();[¶](#_CPPv4N5hictk6cooler4File5closeEv "Link to this definition")

    Note that [`File`](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File")s are automatically closed upon destruction.

    **Operators**

    [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") &operator=(const [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") &other) = delete;[¶](#_CPPv4N5hictk6cooler4FileaSERK4File "Link to this definition")

    [File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") &operator=([File](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") &&other) noexcept = default;[¶](#_CPPv4N5hictk6cooler4FileaSERR4File "Link to this definition")

    [[nodiscard]] explicit constexpr operator bool() const noexcept;[¶](#_CPPv4NK5hictk6cooler4FilecvbEv "Link to this definition")

    [[nodiscard]] constexpr bool operator!() const noexcept;[¶](#_CPPv4NK5hictk6cooler4FilentEv "Link to this definition")

    Return whether the [`File`](#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") is in a valid state and other member functions can be safely called.

    **Accessors**

    [[nodiscard]] std::string uri() const;[¶](#_CPPv4NK5hictk6cooler4File3uriEv "Link to this definition")

    [[nodiscard]] std::string hdf5\_path() const;[¶](#_CPPv4NK5hictk6cooler4File9hdf5_pathEv "Link to this definition")

    [[nodiscard]] std::string path() const;[¶](#_CPPv4NK5hictk6cooler4File4pathEv "Link to this definition")

    [[nodiscard]] auto chromosomes() const noexcept -> const [Reference](shared.html#_CPPv4N5hictk9ReferenceE "hictk::Reference")&;[¶](#_CPPv4NK5hictk6cooler4File11chromosomesEv "Link to this definition")

    [[nodiscard]] auto bins() const noexcept -> const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")&;[¶](#_CPPv4NK5hictk6cooler4File4binsEv "Link to this definition")

    [[nodiscard]] auto bins\_ptr() const noexcept -> std::shared\_ptr<const [BinTable](shared.html#_CPPv4N5hictk8BinTableE "hictk::BinTable")>;[¶](#_CPPv4NK5hictk6cooler4File8bins_ptrEv "Link to this definition")

    [[nodiscard]] std::uint32\_t resolution() const noexcept;[¶](#_CPPv4NK5hictk6cooler4File10resolutionEv "Link to this definition")

    [[nodiscard]] std::uint64\_t nbins() const;[¶](#_CPPv4NK5hictk6cooler4File5nbinsEv "Link to this definition")

    [[nodiscard]] std::uint64\_t nchroms() const;[¶](#_CPPv4NK5hictk6cooler4File7nchromsEv "Link to this definition")

    [[nodiscard]] std::uint64\_t nnz() const;[¶](#_CPPv4NK5hictk6cooler4File3nnzEv "Link to this definition")

    [[nodiscard]] auto attributes() const noexcept -> const Attributes&;[¶](#_CPPv4NK5hictk6cooler4File10attributesEv "Link to this definition")

    [[nodiscard]] auto group(std::string\_view group\_name) -> Group&;[¶](#_CPPv4N5hictk6cooler4File5groupENSt11string_viewE "Link to this definition")

    [[nodiscard]] auto dataset(std::string\_view dataset\_name) -> Dataset&;[¶](#_CPPv4N5hictk6cooler4File7datasetENSt11string_viewE "Link to this definition")

    [[nodiscard]] auto group(std::string\_view group\_name) const -> const Group&;[¶](#_CPPv4NK5hictk6cooler4File5groupENSt11string_viewE "Link to this definition")

    [[nodiscard]] auto dataset( : std::string\_view dataset\_name ) const -> const Dataset&;[¶](#_CPPv4NK5hictk6cooler4File7datasetENSt11string_viewE "Link to this definition")

    [[nodiscard]] const NumericVariant &pixel\_variant() const noexcept;[¶](#_CPPv4NK5hictk6cooler4File13pixel_variantEv "Link to this definition")

    template<typename T> [[nodiscard]] bool has\_pixel\_of\_type() const noexcept;[¶](#_CPPv4I0ENK5hictk6cooler4File17has_pixel_of_typeEbv "Link to this definition")

    [[nodiscard]] bool has\_signed\_pixels() const noexcept;[¶](#_CPPv4NK5hictk6cooler4File17has_signed_pixelsEv "Link to this definition")

    [[nodiscard]] bool has\_unsigned\_pixels() const noexcept;[¶](#_CPPv4NK5hictk6cooler4File19has_unsigned_pixelsEv "Link to this definition")

    [[nodiscard]] bool has\_integral\_pixels() const noexcept;[¶](#_CPPv4NK5hictk6cooler4File19has_integral_pixelsEv "Link to this definition")

    [[nodiscard]] bool has\_float\_pixels() const noexcept;[¶](#_CPPv4NK5hictk6cooler4File16has_float_pixelsEv "Link to this definition")

    **Iteration**

    template<typename N> [[nodiscard]] typename [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector")::iterator<[N](#_CPPv4I0ENK5hictk6cooler4File5beginEN13PixelSelector8iteratorI1NEENSt11string_viewE "hictk::cooler::File::begin::N")> begin( : std::string\_view weight\_name = "NONE" ) const;[¶](#_CPPv4I0ENK5hictk6cooler4File5beginEN13PixelSelector8iteratorI1NEENSt11string_viewE "Link to this definition")

    template<typename N> [[nodiscard]] typename [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector")::iterator<[N](#_CPPv4I0ENK5hictk6cooler4File3endEN13PixelSelector8iteratorI1NEENSt11string_viewE "hictk::cooler::File::end::N")> end( : std::string\_view weight\_name = "NONE" ) const;[¶](#_CPPv4I0ENK5hictk6cooler4File3endEN13PixelSelector8iteratorI1NEENSt11string_viewE "Link to this definition")

    template<typename N> [[nodiscard]] typename [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector")::iterator<[N](#_CPPv4I0ENK5hictk6cooler4File6cbeginEN13PixelSelector8iteratorI1NEENSt11string_viewE "hictk::cooler::File::cbegin::N")> cbegin( : std::string\_view weight\_name = "NONE" ) const;[¶](#_CPPv4I0ENK5hictk6cooler4File6cbeginEN13PixelSelector8iteratorI1NEENSt11string_viewE "Link to this definition")

    template<typename N> [[nodiscard]] typename [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector")::iterator<[N](#_CPPv4I0ENK5hictk6cooler4File4cendEN13PixelSelector8iteratorI1NEENSt11string_viewE "hictk::cooler::File::cend::N")> cend( : std::string\_view weight\_name = "NONE" ) const;[¶](#_CPPv4I0ENK5hictk6cooler4File4cendEN13PixelSelector8iteratorI1NEENSt11string_viewE "Link to this definition")

    **Fetch methods (1D queries)**

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector") fetch( : const balancing::Method &normalization = balancing::Method::NONE(), : bool load\_index = false ) const;[¶](#_CPPv4NK5hictk6cooler4File5fetchERKN9balancing6MethodEb "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector") fetch( : std::shared\_ptr<const balancing::Weights> weights, : bool load\_index = false ) const;[¶](#_CPPv4NK5hictk6cooler4File5fetchENSt10shared_ptrIKN9balancing7WeightsEEEb "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector") fetch( : std::string\_view range, : std::shared\_ptr<const balancing::Weights> weights, : [QUERY\_TYPE](generic.html#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE") query\_type = [QUERY\_TYPE](generic.html#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE")::[UCSC](generic.html#_CPPv4N5hictk10QUERY_TYPE4UCSCE "hictk::QUERY_TYPE::UCSC") ) const;[¶](#_CPPv4NK5hictk6cooler4File5fetchENSt11string_viewENSt10shared_ptrIKN9balancing7WeightsEEE10QUERY_TYPE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector") fetch( : std::string\_view chrom\_name, : std::uint32\_t start, : std::uint32\_t end, : std::shared\_ptr<const balancing::Weights> weights ) const;[¶](#_CPPv4NK5hictk6cooler4File5fetchENSt11string_viewENSt8uint32_tENSt8uint32_tENSt10shared_ptrIKN9balancing7WeightsEEE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector") fetch( : std::string\_view range, : const balancing::Method &normalization = balancing::Method::NONE(), : [QUERY\_TYPE](generic.html#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE") query\_type = [QUERY\_TYPE](generic.html#_CPPv4N5hictk10QUERY_TYPEE "hictk::QUERY_TYPE")::[UCSC](generic.html#_CPPv4N5hictk10QUERY_TYPE4UCSCE "hictk::QUERY_TYPE::UCSC") ) const;[¶](#_CPPv4NK5hictk6cooler4File5fetchENSt11string_viewERKN9balancing6MethodE10QUERY_TYPE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector") fetch( : std::string\_view chrom\_name, : std::uint32\_t start, : std::uint32\_t end, : const balancing::Method &normalization = balancing::Method::NONE() ) const;[¶](#_CPPv4NK5hictk6cooler4File5fetchENSt11string_viewENSt8uint32_tENSt8uint32_tERKN9balancing6MethodE "Link to this definition")

    [[nodiscard]] [PixelSelector](#_CPPv4N5hictk6cooler13PixelSelectorE "hictk::cooler::PixelSelector") fetch( : std::uint64\_t first\_bin, : std::uint64\_t last\_bin, : std::shared\_ptr<const balancing::Weights> weights = nullptr ) const;[¶](#_CPPv4NK5hictk6cooler4File5fetchENSt8uint64_tENSt8uint64_tENSt10shared_ptrIKN9balancing7