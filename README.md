# ZFunc
My Personal Matlab Functions for Computer Vision Research
# Notations
All the implementation, if not specified, will follow the notations in Element of Statistical Learning. In word, data matrix will be of the size n by p where n is the number of samples(observations) and p is the number of features for each observation. 


#Some notes on implementation

##PCA:
  0 mean and standard deviation 1 on columns. But for some cases when they are already scaled or we really need the scale information (if the column data are from the same measure protocols) We may need not to standardize them.
So there should be choices for : standardization

**You may also need to compute the PVE**



# Installation:
Directly run Zj_Setup.m
# Functions:
### Normalization:
Different norms for either matrix by row or a vecotr
