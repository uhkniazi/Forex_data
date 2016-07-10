# Name: plot_month.R
# Auth: u.niazi@imperial.ac.uk
# Date: 10/07/2016
# Desc: download and plot the monthly data for currency

library(downloader)

url = 'http://www.histdata.com/download-free-forex-data/?/ascii/1-minute-bar-quotes'
# browse the url to choose a dataset to download
browseURL(url)

dir.create('Data_external', showWarnings = T)
dir.create('Data_external/Downloads')
f = file.choose()
# copy file to downloads 
cmd = paste('mv', f, 'Data_external/Downloads/')
system(cmd, intern = F)
system('unzip Data_external/Downloads/*.zip -d Data_external/Downloads/')
system('rm Data_external/Downloads/*.zip')
# load the data
dfData = read.csv(file.choose(), header = F, sep = ';')

x = dfData$V2
plot.ts(x)

# split the monthly data into bins i.e. days
iDays = 30
i = round(length(x)/iDays, 0)
fDays = ceiling(seq_along(x)/i)
table(fDays)
lDays = split(x, fDays)
# batch means
x.batch = sapply(lDays, mean)

plot.ts(x.batch, ylab='Exchange', xaxt='n')
axis(1, seq_along(x.batch), cex.axis=0.6)