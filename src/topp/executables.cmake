### the directory name
set(directory source/APPLICATIONS/TOPP)

### list all filenames of the directory here
set(TOPP_executables
BaselineFilter
CometAdapter
ConsensusID
ConsensusMapNormalizer
DatabaseSuitability
Decharger
DTAExtractor
EICExtractor
ExternalCalibration
FalseDiscoveryRate
FeatureFinderCentroided
FeatureFinderIdentification
FeatureFinderIsotopeWavelet
FeatureFinderMetabo
FeatureFinderMRM
FeatureFinderMultiplex
FeatureLinkerLabeled
FeatureLinkerUnlabeled
FeatureLinkerUnlabeledKD
FeatureLinkerUnlabeledQT
FidoAdapter
FileConverter
FileFilter
FileInfo
FileMerger
FLASHDeconv
GenericWrapper
GNPSExport
HighResPrecursorMassCorrector
IDConflictResolver
IDFileConverter
IDFilter
IDMapper
IDMerger
IDPosteriorErrorProbability
IDRipper
IDRTCalibration
InternalCalibration
IsobaricAnalyzer
LuciphorAdapter
MapAlignerIdentification
MapAlignerPoseClustering
MapAlignerSpectrum
MapAlignerTreeGuided
MapNormalizer
MapRTTransformer
MapStatistics
MaRaClusterAdapter
MascotAdapter
MascotAdapterOnline
MassTraceExtractor
MRMMapper
MSGFPlusAdapter
MzTabExporter
NoiseFilterGaussian
NoiseFilterSGolay
OpenPepXL
OpenPepXLLF
OpenSwathAnalyzer
OpenSwathAssayGenerator
OpenSwathChromatogramExtractor
OpenSwathConfidenceScoring
OpenSwathDecoyGenerator
OpenSwathFeatureXMLToTSV
OpenSwathRTNormalizer
PeakPickerHiRes
PeakPickerWavelet
PeptideIndexer
PercolatorAdapter
PhosphoScoring
PrecursorMassCorrector
ProteinInference
ProteinQuantifier
ProteinResolver
QualityControl
SageAdapter
SeedListGenerator
SpecLibSearcher
SpectraFilterBernNorm
SpectraFilterMarkerMower
SpectraFilterNLargest
SpectraFilterNormalizer
SpectraFilterParentPeakMower
SpectraFilterScaler
SpectraFilterSqrtMower
SpectraFilterThresholdMower
SpectraFilterWindowMower
SpectraMerger
TextExporter
TOFCalibration
XFDR
XTandemAdapter
)

## util category
set(TOPP_executables
${TOPP_executables}
AccurateMassSearch
AssayGeneratorMetabo
ClusterMassTraces
ClusterMassTracesByPrecursor
CVInspector
DatabaseFilter
DecoyDatabase
DeMeanderize
Digestor
DigestorMotif
Epifany
ERPairFinder
FeatureFinderMetaboIdent
FuzzyDiff
IDDecoyProbability
IDExtractor
IDMassAccuracy
IDScoreSwitcher
IDSplitter
JSONExporter
MassCalculator
MetaboliteAdductDecharger
MetaboliteSpectralMatcher
MetaProSIP
MRMPairFinder
MSFraggerAdapter
MSstatsConverter
MultiplexResolver
MzMLSplitter
NovorAdapter
NucleicAcidSearchEngine
OpenMSDatabasesInfo
OpenMSInfo
PeakPickerIterative
PSMFeatureExtractor
QCCalculator
QCEmbedder
QCExporter
QCExtractor
QCImporter
QCMerger
QCShrinker
ProteomicsLFQ
RNADigestor
RNAMassCalculator
RNPxlXICFilter
RNPxlSearch
SemanticValidator
SequenceCoverageCalculator
SimpleSearchEngine
SiriusAdapter
SpecLibCreator
SpectraSTSearchAdapter
StaticModification
TICCalculator
TriqlerConverter
XMLValidator
)

if(NOT DISABLE_OPENSWATH)
  set(TOPP_executables
    ${TOPP_executables}
    TargetedFileConverter
    OpenSwathDIAPreScoring
    OpenSwathMzMLFileCacher
    OpenSwathWorkflow
    OpenSwathFileSplitter
    OpenSwathRewriteToFeatureXML
    MRMTransitionGroupPicker
  )
endif(NOT DISABLE_OPENSWATH)

## all targets requiring OpenMS_GUI
set(TOPP_executables_with_GUIlib
ExecutePipeline
Resampler
# util category
ImageCreator
INIUpdater
)

### add filenames to Visual Studio solution tree
set(sources_VS)
foreach(i ${TOPP_executables} ${TOPP_executables_with_GUIlib})
	list(APPEND sources_VS "${i}.cpp")
endforeach(i)

source_group("" FILES ${sources_VS})
