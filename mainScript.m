
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SUPERVOXEL GENERATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
superVoxelOpts.filePreamble                                              = '~/bb/data/dawen/supervoxels_dcai_PVhippo1_bm4d_sigma500_ws0.005_sigma2000_ws0.005_augmented';
superVoxelOpts.brightnessThreshold                                       = 0.05;
superVoxelOpts.spatialDistanceCalculationOpts.upperBound                 = 2;
superVoxelOpts.splitHardSVopts.detThreshold                              = 1e-10;
superVoxelOpts.splitHardSVopts.connectivity                              = 26;
superVoxelOpts.splitHardSVopts.subdivisionSizeThreshold                  = 50;
superVoxelOpts.dataset                                                   = '~/bb/data/dcai_PVhippo1_bm4d_sigma500.mat';
superVoxelOpts.HMINTH26                                                  = 0.005;
supervoxelize(superVoxelOpts);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CONSERVATIVE MERGING OF SUPERVOXELS %%%%%%%%%%%%%%%%%%%%%%%%%
mergeOpts.loadFilename                                                   = '/home/uygar/bb/data/dawen/supervoxels_dcai_PVhippo1_bm4d_sigma500_ws0.005_augmented6_subdivide50.mat';
mergeOpts.saveFileName                                                   = '/home/uygar/bb/data/dawen/merged_supervoxels_dcai_PVhippo1_bm4d_sigma500_ws0.005_augmented6_subdivide50';
mergeOpts.zAnisotropy                                                    = 3;
mergeOpts.demix.maxSimilarNeighborNormLUVDist                            = 30 * sqrt(size(svMeans, 2)/4);
mergeOpts.demix.minImprovementFactor                                     = 3;
mergeOpts.demix.maxSizeForDemixing                                       = 500;
mergeOpts.mergeSmallSuperVoxels.luvColorDistanceUpperBound               = 30;
mergeOpts.mergeSmallSuperVoxels.disconnectedSVsizeTh                     = 20;
mergeOpts.mergeWRTnAo.sDist                                              = sqrt(3);
mergeOpts.mergeWRTnAo.minDotProduct                                      = 1/sqrt(2);
mergeOpts.mergeWRTnAo.maxColorDist                                       = 6 * sqrt(size(svMeans, 2)/4);
mergeOpts.mergeCloseNeighborhoods.maxDistNormLUV                         = 6 * sqrt(size(svMeans, 2)/4);
mergeOpts.kmeansMerging.clusterCount                                     = 40;
mergeOpts.kmeansMerging.overClusteringFactor                             = 5;
mergeOpts.kmeansMerging.maxColorDistance                                 = 6 * sqrt(size(svMeans, 2)/4);
mergeSupervoxels(mergeOpts)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SEGMENTATION OF MERGED SUPERVOXELS %%%%%%%%%%%%%%%%%%%%%%%%%
mergedSvFileName                    = '/home/uygar/bb/data/dawen/merged_supervoxels_dcai_PVhippo1_bm4d_sigma500_ws0.005_augmented6_subdivide50_sAff15.mat';
graphData.c                         = 0.5e-3;
graphData.s                         = 4.33e-2;
graphData.colorRadiusForPure        = 20;
graphData.minSizeForPure            = 50;
graphData.maxDetCovForPure          = 1e-10;
graphData.spatialNhoodRadius        = sqrt(11)+eps;
graphData.maxColorRadiusForPure     = 20;
graphData.maxColorRadiusForProximal = 40;
graphData.minEdgeCountForPure       = 2;
graphData.minEdgeCountForProximal   = 5;
graphData.maxAssumedSdist           = 4;
graphData.opts_irbleigs.K           = 39;
[index, hardClusterStats]           = segmentImage(mergedSvFileName, graphData);
writeFileName = ['~/bb/results/pvhippo_' num2str(graphData.c) '_' num2str(graphData.s) '_' num2str(graphData.colorRadiusForPure) '_' num2str(graphData.minSizeForPure) '_' num2str(graphData.maxDetCovForPure) '_'];
writeFileName = [writeFileName num2str(graphData.spatialNhoodRadius) '_' num2str(graphData.maxColorRadiusForPure) '_' num2str(graphData.maxColorRadiusForProximal) '_' num2str(graphData.minEdgeCountForPure) '_'];
writeFileName = [writeFileName num2str(graphData.minEdgeCountForProximal) '_' num2str(graphData.maxAssumedSdist) '_' num2str(graphData.opts_irbleigs.K) '.jpg'];
movefile('~/bb/results/thisBigImCOSYNE.jpg', writeFileName);