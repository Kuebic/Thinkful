# Project Summary

## Purpose
Taking data from the [Lending Club](https://www.lendingclub.com/), a US peer-to-peer lending company, and using unsupervised Clustering Techniques, we grouped users of similar habits together to assess their risk level.

## Results
The following is a 3D visual representation of the users clustered and some of the groups we identified.

[cluster_umap]: /images/DimensionalityReductionWithUMAP_01.png "Dimensionality Reduction with UMAP"
[cluster_tsne]: /images/DimensionalityReductionWithTSNE_01.png "Dimensionality Reduction with TSNE"
[cluster_pca]: /images/DimensionalityReductionWithPCA_01.png "Dimensionaltiy Reduction with PCA"
[cluster_color]: /images/HDBScan_with_TSNE.png "Clustering visualization with TSNE"

[cluster_01]: /images/cluster_01.png "Cluster 01"
[cluster_11]: /images/cluster_11.png "Cluster 11"
[cluster_12]: /images/cluster_12.png "Cluster 12"

![cluster_color]

### Example Clusters

#### **The Interest User**

The cluster is for people who pays a lot of interest, essentially due to high loans amount and late payments.

![cluster_01]

#### **The Broke-With-Debt User**

This cluster of 5 users has the highest DTI (Debt-to-Income) ratio, unsurprisingly with abysmal annual income.

![cluster_11]

#### **The Aggressive Repayer User**

This cluster gets higher-than average loans, pays off the principle quickly with a lump sum on final payment.

![cluster_12]

# Tech

- <img src=https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Python-logo-notext.svg/110px-Python-logo-notext.svg.png width="15" height="15" /> — **Python**

- <img src=https://pandas.pydata.org/static/img/pandas_mark.svg width="15" height="15" /> — **Pandas**

- <img src=https://scikit-learn.org/stable/_images/scikit-learn-logo-notext.png width="27" height="15" /> — **Scikit-learn**

- <img src=https://upload.wikimedia.org/wikipedia/commons/3/38/Jupyter_logo.svg width="15" height="20" /> — **Jupyter**

## Techniques

- [**FastCluster**](http://www.danifold.net/fastcluster.html)

- [**HDBScan**](https://hdbscan.readthedocs.io/en/latest/index.html)

- [**PCA**](https://www.shark-ml.org/sphinx_pages/build/html/rest_sources/tutorials/algorithms/pca.html)

- [**UMAP**](https://umap-learn.readthedocs.io/en/latest/#)