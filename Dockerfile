# Julia + necessary packages Dockerfile

FROM julia:1.2.0

RUN apt-get update && apt-get install -y procps

ENV JULIA_DEPOT_PATH=/opt/julia
ENV JULIA_PKGDIR=/opt/julia
ENV JULIA_VERSION=1.2.0

ENV JULIA_PATH /usr/local/julia
ENV PATH $JULIA_PATH/bin:$PATH

RUN mkdir -p "$JULIA_DEPOT_PATH"

RUN julia -e 'using Pkg; Pkg.add(["Dates", "Automa", "BioCore", "Parsers", "PooledArrays", "WeakRefStrings", "FilePathsBase", "LazyArrays", "Libdl", "Mmap", "CategoricalArrays", "Missings", "InvertedIndices", "Tables", "TableTraits", "IteratorInterfaceExtensions", "DataAPI", "Unicode", "SortingAlgorithms", "Reexport", "TextWrap", "Compat", "Blosc", "ArgParse", "DataFrames", "CSV", "Profile", "Random", "Statistics", "HDF5", "Bio", "BioSequences", "DelimitedFiles"])'

ENV COMPILEFOLDER /opt/julia/compiled/v1.2/

RUN mkdir -p "$COMPILEFOLDER/ArgParse" && \
    mkdir -p "$COMPILEFOLDER/HDF5" && \
    mkdir -p "$COMPILEFOLDER/Profile" && \
    mkdir -p "$COMPILEFOLDER/DataFrames" && \
    mkdir -p "$COMPILEFOLDER/CSV" && \
    mkdir -p "$COMPILEFOLDER/Statistics" && \
    mkdir -p "$COMPILEFOLDER/BioSequences" && \
    mkdir -p "$COMPILEFOLDER/Bio" 

RUN julia -e "Base.compilecache(Base.PkgId(\"ArgParse\"))" && \
    julia -e "Base.compilecache(Base.PkgId(\"HDF5\"))" && \
    julia -e "Base.compilecache(Base.PkgId(\"Profile\"))" && \
    julia -e "Base.compilecache(Base.PkgId(\"DataFrames\"))" && \
    julia -e "Base.compilecache(Base.PkgId(\"CSV\"))" && \
    julia -e "Base.compilecache(Base.PkgId(\"Statistics\"))" && \
    julia -e "Base.compilecache(Base.PkgId(\"BioSequences\"))" && \
    julia -e "Base.compilecache(Base.PkgId(\"Bio\"))" 

CMD ["julia"]
