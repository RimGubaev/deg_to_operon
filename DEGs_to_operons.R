# Set your working directory
# setwd("~/your/working/directory/")

# Plug in the necessary libraries
library("dplyr")
library("ggplot2")

# Upload the classification of Pectobacterium atrosepticum genes into operons according to information obtained from DOOR2 database (http://csbl.bmb.uga.edu/DOOR/)
operons <- read.csv(file = "operons.opr", sep = "\t")
operons$OperonID <- as.character(operons$OperonID) # This is a necessary for further plotting

# Upload gene expression data for Pectobacterium atrosepticum
# NOTE! Example table contains only differentially expressed genes (DEGs) that passed the following filter: |Log2FC| > 1, FDR < 0.05
DEGs_list <- read.csv(file = "DEGs_list.csv", sep = "\t")

# Attache operon classification to gene expression data
DEGs_list <- merge(DEGs_list, operons, by = "ECA", all.x = T)

# Select the operons that contain 3 or more DEGs
DEGs_list <-  DEGs_list[DEGs_list$OperonID %in%  names(table(DEGs_list$OperonID))[table(DEGs_list$OperonID) >2] , ]

# Aggregate gene expression levels for each operron and count mean, SD, median, IQR metrics.
  DEGs_within_operons <- DEGs_list %>% group_by(OperonID) %>% 
    summarise(Mean_logFC=mean(logFC, na.rm =T), Std_logFC=sd(logFC, na.rm =T), 
              Median_logFC=median(logFC, na.rm =T), IQR_LogFC=IQR(logFC, na.rm =T))

# Find DEGs that belong to each operon
# Plug in the ""plyr library
library("plyr")
opr_names <-  ddply(DEGs_list, .(OperonID), summarize, content_concatenated = paste(ECA, collapse = "; "))

# Attache the list of DEGs for each operon
DEGs_within_operons <- merge(DEGs_within_operons, opr_names, by = "OperonID")

# Write the results into table
write.table(DEGs_within_operons, "DEGs_within_operons.csv", sep = ",", row.names = F, quote = F)

# Create and save the plot into variable
operon_plot <- ggplot(DEGs_list) +
geom_boxplot(aes(x=OperonID, y=logFC), outlier.colour="black", varwidth = F)+
theme_classic() +
  theme(axis.text.x = element_text(face="bold", color="Black", 
                                   size=14, angle = 45, hjust = 0.99),
        axis.text.y = element_text(face="bold", color="Black", 
                                   size=14))+
  xlab("Operon ID")+
  ylab("Expression level, Log2FC")+
  theme(axis.title = element_text(color="black", face="bold", size=15))

#save plot in png format into working directory
png(filename="DEGs_within_operons.png", width = 1200, height = 600)
plot(operon_plot)
dev.off()


