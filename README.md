# WindAndTrees_Wytham
This repo contains the key scripts and data used to make the graphs for the paper 'A new architectural understanding on wind damage in a natural forest'

![alt text](https://github.com/TobyDJackson/WindAndTrees_NaturalFrequencies/blob/master/figures/fig1.png)

The folder 'Data' contains all the summary data in .mat format.
The script OneHa_Full makes most of the figures and contains all the statistics. 
The Phenology script makes Figure 6.
Figure 1 and the strain data analysis is not in this repo, see WindAndTrees_StrainDataProcessing.

The excel file is not necessary, all the data is in the .mat files, it is just a chance to get an overview of the data. 

The folder 'Background' contains the import scripts and the script I used to read in results from finite element analysis. 
If you want to run the finite element analysis you would first need to download the QSMs 
from Calders et al 2018 'Realistic Forest Stand Reconstruction from Terrestrial LiDAR for Radiative Transfer Modelling'
Next you would need to set up the finite element analysis using the functions in my other repo WindAndTrees_FEM and run it in Abaqus. 
Then you can use the script Import_Simulations_QSMs as a template to read in and arrange the data into the same format as in 'Data'.
