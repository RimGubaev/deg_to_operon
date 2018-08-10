# DEGs_to_operons.r
Rim Gubaev, 2017

DEGs_to_operons.r script performs classification of differentially expresed genes (DEGs) into operons and counting for DEGs located within operons the following metrics: mean, SD, median, IQR. The Log2FC values are used in order to estimate abovementioned metrics. This script also allows visualization of differentially expressed genes located within operons as boxplot.

Example includes following data:

Input:

1) "operons.opr" table that contains information on *Pectobacterium atrosepticum* genes classified into operons according to [DOOR2 database](http://csbl.bmb.uga.edu/DOOR/).
 
2) "DEGs_within_operons.csv" table produced by edgeR. The table contains information (LogFC-, FDR-values) for Pectobacterium atrosepticum genes. NOTE! Example table contains only differentially expressed genes (DEGs) that passed the following filter: |Log2FC| > 1, FDR < 0.05.

Output:

1) "DEGs_within_operons.csv" table contains the operon IDs with assigned metrics (mean, SD, median, IQR) calculated for Log2FC values of DEGs located within a particular operon.

2) "DEGs_within_operons.png" boxplot reflects median level and corresponding IQR value of DEGs located within each operon.

Boxplot example:
![](https://github.com/RimGubaev/deg_to_operon/blob/master/DEGs_within_operons.png)

Email:	rimgubaev@gmail.com

Literature: [Gorshkov, V., Gubaev, R., Petrova, O., Daminova, A., Gogoleva, N., Ageeva, M., ... & Gogolev, Y. (2018). Transcriptome profiling helps to identify potential and true molecular switches of stealth to brute force behavior in Pectobacterium atrosepticum during systemic colonization of tobacco plants. European Journal of Plant Pathology, 1-20.](https://doi.org/10.1007/s10658-018-1496-6)
