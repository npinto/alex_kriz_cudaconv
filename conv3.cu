/*
 * conv3.cu
 *
 *  Created on: Nov 15, 2009
 *      Author: Alex Krizhevsky (akrizhevsky@gmail.com)
 */
#include <math.h>
#include <nvmatrix.cuh>
#include "conv3.cuh"

void _convolve3_bw(float* images, float* filters, float* targets, int numCases,
                  int numFilters, int imgSize, int filterSize, int stride, bool useDynamics = false) {
    assert(stride == 1 || stride == 3);
    int numOutputsX = imgSize - filterSize + 1;
//    int numOutputs = numOutputsX*numOutputsX;
    bool checkOutputBounds = numOutputsX % 16 != 0;
    if(filterSize > 37) {
        int numPartsX = DIVUP(numOutputsX, 16);
        int numParts = numPartsX*numPartsX;
        int blocksY = numParts, blocksX = numCases;
        dim3 grid(blocksX, blocksY);
        dim3 threads(16, 16);
        bool checkFilterBounds = filterSize % 16 != 0;
//        printf("check filter bounds: %d, check output bounds: %d, stride: %d\n", checkFilterBounds, checkOutputBounds, stride);
        if(checkFilterBounds) {
            if (checkOutputBounds) {
                if (stride == 1) {
                    conv3_bw_nofit_16x16<true, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                } else {
                    conv3_bw_nofit_16x16<true, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                }
            } else {
                if (stride == 1) {
                    conv3_bw_nofit_16x16<false, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                } else {
                    conv3_bw_nofit_16x16<false, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                }
            }
        } else {
            if (checkOutputBounds) {
                if (stride == 1) {
                    conv3_bw_nofit_16x16<true, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                } else {
                    conv3_bw_nofit_16x16<true, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                }
            } else {
                if (stride == 1) {
                    conv3_bw_nofit_16x16<false, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                } else {
                    conv3_bw_nofit_16x16<false, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters, filterSize);
                }
            }
        }
    } else {
        if (useDynamics) {
            // later
        } else {
            int numPartsX = DIVUP(numOutputsX, 16);
            int numParts = numPartsX*numPartsX;
            int blocksY = numParts, blocksX = numCases;
            dim3 grid(blocksX, blocksY);
            dim3 threads(16, 16);

            /*
             * This code was auto-generated...
             */
            if (filterSize == 1) {
                throw "try multByScalar";
            } else if (filterSize == 2) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<2, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<2, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<2, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<2, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 3) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<3, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<3, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<3, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<3, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 4) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<4, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<4, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<4, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<4, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 5) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<5, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<5, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<5, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<5, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 6) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<6, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<6, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<6, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<6, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 7) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<7, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<7, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<7, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<7, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 8) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<8, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<8, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<8, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<8, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 9) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<9, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<9, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<9, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<9, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 10) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<10, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<10, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<10, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<10, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 11) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<11, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<11, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<11, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<11, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 12) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<12, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<12, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<12, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<12, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 13) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<13, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<13, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<13, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<13, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 14) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<14, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<14, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<14, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<14, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 15) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<15, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<15, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<15, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<15, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 16) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<16, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<16, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<16, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<16, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 17) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<17, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<17, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<17, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<17, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 18) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<18, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<18, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<18, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<18, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 19) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<19, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<19, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<19, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<19, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 20) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<20, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<20, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<20, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<20, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 21) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<21, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<21, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<21, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<21, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 22) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<22, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<22, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<22, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<22, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 23) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<23, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<23, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<23, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<23, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 24) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<24, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<24, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<24, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<24, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 25) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<25, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<25, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<25, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<25, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 26) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<26, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<26, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<26, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<26, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 27) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<27, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<27, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<27, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<27, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 28) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<28, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<28, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<28, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<28, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 29) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<29, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<29, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<29, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<29, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 30) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<30, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<30, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<30, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<30, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 31) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<31, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<31, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<31, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<31, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 32) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<32, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<32, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<32, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<32, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 33) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<33, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<33, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<33, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<33, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 34) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<34, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<34, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<34, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<34, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 35) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<35, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<35, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<35, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<35, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 36) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<36, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<36, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<36, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<36, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }  else if (filterSize == 37) {
                if (checkOutputBounds) {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<37, true, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<37, true, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                } else {
                    if (stride == 1) {
                        conv3_bw_fit_16x16<37, false, 1><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    } else {
                        conv3_bw_fit_16x16<37, false, 3><<<grid, threads>>>(images, filters, targets, imgSize, numFilters);
                    }
                }
            }
        }
    }
    cutilCheckMsg("kernel execution failed");
}

void convolve3_bw(NVMatrix* images, NVMatrix* filters, NVMatrix* targets) {
    int numFilters = filters->getNumRows();
    int numCases = images->getNumRows();
    assert(images->getNumCols() % numFilters == 0);
//    assert(filters->getNumCols() % numFilters == 0);
    int imgPixels = images->getNumCols() / numFilters;
    int filterPixels = filters->getNumCols();
    assert(sqrt(double(imgPixels)) == floor(sqrt(double(imgPixels))));
    assert(sqrt(double(filterPixels)) == floor(sqrt(double(filterPixels))));
    int imgSize = int(sqrt(double(imgPixels)));
    int filterSize = int(sqrt(double(filterPixels)));

    int numOutputsX = imgSize - filterSize + 1;
    int numOutputs = numOutputsX * numOutputsX;

    assert(targets->getNumElements() == numOutputs * numCases);
    assert(!images->isTrans());
    assert(!filters->isTrans());
    assert(!targets->isTrans());
    assert(imgSize > filterSize);

//    printf("computed numcases: %d, numfilters: %d, imgsize: %d, filtersize: %d\n", numCases, numFilters, imgSize, filterSize);
    _convolve3_bw(images->getDevData(), filters->getDevData(), targets->getDevData(),
                 numCases, numFilters, imgSize, filterSize, 1);
}

void convolve3_color(NVMatrix* images, NVMatrix* filters, NVMatrix* targets) {
    int numFilters = filters->getNumRows();
    int numCases = images->getNumRows();
    assert(images->getNumCols() % numFilters == 0);
//    assert(filters->getNumCols() % numFilters == 0);
    int imgPixels = images->getNumCols() / numFilters;
    assert(filters->getNumCols() % 3 == 0);
    int filterPixels = filters->getNumCols() / 3;
    assert(sqrt(double(imgPixels)) == floor(sqrt(double(imgPixels))));
    assert(sqrt(double(filterPixels)) == floor(sqrt(double(filterPixels))));
    int imgSize = int(sqrt(double(imgPixels)));
    int filterSize = int(sqrt(double(filterPixels)));

    int numOutputsX = imgSize - filterSize + 1;
    int numOutputs = numOutputsX * numOutputsX;

    assert(targets->getNumElements() == 3*numOutputs * numCases);
    assert(!images->isTrans());
    assert(!filters->isTrans());
    assert(!targets->isTrans());
    assert(imgSize > filterSize);

//    printf("computed numcases: %d, numfilters: %d, imgsize: %d, filtersize: %d\n", numCases, numFilters, imgSize, filterSize);
    _convolve3_bw(images->getDevData(), filters->getDevData(), targets->getDevData(),
                 numCases*3, numFilters, imgSize, filterSize, 3);
}

