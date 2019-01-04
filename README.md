# WindAndTrees_Wytham
Scripts used to calculate critical wind speeds from simulations and create graphs for paper on Wytham Woods

![alt text](https://github.com/TobyDJackson/WindAndTrees_Wytham/blob/master/Trees%20colored%20by%20CWS.tif)

This repo contains the key scripts and data used to make the graphs for the paper 'A new architectural understanding on wind damage in a natural forest'

The folder 'Data' contains all the summary data in .mat format.
The script OneHa_Full makes most of the figures and contains all the statistics. 
The Phenology script makes Figure 6.
Figure 1 and the strain data analysis is not in this repo, see WindAndTrees_StrainDataProcessing.

The excel file is not necessary, all the data is in the .mat files, it is just a chance to get an overview of the data. 

The folder 'Background' contains the import scripts and the script I used to read in results from finite element analysis. 
If you want to run the finite element analysis you would first need to download the QSMs 
from Calders et al 2018 'Realistic Forest Stand Reconstruction from Terrestrial LiDAR for Radiative Transfer Modelling'
Next you would need to set up and run the finite element analysis using the functions in my other repo WindAndTrees_FEM. 
Then you would be able to use the script Import_Simulations_QSMs as a template to read in and arrange the data into the same format as in 'Data'.
If you are intending to do this please contact me at tobydjackson@gmail.com and I will be happy to help.

